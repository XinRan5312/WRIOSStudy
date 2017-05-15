//
//  SimpleViewController.m
//  QXIOS
//
//  Created by 新然 on 2017/5/3.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import "SimpleViewController.h"
#import "CustomView.h"
#import "CustomViewOne.h"
#import "CustomViewTwo.h"
//#define CUSTOM_BUNDLE_PATH  [[NSBundle mainBundle] pathForResource:@"qx" ofType:@"bundle"];

@interface SimpleViewController ()

@end

@implementation SimpleViewController

- (IBAction)hightLing:(id)sender {
    
    if([sender isKindOfClass:[UIButton class]]){
        UIButton *b=sender;
    
        NSLog(@"button的Text是%@",b.titleLabel.text);
    }
    
    
    [_btn setShowsTouchWhenHighlighted:YES];//点击按下的时候按钮会发光
    UIStoryboard *storyBord=[UIStoryboard storyboardWithName:@"bookdemo" bundle:nil];
    UIViewController *viewController=[storyBord instantiateViewControllerWithIdentifier:@"simple2"];
    [self presentViewController:viewController animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //忽略所有用户交互行为
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    //这样就不响应所有的用户交互事件  忽略所有用户的点击，拖动等行为  安心的做其它的事儿，比如我们动画的时候，不希望响应用户交互事件
    //现在我做完了我想做的事儿，需要响应用户交互行为了，结束忽略
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
//    [self testEvents];
    
 
    
}
//练习IOS事件传递机制
-(void)testEvents{
    CustomView *custom=[[CustomView alloc]initWithFrame:CGRectMake(10, 60, 400, 600)];
    custom.userInteractionEnabled=true;
    custom.layer.backgroundColor=[UIColor redColor].CGColor;
    
    CustomViewOne *one=[[CustomViewOne alloc] initWithFrame:CGRectMake(20, 80, 100, 150)];
    one.userInteractionEnabled=true;
    one.backgroundColor=[UIColor blueColor];
    [custom addSubview:one];
    
    CustomViewTwo *two=[[CustomViewTwo alloc] initWithFrame:CGRectMake(20, 240, 100, 150)];
    two.userInteractionEnabled=true;
    two.backgroundColor=[UIColor yellowColor];
    [custom addSubview:two];
    
    [self.view addSubview:custom];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     NSLog(@"Controller&touchesBegan");
}
//获取自定义qx.bundle下的img资源

-(void)loadCustomBundleImg{
    //因为自己自定义的qx.bundle也是放在主目录下，所以还是先得到主目录
    NSBundle *bundle=[NSBundle mainBundle];
    
    //得到程序的主目录
    NSString *appDir=bundle.bundlePath;
    
    //然后获得自己自定义的bundle的路径
    NSString *customBundlePath=[bundle pathForResource:@"qx" ofType:@"bundle"];
    //然后根据路径直接得到我们的自定义Bundle 如果想直接使用我们自定义的Bundle的话
    
    NSBundle *qxBundle=[NSBundle bundleWithPath:customBundlePath];
    
    //自定义bundle下的图片路径
    
    NSString *imgPath=[customBundlePath stringByAppendingPathComponent:@"image"];
    
    //得到自定义bundle下的图片路径的某个图片
    
    UIImage *image=[UIImage imageWithContentsOfFile:[imgPath stringByAppendingPathComponent:@"girl_one.jpg"]];
    
    UIImageView *imageView=[[UIImageView alloc] initWithImage:image];
    [self.view addSubview:imageView];
    
    //获取这个目录下所有的txt类型的文件
    
   NSArray *array= [bundle pathsForResourcesOfType:@"txt" inDirectory:customBundlePath];
    
    //根据类名初始化一个类
    
    Class cls=[bundle classNamed:@"ClassName"];
    
    id oneInstnce=[[cls alloc]init];
    
    //读取指定路径下名字确定的一个txt
    
    NSString *fileTxt=[bundle pathForResource:customBundlePath ofType:@"txt"];
    
    NSData *txtData=[[NSData alloc]initWithContentsOfFile:fileTxt];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
