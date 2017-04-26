//
//  UIColor+StringColor.h
//  QXIOS
//
//  Created by 新然 on 2017/4/26.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (StringColor)
/**
 *  16进制转UIColor
 * */
+ (UIColor *)colorFromHexStr:(NSString *)color;

@end
