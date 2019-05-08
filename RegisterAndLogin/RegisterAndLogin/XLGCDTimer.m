//
//  XLGCDTimer.m
//  GCD定时器
//
//  Created by kjhd on 16/12/14.
//  Copyright © 2016年 kjhd. All rights reserved.
//

#import "XLGCDTimer.h"
@interface XLGCDTimer()

/**
 *     标
 */
@property (nonatomic, strong)dispatch_source_t _timer;

@end
@implementation XLGCDTimer
-(void)startButton:(UIButton *)button Time:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle backColor:(UIColor *)backColor textColor:(UIColor *)textColor{
    __block NSInteger timeOut=timeout; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(__timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(__timer, ^{
        if(timeOut<=0){ //倒计时结束，关闭
            dispatch_source_cancel(__timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [button setTitle:tittle forState:UIControlStateNormal];
                button.userInteractionEnabled = YES;
                button.backgroundColor=backColor;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeOut % 60;
       //     NSLog(@"计时器：%d",seconds);
            NSString *strTime =  [NSString stringWithFormat:@"%.2d", seconds];
            if (seconds<10) {
                strTime = [NSString stringWithFormat:@"%d", seconds];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [button setTitle:[NSString stringWithFormat:@"(%@s)%@",strTime,waitTittle] forState:UIControlStateNormal];
                button.backgroundColor=backColor;
                button.userInteractionEnabled = NO;
                
            });
            timeOut--;
            
        }
    });
    dispatch_resume(__timer);
}

-(void)stopTimer{
    if(__timer){
        dispatch_source_cancel(__timer);
    }
}

@end
