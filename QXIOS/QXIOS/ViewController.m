//
//  ViewController.m
//  QXIOS
//
//  Created by 新然 on 2017/4/21.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//一下是各种动画的练习

//- (IBAction)commAnimation:(id)sender {
//    [UIView beginAnimations:@"Common"context:nil];
//    [UIView setAnimationDelay:1];
//    [UIView setAnimationDuration:1.0];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationRepeatCount:2];
//    [UIView setAnimationWillStartSelector:@selector(startAni:)];
//    [UIView setAnimationDidStopSelector:@selector(stopAni:)];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//    //  self.mImagView.frame=self.mTextView.frame; 更改中心就是移动
//    //      self.mImagView.bounds=self.view.bounds;  更改bounds
//    // self.mImagView.backgroundColor=[UIColor redColor];更改背景颜色
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.mImagView cache:YES];//旋转或者翻页效果动画
//    
//    [UIView commitAnimations];
//    //    [UIView transitionWithView:_mCommBtn duration:2 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationTransitionCurlDown animations:^{
//    //        self.mImagView.hidden=NO;
//    //    } completion:^(BOOL finished) {
//    //
//    //    }];
//    
//    
//    [UIView transitionFromView:_mTextView toView:_mImagView duration:2 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationTransitionCurlDown completion:nil];
//}
//- (IBAction)blockAnimation:(id)sender {
//    //    [UIView animateWithDuration:1.0f delay:1 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationTransitionFlipFromRight
//    //                     animations:^{
//    //                         self.mLable.frame=CGRectMake(0, 0, 300, 200);
//    //
//    //    } completion:^(BOOL finished) {
//    //        NSLog(@"动画完成");
//    //    }];
//    
//    [UIView animateWithDuration:2.0f delay:0.5f usingSpringWithDamping:0.5 initialSpringVelocity:0.25 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        CGFloat orX=self.mTextView.center.x;
//        CGFloat orY=self.mTextView.center.y;
//        [self.mTextView setCenter:CGPointMake(orX+100, orY+100)];
//        
//        self.mLable.alpha=0.25;
//        self.mImagView.transform=CGAffineTransformScale(self.mImagView.transform, 0.5, 0.5);
//        
//    } completion:^(BOOL finished) {
//        NSLog(@"第一个动画完毕");
//    } ];
//}
//
//- (IBAction)springAnimation:(id)sender {
//    
//    //    [UIView animateWithDuration:1.0f delay:1 usingSpringWithDamping:0.2 initialSpringVelocity:0.3 options:<#(UIViewAnimationOptions)#> animations:<#^(void)animations#> completion:<#^(BOOL finished)completion#>]
//    
//    
//}
//- (IBAction)zhuanChangAnimation:(id)sender {
//    [UIView transitionWithView:self.mTextView duration:1 options:UIViewAnimationTransitionCurlDown animations:^{
//        
//    } completion:^(BOOL finished) {
//        
//    }];
//}
//- (IBAction)framesAnimation:(id)sender {
//    //    self.mImagView.image=nil;
//    //    [UIView animateKeyframesWithDuration:9.0 delay:0.f options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
//    //        [UIView addKeyframeWithRelativeStartTime:0.f relativeDuration:1.0/4 animations:^{
//    //            self.mImagView.backgroundColor=[UIColor colorWithRed:0.9475 green:0.1921 blue:0.1746 alpha:1.0];
//    //        }];
//    //        [UIView addKeyframeWithRelativeStartTime:1.0/4 relativeDuration:1.0/4 animations:^{
//    //            self.mImagView.backgroundColor=[UIColor colorWithRed:0.1064 green:0.6052 blue:0.0334 alpha:1.0];
//    //        }];
//    //        [UIView addKeyframeWithRelativeStartTime:2.0/4 relativeDuration:1.0/4 animations:^{
//    //            self.mImagView.backgroundColor=[UIColor colorWithRed:0.1366 green:0.3017 blue:0.8411 alpha:1.0];
//    //        }];
//    //        [UIView addKeyframeWithRelativeStartTime:3.0/4 relativeDuration:1.0/4 animations:^{
//    //            self.mImagView.backgroundColor=[UIColor colorWithRed:0.619 green:0.037 blue:0.6719 alpha:1.0];
//    //        }];
//    //    }completion:^(BOOL finished){
//    //        NSLog(@"动画结束");
//    //    }];
//    CGFloat orX=self.mLable.center.x;
//    CGFloat orY=self.mLable.center.y;
//    CGPoint orCenter=self.mLable.center;
//    [UIView animateKeyframesWithDuration:2 delay:0.5 options:UIViewKeyframeAnimationOptionRepeat animations:^{
//        
//        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.25 animations:^{
//            [self.mLable setCenter:CGPointMake(orX+80, orY-20)];
//        }];
//        
//        [UIView addKeyframeWithRelativeStartTime:0.15 relativeDuration:0.4 animations:^{
//            self.mLable.transform=CGAffineTransformMakeRotation(-M_PI_4/2);
//        }];
//        
//        [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.35 animations:^{
//            [self.mLable setCenter:CGPointMake(orX+100, orY-50)];
//            self.mLable.alpha=0;
//        }];
//        
//        [UIView addKeyframeWithRelativeStartTime:0.55 relativeDuration:0.05 animations:^{
//            self.mLable.transform=CGAffineTransformIdentity;
//            [self.mLable setCenter:CGPointMake(0, orY)];
//        }];
//        [UIView addKeyframeWithRelativeStartTime:0.65 relativeDuration:0.5 animations:^{
//            self.mLable.alpha=1.0;
//            self.mLable.center=orCenter;
//        }];
//        
//    } completion:^(BOOL finished) {
//        
//    }];
//    
//    
//}
//- (IBAction)otherAnimation:(id)sender {
//}
//
//-(void)startAni:(NSString*)aniID{
//    NSLog(@"%@start",aniID);
//}
//-(void)stopAni:(NSString*)aniID{
//    NSLog(@"%@stop",aniID);
//}
//

@end
