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
//    [self testCAGradientLayer];
    //[self testBezierPath];
    //[self testCABaseAnimation];
    //[self bezierXuan];
    //[self testPathAnimation];
    [self testMaskLayer];
    
}
//练习maskLayer  蒙版

-(void)testMaskLayer{
    CALayer *layer=[CALayer layer];
    layer.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    layer.contents=(__bridge id)[UIImage imageNamed:@"big_one"].CGImage;
    [self.view.layer addSublayer:layer];
    
    CAShapeLayer *maskLayer=[CAShapeLayer layer];
    maskLayer.lineWidth=8;
    maskLayer.strokeColor=[UIColor blueColor].CGColor;
    
//    maskLayer.fillColor=[UIColor clearColor].CGColor;//加上他就没有了中间的只有lineWidth=8
    
    UIBezierPath *bezier=[UIBezierPath bezierPath];
    
    
    [bezier moveToPoint:CGPointMake(200, 150)];
    [bezier addLineToPoint:CGPointMake(220, 170)];
//    [bezier addQuadCurveToPoint:CGPointMake(320, 170) controlPoint:CGPointMake(200, 250)];
//    [bezier addCurveToPoint:CGPointMake(320, 170) controlPoint1:CGPointMake(200, 120) controlPoint2:CGPointMake(280, 250)];
    [bezier addArcWithCenter:CGPointMake(200, 150) radius:169.7 startAngle:M_PI/4 endAngle:M_PI*3/4 clockwise:YES];
    [bezier closePath];
   
    maskLayer.path=bezier.CGPath;
    //添加一个动画
    
    CABasicAnimation *ani=[CABasicAnimation animation];
    ani.keyPath=@"strokeStart";
    ani.fromValue=@0;
    ani.duration=3;
    ani.toValue=@1;
    [maskLayer addAnimation:ani forKey:nil];
    
    layer.mask=maskLayer;
    

}
//练习Layer的path属性的动画现象 结合CABaseAnimation的keyPath属性动画

-(void)testPathAnimation{
    CAShapeLayer *layer=[CAShapeLayer layer];
    layer.lineWidth=3;
    layer.strokeColor=[UIColor yellowColor].CGColor;
    layer.fillColor=[UIColor yellowColor].CGColor;
    
    //上面的path
    UIBezierPath *fromPath=[UIBezierPath bezierPath];
    
    [fromPath moveToPoint:CGPointMake(100, 100)];
    [fromPath addLineToPoint:CGPointMake(100, 350)];
    //这个弧线是从CGPointMake(100, 350)到CGPointMake(400, 350)中间有两个拐点 这样就确定了4个点，最终在这4个点之间华哥弧线
    [fromPath addCurveToPoint:CGPointMake(400, 350) controlPoint1:CGPointMake(200, 300) controlPoint2:CGPointMake(300, 390)];//画一条不规则弧线
    [fromPath addLineToPoint:CGPointMake(400, 100)];
    
    [fromPath closePath];//连接路径的起点和终点 封闭
    
    //下面的path
    UIBezierPath *toPath=[UIBezierPath bezierPath];
    
    [toPath moveToPoint:CGPointMake(100, 100)];
    [toPath addLineToPoint:CGPointMake(100, 600)];
    [toPath addCurveToPoint:CGPointMake(400, 600) controlPoint1:CGPointMake(200, 550) controlPoint2:CGPointMake(300, 640)];
    [toPath addLineToPoint:CGPointMake(400, 100)];
    [toPath closePath];
    
    
    layer.path=fromPath.CGPath;
    
    
    [self.view.layer addSublayer:layer];
    
    
    CABasicAnimation *ani=[CABasicAnimation animation];
    ani.keyPath=@"path";
    ani.duration=6;
    ani.fromValue=(__bridge id)fromPath.CGPath;
    
    layer.path=toPath.CGPath;
    
    [layer addAnimation:ani forKey:nil];
    
    

}
//利用Beizer曲线画正余玄 并且练习strokeStart和strokeEnd的动画效果
-(void)bezierXuan{
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(100, 100, 500, 300)];
    view.backgroundColor=[UIColor clearColor];
    [self.view addSubview:view];
    int height=150;//逢高
    int width=300;
    CAShapeLayer *layer=[CAShapeLayer layer];
    layer.lineWidth=3;
    layer.strokeColor=[UIColor yellowColor].CGColor;
    layer.fillColor=[UIColor clearColor].CGColor;
    
    
    UIBezierPath *bezier=[UIBezierPath bezierPath];
    
    [bezier moveToPoint:CGPointMake(0, height/2)];
    for(int i=0;i<width;i++){
    
        CGFloat y=height/2+height/2 *sin(2*M_PI*i/100);
        
        [bezier addLineToPoint:CGPointMake(i, height-y)];
        
    }

    layer.path=bezier.CGPath;
    
    //添加动画 strokeStart代表绘制开始的地方范围[0,1] strokeEnd 代表绘制结束的地方
    
    CABasicAnimation *ani=[CABasicAnimation animation];
//    ani.keyPath=@"strokeStart";
//    ani.duration=3;
////    ani.fromValue=@0;
//     ani.fromValue=@1;
//    ani.repeatCount=10000;
//    //layer.strokeStart=1;
//     layer.strokeStart=0;
    ani.keyPath=@"strokeEnd";
    ani.duration=3;
    ani.fromValue=@0;
    ani.repeatCount=10;
    [layer addAnimation:ani forKey:nil];
    [view.layer addSublayer:layer];
    

}
//练习CABaseAnimation
-(void) testCABaseAnimation{

    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3, 100, 200, 100)];
    lable.text=@"测试CABaseAnimation";
    lable.textAlignment=NSTextAlignmentCenter;
    lable.backgroundColor=[UIColor redColor];
    [self.view addSubview:lable];
    
    CABasicAnimation *baseAnimation=[CABasicAnimation animationWithKeyPath:@"position"];
    CGPoint start=lable.center;
    CGPoint end=CGPointMake(start.x+100, start.y+100);
    baseAnimation.fromValue=[NSValue valueWithCGPoint:start];
    baseAnimation.toValue=[NSValue valueWithCGPoint:end];
    baseAnimation.duration=2;
    //baseAnimation.removedOnCompletion=NO;//在动画执行完成之后，最好还是将动画移除掉。也就是尽量不要设置removedOnCompletion属性为NO
    /**
     一般动画完成后都会回到原来的状态
     解释：为什么动画结束后返回原状态？
     首先我们需要搞明白一点的是，layer动画运行的过程是怎样的？其实在我们给一个视图添加layer动画时，真正移动并不是我们的视图本身，而是 presentation layer 的一个缓存。动画开始时 presentation layer开始移动，原始layer隐藏，动画结束时，presentation layer从屏幕上移除，原始layer显示。这就解释了为什么我们的视图在动画结束后又回到了原来的状态，因为它根本就没动过。
     
     这个同样也可以解释为什么在动画移动过程中，我们为何不能对其进行任何操作。
     
     所以在我们完成layer动画之后，最好将我们的layer属性设置为我们最终状态的属性，然后将presentation layer 移除掉。
     */
    //只需设置removedOnCompletion、fillMode两个属性如下就可以不让动画完成后回到原来的状态了
    
    baseAnimation.removedOnCompletion = NO;
    baseAnimation.fillMode = kCAFillModeForwards;//fileMode有好几个不同的值代表不同的意思
    
    baseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];//设置动画的插值器

    [lable.layer addAnimation:baseAnimation forKey:@"lable1"];

}
//正统的UIBezierPath曲线

-(void)testBezierPath{
    CAShapeLayer *layer1=[CAShapeLayer layer];
    layer1.lineWidth=3;
    layer1.strokeColor=[UIColor brownColor].CGColor;
    layer1.fillColor=[UIColor clearColor].CGColor;
    
    UIBezierPath *circlePath=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 200, 200)];
    
    //构造一个子路径
    UIBezierPath *sonPath=[UIBezierPath bezierPath];
    [sonPath moveToPoint:CGPointMake(100, 200)];
    [sonPath addLineToPoint:CGPointMake(300, 200)];
    
    //把字Path添加到父Path中
    [circlePath appendPath:sonPath];
    
    //再创建个子路径
    
    UIBezierPath *son1=[UIBezierPath bezierPath];
    [son1 moveToPoint:CGPointMake(200, 100)];
    [son1 addLineToPoint:CGPointMake(200, 300)];
    
     //把字Path添加到父Path中
    [circlePath appendPath:son1];
    
    layer1.path=circlePath.CGPath;
    
    [self.view.layer addSublayer:layer1];
    
    //直接利用一个Path拼接图形
    
    CAShapeLayer *layer2=[CAShapeLayer layer];
    
    layer2.lineWidth=3;
    layer2.strokeColor=[UIColor blueColor].CGColor;
    layer2.fillColor=[UIColor clearColor].CGColor;
    
    UIBezierPath *bezier=[UIBezierPath bezierPath];
    
    //先画一个90度的圆弧
    
    [bezier addArcWithCenter:CGPointMake(200, 400) radius:50 startAngle:0 endAngle:M_PI_2 clockwise:YES];
    
    //在拼接一条直线
    [bezier addLineToPoint:CGPointMake(150, 350)];
    
    layer2.path=bezier.CGPath;
    [self.view.layer addSublayer:layer2];
    
    //画一条真正的贝塞尔曲线
    CAShapeLayer *shaper3=[CAShapeLayer layer];
    shaper3.lineWidth=3;
    shaper3.strokeColor=[UIColor yellowColor].CGColor;
    
    UIBezierPath *bezier2=[UIBezierPath bezierPath];
    
    [bezier2 moveToPoint:CGPointMake(100, 400)];
    [bezier2 addCurveToPoint:CGPointMake(200, 500) controlPoint1:CGPointMake(50, 460) controlPoint2:CGPointMake(200, 420)];
    shaper3.path=bezier2.CGPath;
    //贝塞尔曲线的起点是(100, 400) 中间两个平滑拐弯点分别是(50, 460)和(200, 420)
    
    [self.view.layer addSublayer:shaper3];
    
    CAGradientLayer *gradientLayer=[CAGradientLayer layer];
    gradientLayer.frame=CGRectMake(100, 520, 200, 100);
    
    gradientLayer.colors=[NSArray arrayWithObjects:[UIColor redColor].CGColor,
                          [UIColor blueColor].CGColor,[UIColor yellowColor].CGColor,
                          [UIColor redColor].CGColor,
                          [UIColor blueColor].CGColor,[UIColor yellowColor].CGColor,nil];
    gradientLayer.locations=[NSArray arrayWithObjects:[NSNumber numberWithFloat:0],
                             [NSNumber numberWithFloat:0.15],[NSNumber numberWithFloat:0.3],
                             [NSNumber numberWithFloat:0.45],[NSNumber numberWithFloat:0.6],
                             [NSNumber numberWithFloat:0.8],[NSNumber numberWithFloat:1],nil];
    gradientLayer.startPoint=CGPointMake(0, 0);
    gradientLayer.endPoint=CGPointMake(1, 1);
    [self.view.layer addSublayer:gradientLayer];
    
 
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
