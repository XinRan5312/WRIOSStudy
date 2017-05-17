//
//  QXWindow.m
//  QXIOS
//
//  Created by 新然 on 2017/5/16.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import "QXWindow.h"
#import "QXTempViewController.h"

@implementation QXWindow
static UIWindow *window_;
+ (void)show
{
    window_ = [[UIWindow alloc] init];
    CGFloat width = 150;
    CGFloat x = [UIScreen mainScreen].bounds.size.width - width - 10;
    window_.frame = CGRectMake(x, 0, width, 25);
    window_.windowLevel = UIWindowLevelAlert;
    window_.hidden = NO;
    window_.alpha = 0.5;
    window_.rootViewController = [[QXTempViewController alloc] init];
    window_.backgroundColor = [UIColor clearColor];
}

@end
