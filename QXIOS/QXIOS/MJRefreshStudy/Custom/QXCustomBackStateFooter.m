//
//  QXCustomBackStateFooter.m
//  QXIOS
//
//  Created by 新然 on 2017/5/17.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import "QXCustomBackStateFooter.h"


@interface QXCustomBackStateFooter()
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UISwitch *s;
@property (weak, nonatomic) UIImageView *logo;
@property (weak, nonatomic) UIActivityIndicatorView *loading;
@end

@implementation QXCustomBackStateFooter
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    //在空闲的时候点击会刷新
    self.label.userInteractionEnabled=true;
    [self.label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateLabelClick1)]];

    
    // 打酱油的开关
    UISwitch *s = [[UISwitch alloc] init];
    [self addSubview:s];
    self.s = s;
    
    // logo
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:logo];
    self.logo = logo;
    
    // loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loading = loading;
}
- (void)stateLabelClick1
{
    if (self.state == MJRefreshStateIdle) {
        [self beginRefreshing];
    }
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.label.frame = self.bounds;
    
    self.logo.bounds = CGRectMake(0, 0, self.bounds.size.width, 100);
    self.logo.center = CGPointMake(self.mj_w * 0.5, self.mj_h + self.logo.mj_h * 0.5);
    
    self.loading.center = CGPointMake(self.mj_w - 30, self.mj_h * 0.5);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
//因为是直接继承的MJRefreshBackFooter不是继承的MJRefreshBackStateFooter所以这个方法也要重写
- (void)setState:(MJRefreshState)state
{
    /**
     在MJRefreshCons.h中定义了这个宏
     // 状态检查
     #define MJRefreshCheckState \
     MJRefreshState oldState = self.state; \
     if (state == oldState) return; \
     [super setState:state];
     */
    MJRefreshCheckState;
    

    
    switch (state) {
        case MJRefreshStateIdle:
            [self.loading stopAnimating];
            [self.s setOn:NO animated:YES];
            self.label.text = @"赶紧上拉吖(开关是打酱油滴)";
            break;
        case MJRefreshStatePulling:
            [self.loading stopAnimating];
            [self.s setOn:YES animated:YES];
            self.label.text = @"赶紧放开我吧(开关是打酱油滴)";
            break;
        case MJRefreshStateRefreshing:
            [self.loading startAnimating];
            [self.s setOn:YES animated:YES];
            self.label.text = @"加载数据中(开关是打酱油滴)";
            break;
        case MJRefreshStateNoMoreData:
            [self.loading stopAnimating];
            self.label.text = @"木有数据了(开关是打酱油滴)";
            [self.s setOn:NO animated:YES];
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
    CGFloat red = 1.0 - pullingPercent * 0.5;
    CGFloat green = 0.5 - 0.5 * pullingPercent;
    CGFloat blue = 0.5 * pullingPercent;
    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
