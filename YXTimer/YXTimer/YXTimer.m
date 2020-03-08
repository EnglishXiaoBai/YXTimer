//
//  YXTimer.m
//  YXTimer
//
//  Created by 123456 on 2020/3/8.
//  Copyright © 2020 123456. All rights reserved.
//

#import "YXTimer.h"
@interface YXTimer()
@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, strong) dispatch_source_t source;
@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation YXTimer

IMP_SINGLETON(YXTimer)

- (void)timerCountDownWithType:(NSInteger)time block:(void (^)(NSInteger num))block{
    
    if (self.source) {
        return;
    }
    // 创建并发队列
    self.queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 创建定时器
    self.source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.queue);
    // 设置定时器的各种属性（几时开始任务，每隔多长时间执行一次）
    /**
     dispatch_source_set_timer 中第二个参数，当我们使用dispatch_time 或者 DISPATCH_TIME_NOW时，系统会使用默认时钟来进行计时。然而当系统休眠的时候，默认时钟是不走的，也就会导致计时器停止。使用 dispatch_walltime 可以让计时器按照真实时间间隔进行计时。
     dispatch_source_set_timer 的第四个参数 leeway 指的是一个期望的容忍时间，将它设置为 1 秒，意味着系统有可能在定时器时间到达的前 1 秒或者后 1 秒才真正触发定时器。在调用时推荐设置一个合理的 leeway 值。需要注意，就算指定 leeway 值为 0，系统也无法保证完全精确的触发时间，只是会尽可能满足这个需求。

     */
    dispatch_source_set_timer(self.source, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    
    // 设置时间
    self.timeInterval = time;
    // 设置回调
    dispatch_source_set_event_handler(self.source, ^{
        self.timeInterval -= 1;
        if (self.timeInterval <= 0) {
            [self cancelTime];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            block(self.timeInterval);
        });
        
    });
    
    // 启动定时器
    dispatch_resume(self.source);
}

// 继续
- (void)continueTime{
    if (self.source) {
        dispatch_resume(self.source);
        dispatch_resume(self.queue);
    }
}

// 暂停
- (void)supendTime{
    if (self.source) {
        dispatch_suspend(self.source);
        dispatch_suspend(self.queue);// mainqueue 挂起
    }
}

// 取消
- (void)cancelTime{
    if (self.source) {
        dispatch_source_cancel(self.source);
        self.source = nil;
    }
}

@end
