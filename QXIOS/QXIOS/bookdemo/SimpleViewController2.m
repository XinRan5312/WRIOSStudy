//
//  SimpleViewController2.m
//  QXIOS
//
//  Created by 新然 on 2017/5/3.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import "SimpleViewController2.h"
#import "SegueViewController.h"

static void * p=&p;



@interface SimpleViewController2 ()


@end

@implementation SimpleViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    //键盘升起
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    //键盘降下
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //注册一个名字为one的通知的观察者，只要发送名字是one的通知，在我romove之前，我的这个notificationObserverOne:函数就会收到通知内容

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationObserverOne:) name:@"one" object:nil];
    
    //注册了一个名字为two的通知的观察者，只要发送名字是one的通知，在我romove之前，我的这个block就会收到通知内容

    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"two" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        //通知主要是有这三个属性
        
        NSString *name=note.name;
        
        id obj=note.object;
        
        NSDictionary *userInfo=note.userInfo;
        
        NSLog(@"收到了通知name=%@,obj=%@,userInfo=%@",name,obj,userInfo);
    }];
    
    //利用通知监听某个属性的变化
    
    //如果变化 系统就会调用这个自带的方法observeValueForKeyPath:ofObject:change: context:我们重写后处理
    
    [[NSNotificationCenter defaultCenter] addObserver:self forKeyPath:@"name" options:NSKeyValueChangeKindKey context:p];
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"one" object:@"一个通知"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"two" object:@"另外一个通知"
                                                      userInfo:@{@"name":@"qx",@"age":@"18"}];

    [super touchesBegan:touches withEvent:event];
}
-(void)notificationObserverOne:(NSNotification *) note{

    //通知主要是有这三个属性
    
    NSString *name=note.name;
    
    id obj=note.object;
    
    NSDictionary *userInfo=note.userInfo;
    
    NSLog(@"收到了通知name=%@,obj=%@,userInfo=%@",name,obj,userInfo);
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{


}
//对UIApplication的使用的练习

-(void)testUIApplication{

    //是个全局单例并且启动APP系统首先创建的就是这个类 查程序入口main函数就会明白
    UIApplication *app=[UIApplication sharedApplication];
    
    //配置通知的设置
    
    UIUserNotificationType types=UIUserNotificationTypeBadge;
    
    app.applicationIconBadgeNumber=10;//改变应用图标数字
    
    //打开一个网址
    
    [app openURL:[NSURL URLWithString:@"http://www.jianshu.com/p/c2bb07786fd1"] options:@{} completionHandler:^(BOOL success) {
        if(success==YES){
            NSLog(@"打开网页成功");
        }
    }];
    //拨打电话
    //    [app openURL:[NSURL URLWithString:@"tel://10086"] options:@{} completionHandler:^(BOOL success) {
    //        if(success==YES){
    //            NSLog(@"开始电话");
    //        }else{
    //            NSLog(@"开始电话失败");
    //
    //        }
    //    }];
    
    //发短信
    //    [app openURL:[NSURL URLWithString:@"sms://10086"] options:@{} completionHandler:^(BOOL success) {
    //        if(success==YES){
    //            NSLog(@"开始发短信");
    //        }else{
    //            NSLog(@"开始发短信失败");
    //
    //        }
    //    }];
    
    //发电子邮件
    //分别有发送给，抄送给cc，邮件主题subject，邮件内容body
    //    NSString *email=@"mailto:first@qq.com?cc=sencond@qq.com,third@qq.com&subject=会议通知 from BJ!&body=记得准时参加会议啊";
    //
    //    [app openURL:[NSURL URLWithString:email] options:@{} completionHandler:^(BOOL success) {
    //        if(success==YES){
    //                        NSLog(@"开始发邮件");
    //                   }else{
    //                        NSLog(@"开始发邮件失败");
    //
    //                    }
    //    }];
    //发邮件如果是APP一个很重要的功能，我们可以使用专门的发邮件工具类或者三方SDK比如下面这个类就是很正规的发邮件
    
    //UIApplication负责管理APP中所有的UIWindow,所以可以得到他们
    NSArray<UIWindow*> *windowsArray= [[UIApplication sharedApplication] windows];//获取所有的UIWindow
    UIWindow *keyWindow=[[UIApplication sharedApplication] keyWindow];//获取那个makeKeyAndVisible方法的UIWindow
    
    
    //忽略所有用户交互行为
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    /**
     这样就不响应所有的用户交互事件  忽略所有用户的点击，拖动等行为  安心的做其它的事儿，比如我们动画的时候，不希望响应用户交互事件,也就是说此时所有的touchesBegain等UIResponder的方法都不会被系统调用
     */
    //现在我做完了我想做的事儿，需要响应用户交互行为了，结束忽略 ，也就是说此时所有的touchesBegain等UIResponder的方法又开始被系统正常调用了
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    //拦截已经派发出去的点击事件，然后更改派发对象
    
    //    -(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //
    //        //截胡 就是说我们可以利用UIApplication拦截点击事件，然后分派给其它的对象处理这个点击事件，本来就是它派发的，所以可以返回更改吗  哈哈
    //
    //        //    [[UIApplication sharedApplication]sendAction:<#(nonnull SEL)#> to:<#(nullable id)#> from:<#(nullable id)#> forEvent:<#(nullable UIEvent *)#>];
    //
    //    }
    
    
    //不让手机休眠
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    
    //获取UIApplicationDelegate对象
    
    id<UIApplicationDelegate> appDelegate= [[UIApplication sharedApplication] delegate];
    
    UIApplicationState status= [[UIApplication sharedApplication] applicationState];//app的状态
    
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:60*60];//设置在后台运行时间
    
    //后台运行的时间
    
    NSTimeInterval timerBackGround=[[UIApplication sharedApplication] backgroundTimeRemaining];
    
    //后台刷新的状态
    
    UIBackgroundRefreshStatus  backgroudStatus=[[UIApplication sharedApplication]
                                                backgroundRefreshStatus];
    
    //在后台执行任务
    
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        
    }];
    
    [[UIApplication sharedApplication] beginBackgroundTaskWithName:@"bg" expirationHandler:^{
        
    }];
    
    [[UIApplication sharedApplication] endBackgroundTask:1];
    
    //远程控制
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    
    
    //隐藏状态栏
    [UIApplication sharedApplication].statusBarHidden=YES;
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    //设置状态栏的style
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //状态条的Frame是only read属性
    
    CGRect statusBarFrame= [UIApplication sharedApplication].statusBarFrame;
    
    //设置网络指示图片是否可见
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    //获取屏幕方向这也是only read属性
    
    UIUserInterfaceLayoutDirection userLayDir= [UIApplication sharedApplication].userInterfaceLayoutDirection;
    

}
//发送邮件
//1.导入库文件:MessageUI.framework
//2.引入头文件
//3.实现代理<MFMailComposeViewControllerDelegate> 和 <UINavigationControllerDelegate>
//代码示例:
//复制代码 代码如下:
//
//- (void)didClickSendEmailButtonAction{
//    
//    if ([MFMailComposeViewController canSendMail] == YES) {
//        
//        MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
//        //  设置代理(与以往代理不同,不是"delegate",千万不能忘记呀,代理有3步)
//        mailVC.mailComposeDelegate = self;
//        //  收件人
//        NSArray *sendToPerson = @[@"humingtao2014@gmail.com"];
//        [mailVC setToRecipients:sendToPerson];
//        //  抄送
//        NSArray *copyToPerson = @[@"humingtao2013@126.com"];
//        [mailVC setCcRecipients:copyToPerson];
//        //  密送
//        NSArray *secretToPerson = @[@"563821250@qq.com"];
//        [mailVC setBccRecipients:secretToPerson];
//        //  主题
//        [mailVC setSubject:@"hello world"];
//        [self presentViewController:mailVC animated:YES completion:nil];
//        [mailVC setMessageBody:@"魑魅魍魉,哈哈呵呵嘿嘿霍霍" isHTML:NO];
//    }else{
//        
//        NSLog(@"此设备不支持邮件发送");
//        
//    }

- (IBAction)跳转:(id)sender {
    
    
}
//在故事版中用Segue链接的跳转，系统跳转的前会调用这个方法
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"Segue的Indity%@",segue.identifier);
    //要跳转过去的ViewController 也可以通过强转得到真正的ViewController
//    UIViewController *viewController=segue.destinationViewController;
    SegueViewController *viewController=(SegueViewController*)segue.destinationViewController;
    
    [viewController setName:segue.identifier];
  
    viewController.lable.backgroundColor=[UIColor redColor];
    if([sender isKindOfClass:[UILabel class]]){
        UILabel *lable=sender;
        NSLog(@"lable的Text is %@",lable.text);
    }
    
     }
//系统跳转的时候会调用这个方法
-(void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    //identifier 是在故事版建立链接Segue时指明的Segue的名字
    [super performSegueWithIdentifier:identifier sender:sender];
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
