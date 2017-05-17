//
//  QXRefreshGifHeader.h
//  QXIOS
//
//  Created by 新然 on 2017/5/16.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import "QXRefreshStateHeader.h"

@interface QXRefreshGifHeader : QXRefreshStateHeader
@property (weak, nonatomic, readonly) UIImageView *gifView;

/** 设置state状态下的动画图片images 动画持续时间duration*/
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration;

@end
