//
//  YXTimer.h
//  YXTimer
//
//  Created by 123456 on 2020/3/8.
//  Copyright © 2020 123456. All rights reserved.
//

#import <Foundation/Foundation.h>

#undef    DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef    IMP_SINGLETON
#define IMP_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static __class * __singleton__; \
static dispatch_once_t onceToken; \
dispatch_once( &onceToken, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

NS_ASSUME_NONNULL_BEGIN

@interface YXTimer : NSObject
//- (instancetype)initWithTimeInterval:(NSInteger) TimeInterval block:(void (^)(NSInteger timerNum))block;
DEF_SINGLETON(YXTimer)
- (void)startTime;

- (void)supendTime;

- (void)continueTime;

- (void)cancelTime;
- (void)timerCountDownWithType:(NSInteger)time block:(void (^)(NSInteger num))block;

@end

NS_ASSUME_NONNULL_END
