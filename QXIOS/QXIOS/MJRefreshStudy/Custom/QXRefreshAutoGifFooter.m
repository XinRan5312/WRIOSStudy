//
//  QXRefreshAutoGifFooter.m
//  QXIOS
//
//  Created by 新然 on 2017/5/16.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import "QXRefreshAutoGifFooter.h"

@implementation QXRefreshAutoGifFooter

-(void)prepare{
    [super prepare];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];

}

@end
