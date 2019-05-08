//
//  XLGCDTimer.h
//  GCD定时器
//
//  Created by kjhd on 16/12/14.
//  Copyright © 2016年 kjhd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface XLGCDTimer : NSObject
-(void)startButton:(UIButton *)button Time:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle backColor:(UIColor *)backColor textColor:(UIColor *)textColor;

-(void)stopTimer;


@end
