//
//  QXTempViewController.h
//  QXIOS
//
//  Created by 新然 on 2017/5/16.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QXTempViewController : UIViewController

+ (instancetype)sharedInstance;

@property (assign, nonatomic) UIStatusBarStyle statusBarStyle;
@property (assign, nonatomic) BOOL statusBarHidden;
@end
