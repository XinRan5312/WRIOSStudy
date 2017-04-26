//
//  ViewController.m
//  QXIOS
//
//  Created by 新然 on 2017/4/21.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import "ViewController.h"
#import "QXWaveControllerViewController.h"
#import "UIColor+StringColor.h"

@interface ViewController (){
    CATextLayer *textLayer;
    CAGradientLayer *gradientLayer;
    UIView* bgView;
}
@end

@implementation ViewController
- (IBAction)gotoWaveCotroller:(id)sender {
    
    [self presentViewController:[[QXWaveControllerViewController alloc] init] animated:YES completion:nil];
    NSLog(@"进入跳转了");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   // [self testCALayers];
    [self testCAGradientLayer];
    
}
//CATextLayer和CAGradientLayer结合动画的使用

-(void)testCAGradientLayer{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame=CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40);
    [btn setTitle:@"开始动画" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    btn.frame=CGRectMake((self.view.frame.size.width-200)/2, self.view.frame.size.width+100, 200, 40);
     [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.width)];
    bgView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:bgView];
    
    textLayer = [CATextLayer layer];
    textLayer.frame = CGRectMake((bgView.frame.size.width - 200)/2, (bgView.frame.size.width - 200)/2, 200, 200);
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode =kCAAlignmentJustified;
    textLayer.wrapped =YES;
    UIFont *font = [UIFont systemFontOfSize:30];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef =CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    NSString *text =@"敬业 忠诚 奉献 守信 开拓 创新 立志 图强";
    textLayer.string = text;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [bgView.layer addSublayer:textLayer];
    
    //创建背景图层
    gradientLayer =  [CAGradientLayer layer];
    //自己分类了UIColor (StringColor)使其具有把六进制直接转换为UIColor的功能
    [gradientLayer setColors:[NSArray arrayWithObjects:[UIColor colorFromHexStr:@"0x000000"].CGColor,
                              [UIColor colorFromHexStr:@"0xFFD700"].CGColor,
                              [UIColor colorFromHexStr:@"0x000000"].CGColor,
                              [UIColor colorFromHexStr:@"0xFFD700"].CGColor,
                              [UIColor colorFromHexStr:@"0x000000"].CGColor,
                              [UIColor colorFromHexStr:@"0xFFD700"].CGColor,
                              [UIColor colorFromHexStr:@"0x000000"].CGColor,
                              [UIColor colorFromHexStr:@"0xFFD700"].CGColor,
                              [UIColor colorFromHexStr:@"0x000000"].CGColor,
                              [UIColor colorFromHexStr:@"0xFFD700"].CGColor,
                              [UIColor colorFromHexStr:@"0x000000"].CGColor,
                              [UIColor clearColor].CGColor,
                              nil]];
    gradientLayer.frame = bgView.bounds;
    [gradientLayer setLocations:[NSArray arrayWithObjects:
                                 [NSNumber numberWithFloat:0.0],
                                 [NSNumber numberWithFloat:0.1],
                                 [NSNumber numberWithFloat:0.2],
                                 [NSNumber numberWithFloat:0.3],
                                 [NSNumber numberWithFloat:0.4],
                                 [NSNumber numberWithFloat:0.5],
                                 [NSNumber numberWithFloat:0.6],
                                 [NSNumber numberWithFloat:0.7],
                                 [NSNumber numberWithFloat:0.8],
                                 [NSNumber numberWithFloat:0.9],
                                 [NSNumber numberWithFloat:1.0],
                                 nil]];
    
    [gradientLayer setStartPoint:CGPointMake(0, 0)];
    [gradientLayer setEndPoint:CGPointMake(1, 1)];
    [gradientLayer setMask:textLayer]; //用progressLayer来截取渐变层
    [bgView.layer addSublayer:gradientLayer];

}

- (void)clickBtn{
    
    //两者都移动 由于两者的父布局都是bgView 所以给人的错觉就是都不移动 实现闪烁的动画
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    CGPoint fromPoint = textLayer.position;
    CGPoint toPoint = CGPointMake(fromPoint.x + (bgView.frame.size.width - 200)/2, fromPoint.y);
    animation.duration = 1;
    animation.fromValue = [NSValue valueWithCGPoint:fromPoint];
    animation.toValue = [NSValue valueWithCGPoint:toPoint];
    animation.autoreverses = YES;
    animation.repeatCount=100;
    [textLayer addAnimation:animation forKey:nil];
    
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    CGPoint fromPoint2 = gradientLayer.position;
    CGPoint toPoint2 = CGPointMake(fromPoint.x - (bgView.frame.size.width - 200)/2, fromPoint.y);
    animation2.duration = 1;
    animation2.fromValue = [NSValue valueWithCGPoint:fromPoint2];
    animation2.toValue = [NSValue valueWithCGPoint:toPoint2];
    animation2.autoreverses = YES;
    animation2.repeatCount=100;
    [gradientLayer addAnimation:animation2 forKey:nil];
    
//    //动画
//    CADisplayLink *dispalyLink=[CADisplayLink displayLinkWithTarget:self selector:@selector(animationContent)];
//    [dispalyLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    
}
-(void)animationContent{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    CGPoint fromPoint = textLayer.position;
    CGPoint toPoint = CGPointMake(fromPoint.x + (bgView.frame.size.width - 200)/2, fromPoint.y);
    animation.duration = 1;
    animation.fromValue = [NSValue valueWithCGPoint:fromPoint];
    animation.toValue = [NSValue valueWithCGPoint:toPoint];
    animation.autoreverses = YES;
    animation.repeatCount=100;
    [textLayer addAnimation:animation forKey:nil];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    CGPoint fromPoint2 = gradientLayer.position;
    CGPoint toPoint2 = CGPointMake(fromPoint.x - (bgView.frame.size.width - 200)/2, fromPoint.y);
    animation2.duration = 1;
    animation2.fromValue = [NSValue valueWithCGPoint:fromPoint2];
    animation2.toValue = [NSValue valueWithCGPoint:toPoint2];
    animation2.autoreverses = YES;
     animation2.repeatCount=100;
    [gradientLayer addAnimation:animation2 forKey:nil];
}

//对CAShapeLayer和对CATextLayer的练习
-(void) testCALayers{
    CAShapeLayer *shapeLayer=[CAShapeLayer layer];
    shapeLayer.lineWidth=3;
    shapeLayer.strokeColor=[UIColor blueColor].CGColor;
    UIBezierPath *bezierPath=[UIBezierPath bezierPathWithRect:CGRectMake(100, 200, 200, 200)];//正方形
    UIBezierPath *pathRoundRect=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 200, 200, 200) cornerRadius:5];//倒角方形
    UIBezierPath *ciclePath=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 200, 100)];
    shapeLayer.path=ciclePath.CGPath;//这样会有默认的黑色填充色，正方形里面都是黑色
    shapeLayer.fillColor=[UIColor clearColor].CGColor;//设置自己想要的内部填充色
    
    [self.view.layer addSublayer:shapeLayer];
    
    CAShapeLayer *shaperLayer1=[CAShapeLayer layer];
    shaperLayer1.lineWidth=2;
    shaperLayer1.strokeColor=[UIColor redColor].CGColor;
    shaperLayer1.fillColor=[UIColor blueColor].CGColor;
    //左上角和右下角倒角的长方形，倒角半径是50
    UIBezierPath *roundPath=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 220, 200, 100) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(50, 50)];
    shaperLayer1.path=roundPath.CGPath;
    [self.view.layer addSublayer:shaperLayer1];
    
    CAShapeLayer *shaperLayer2=[CAShapeLayer layer];
    shaperLayer2.lineWidth=2;
    shaperLayer2.strokeColor=[UIColor yellowColor].CGColor;
    shaperLayer2.fillColor=[UIColor redColor].CGColor;
    //分别表示圆点 圆弧半径 圆弧起点和终点 是否是顺时针方向链接起点和终点
    UIBezierPath *pathArc=[UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 390) radius:50 startAngle:0 endAngle:M_PI+M_PI_2 clockwise:YES];
    shaperLayer2.path=pathArc.CGPath;
    [self.view.layer addSublayer:shaperLayer2];
    
    //画线
    CAShapeLayer *shapeLayer3=[CAShapeLayer layer];
    shapeLayer3.lineWidth=2;
    shapeLayer3.strokeColor=[UIColor greenColor].CGColor;
    
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    
    //把画笔起点移动到CGPointMake(100, 500)
    [linePath moveToPoint:CGPointMake(100, 500)];
    
    [linePath addLineToPoint:CGPointMake(110, 490)];
    [linePath addLineToPoint:CGPointMake(120, 480)];
    [linePath addLineToPoint:CGPointMake(130, 450)];
    [linePath addLineToPoint:CGPointMake(150, 410)];
    [linePath addLineToPoint:CGPointMake(170, 450)];
    [linePath addLineToPoint:CGPointMake(190, 420)];
    [linePath addLineToPoint:CGPointMake(220, 450)];
    shapeLayer3.path=linePath.CGPath;
    [self.view.layer addSublayer:shapeLayer3];
    
    //用CATextLayer画文字
    
    CATextLayer *textLayer=[CATextLayer layer];
    textLayer.foregroundColor=[UIColor blueColor].CGColor;
    textLayer.alignmentMode=kCAAlignmentJustified;
    textLayer.wrapped=YES;
    textLayer.frame=CGRectMake(150, 400, 400, 500);
    UIFont *font=[UIFont systemFontOfSize:11];
    CFStringRef fontName=(__bridge CFStringRef)font.fontName;
    CGFontRef fontRef =CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    textLayer.string=@"hello just for test";
    textLayer.contentsScale=[UIScreen mainScreen].scale;//加上这一行字体会清晰好多
    [self.view.layer addSublayer:textLayer];
    //    [shaperLayer2 setMask:textLayer];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)useTimer{
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerDoSelector) userInfo:nil repeats:YES];
    //默认会把NSTimer放入到MainRunLooper中执行
    NSTimer *timer2=[NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(timerDoSelector) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer2 forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] addTimer:timer2 forMode:UITrackingRunLoopMode];
    [[NSRunLoop currentRunLoop] run];//同时让runLoop跑起来
    /**
     两个runLoop分别要在指定的RunLoopMode下才能运行
     
     系统默认注册了5个Mode：
     
     NSDefaultRunLoopMode：App 的默认 Mode，通常主线程是在这个 Mode 下运行(默认情况下运行)
     UITrackingRunLoopMode：界面跟踪 Mode，用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他 Mode 影响(操作 UI 界面的情况下运行)
     UIInitializationRunLoopMode：在刚启动 App 时进入的第一个 Mode，启动完成后就不再使用
     GSEventReceiveRunLoopMode：接受系统事件的内部 Mode，通常用不到(绘图服务)
     NSRunLoopCommonModes：这是一个占位用的 Mode，不是一种真正的 Mode (RunLoop无法启动该模式，设置这种模式下，默认和操作 UI 界面时线程都可以运行，但无法改变 RunLoop 同时只能在一种模式下运行的本质)
     */
    
   // [timer invalidate];释放NSTimer

}
-(void)useCADisplayLink{
    
    CADisplayLink *cADisplayLink=[CADisplayLink displayLinkWithTarget:self selector:@selector(timerDoSelector)];
    [cADisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:UITrackingRunLoopMode];//这样selector就会重复的周期性执行了
    //停止执行
    [cADisplayLink invalidate];
    cADisplayLink=nil;
    

}
-(void)timerDoSelector{
    NSLog(@"NSTimer执行了");
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
