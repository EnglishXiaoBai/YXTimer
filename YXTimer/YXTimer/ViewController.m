//
//  ViewController.m
//  YXTimer
//
//  Created by 123456 on 2020/3/8.
//  Copyright © 2020 123456. All rights reserved.
//

#import "ViewController.h"
#import "YXTimer.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // Do any additional setup after loading the view.
}
#pragma mark - 开始（tag 1）、暂停（tag 2）、继续（tag 3）
- (IBAction)buttonClick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 1:
            [self startTimer];
            break;
            
        case 2:
            [[YXTimer sharedInstance] supendTime];
            break;
        case 3:
            [[YXTimer sharedInstance] continueTime];
            break;
            
        default:
            break;
    }
    
}

- (void)startTimer{
    [[YXTimer sharedInstance] timerCountDownWithType:10 block:^(NSInteger num) {
        if (num == 0) {
            self.timeLabel.text = @"";
        }
        else {
            self.timeLabel.text = [NSString stringWithFormat:@"%ld 秒",num];
        }
    }];
}

@end
