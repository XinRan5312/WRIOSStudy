//
//  QXWKWebViewController.m
//  QXIOS
//
//  Created by 新然 on 2017/5/23.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import "QXWKWebViewController.h"
#import "WebKit/WebKit.h"

@interface QXWKWebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property(nonatomic,strong)WKWebView *wkWebView;
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)UIProgressView *progressView;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *loading;

@end

@implementation QXWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"版本信息：%@",[[UIDevice currentDevice] systemVersion]);
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]>8.0){
    
        [self createWKWebView];
    }else{
    
        [self creatWebView];
    
    }
    
    
}

-(void)creatWebView{
    if(_wkWebView){
        _wkWebView=nil;
    }
    
}

-(void)createWKWebView{
    if(_webView){
        _webView=nil;
    }
    
    WKWebViewConfiguration *configuration=[[WKWebViewConfiguration alloc]init];
    
    WKPreferences *preferences=[[WKPreferences alloc] init];//偏好设置
    
    preferences.minimumFontSize=10;//默认是0
    
    preferences.javaScriptEnabled=YES;//默认是YES
    
    preferences.javaScriptCanOpenWindowsAutomatically=NO;//是否可以自动通过窗口打开，默认是NO
    
    configuration.preferences=preferences;
    
    //web内容控制者 通过js与web内容交互
    WKUserContentController *userContentController=[[WKUserContentController alloc]init];
    
    //OS 通过js改变web内容
    WKUserScript *userScript=[[WKUserScript alloc] initWithSource:@"document.body.style.fontSize=16" injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    [userContentController addUserScript:userScript];
    
    //给JS注册了一个别名类
    //当JS通过这个别名对象QXApp调用OC代码的时候 这个方法userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:就会接收到信息
    
    [userContentController addScriptMessageHandler:self name:@"AppModel"];
    
    configuration.userContentController=userContentController;
    
    CGSize size=[UIScreen mainScreen].bounds.size;
    
    _wkWebView=[[WKWebView alloc]initWithFrame:CGRectMake(0, 50, size.width, size.height-50) configuration:configuration];
    
    _wkWebView.navigationDelegate=self;//导航栏代理
    
    _wkWebView.UIDelegate=self;//UI交互代理
    
    [self.view addSubview:_wkWebView];
    
    NSURL *url=[[NSBundle mainBundle] URLForResource:@"local" withExtension:@"html"];
    
    [_wkWebView loadRequest:[NSURLRequest requestWithURL:url]];
    
    
    // 添加KVO监听
    [self.webView addObserver:self
                   forKeyPath:@"loading"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    [self.webView addObserver:self
                   forKeyPath:@"title"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    [self.webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    
    
    
}
// 在JS端调用alert函数时，会触发此代理方法。
// JS端调用alert时所传的数据可以通过message拿到
// 在原生得到结果后，需要回调JS，是通过completionHandler回调
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{

    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"JavaScriptAlertPanelWithMsg" message:[NSString stringWithFormat:@"JS 调用alert函数了:%@", message] preferredStyle:UIAlertControllerStyleAlert];
   
    
    UIAlertAction *alertAction=[UIAlertAction actionWithTitle:@"JavaScriptAlertPanelWithMsg" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    [alertController addAction:alertAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

// JS端调用confirm函数时，会触发此方法
// 通过message可以拿到JS端所传的数据
// 在iOS端显示原生alert得到YES/NO后
// 通过completionHandler回调给JS端

-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"JavaScriptConfirmPanelWithMsg" message:[NSString stringWithFormat:@"JS端调用了confirm函数:%@",message] preferredStyle:1];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }];
    
    [alertController addAction:action];
    
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }];
    [alertController addAction:action1];

    [self presentViewController:alertController animated:YES completion:nil];
}

// JS端调用prompt函数时，会触发此方法
// 要求输入一段文本
// 在原生输入得到文本内容后，通过completionHandler回调给JS

-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"JavaScriptTextInputPanelWithPrompt" message:[NSString stringWithFormat:@"JS调用prompt：%@,defaultText:%@",prompt,defaultText] preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor=[UIColor blackColor];
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"TextPromt" style:0 handler:^(UIAlertAction * _Nonnull action) {
        
        completionHandler([NSString stringWithFormat:@"%@==%@",alertController.title,alertController.textFields.lastObject.text]);
    }]];
    
    [self presentViewController:alertController animated:YES completion:^{
        NSLog(@"JS");
    }];


}

#pragma mark -KVO 系统调用方法

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{

    if ([keyPath isEqualToString:@"loading"]) {
        NSLog(@"loading");
    } else if ([keyPath isEqualToString:@"title"]) {
        self.title = _wkWebView.title;
    } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        NSLog(@"progress: %f", _wkWebView.estimatedProgress);
        self.progressView.progress = _wkWebView.estimatedProgress;
    }
    
    // 加载完成
    if (!self.webView.loading) {
        // 手动调用JS代码
        // 每次页面完成都弹出来，大家可以在测试时再打开
        NSString *js = @"callJsAlert()";
        [_wkWebView evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"response: %@ error: %@", response, error);
            NSLog(@"call js alert by native");
        }];
        
        NSString *jsData = @"calltoValue('参数')";
        [_wkWebView evaluateJavaScript:jsData completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"response: %@ error: %@", response, error);
            NSLog(@"------->call js alert by native");
        }];
        
        
        [UIView animateWithDuration:0.5 animations:^{
            self.progressView.alpha = 0;
        }];
    }

}

#pragma mark -获取手机的相关信息

-(void)deviceInfos{

    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];

    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    NSString * appXcodeStr =[infoDictionary objectForKey:@"DTXcode"];//Xcode 版本
    NSString * appSDKNameStr = [infoDictionary objectForKey:@"DTSDKName"];//SDK 的版本

    //手机别名： 用户定义的名称
    NSString* userPhoneName = [[UIDevice currentDevice] name];
    NSLog(@"手机别名: %@", userPhoneName);
    //设备名称
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    NSLog(@"设备名称: %@",deviceName );
    //手机系统版本
    NSString* phoneVersionStr = [[UIDevice currentDevice] systemVersion];
    
    CGFloat  phoneVersionFloat=[phoneVersionStr floatValue];
    
    //    //手机序列号
//    if(phoneVersionFloat<7.0){7.0以后这个方法给禁了
//        NSString* identifierNumber = [UIDevice currentDevice] uniqueIdentifier];
//        NSLog(@"手机序列号: %@",identifierNumber);
//    }
    //可以用OpenUDID替代手机序列号的唯一性：https://github.com/ylechelle/OpenUDID
    
    NSLog(@"手机系统版本: %@", phoneVersionStr);
    //手机型号
    NSString* phoneModel = [[UIDevice currentDevice] model];
    NSLog(@"手机型号: %@",phoneModel );
    //地方型号  （国际化区域名称）
    NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
    NSLog(@"国际化区域名称: %@",localPhoneModel );

}

#pragma mark  -WKNavigationDelegate 代理方法的开始
/**
   request 来了前段先过滤一下 看看是否确定要真的去Request
 */

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    //发送请求之前决定是否开启跳转 相当于didShuldeStart
      //无论你是否拦截 都有调用block 否则会报错
    NSLog(@"decidePolicyForNavigationAction");
    
    NSURL *url=navigationAction.request.URL;
    
    if(navigationAction.navigationType==WKNavigationTypeLinkActivated){
        //&&![url.host containsString:@"我们公司规定的host"]一般还要加上不是我们公司内部的host
        //这样都是属于外域链接 需要手动跳转
        
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        
        //不允许web内跳 不继续request
        
        decisionHandler(WKNavigationActionPolicyCancel);
    
    }else{
        
          //跳转 去继续request
    
          decisionHandler(WKNavigationActionPolicyAllow);
    }

}
/**
 允许request后开始这一步 向服务器发起request
 */

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开启跳转
    
    NSLog(@"didStartProvisionalNavigation");
}

/**
   服务器收到发起的request 先过滤一下  确定是否搭理这个request 给个回应 算是第一次握手
 */

-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    //收到服务端的握手回应 决定是否提交跳转
    NSURL *url=navigationResponse.response.URL;
    NSLog(@"decidePolicyForNavigationResponse");
    //无论你是否拦截 都有调用block 否则会报错
    
//    if([url.host containsString:@"本公司的host"]){//就搭理它 接收request 给个回应
//       decisionHandler(WKNavigationActionPolicyAllow);
//        return;
//    }else{
//    
//        decisionHandler(WKNavigationActionPolicyCancel);
//    }
    
   
     decisionHandler(WKNavigationActionPolicyAllow);


}

-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    //这个不一定会被调用
    
    NSLog(@"didReceiveServerRedirectForProvisionalNavigation");
}
/**
   第一次握手成功  服务端给了回应开始真正提交request
 */


-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    //握手成功确定提交跳转
    
    NSLog(@"didCommitNavigation");

}
/**
   request成功 web加载成功 完成
 */


-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //完成跳转
    
    NSLog(@"didFinishNavigation");

}

/**
 request失败 web加载失败
 */

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
    //跳转失败
    
    NSLog(@"didFailNavigation");


}

#pragma mark - WKUIDelegate
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_9_0
- (void)webViewDidClose:(WKWebView *)webView {
    NSLog(@"%s", __FUNCTION__);
}
#endif

// 解决创建一个新的WebView（标签带有 target='_blank' 时，导致WKWebView无法加载点击后的网页的问题。）

-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{

    WKFrameInfo *frameInfo=navigationAction.targetFrame;//打开新窗口的委托
    
    if(![frameInfo isMainFrame]){//不是主窗口
    
        [webView loadRequest:navigationAction.request];
    }
    return nil;
    
}
-(void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    //SSL验证 如果没有就走默认的
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling,nil);
    
     NSLog(@"didReceiveAuthenticationChallenge");
    
}

-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    
    //页面内容完全加载完毕 不一定会被调用

    NSLog(@"webViewWebContentProcessDidTerminate");
}

#pragma mark WKScriptMessageHandler接口的方法

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    //我们通过[userContentController addScriptMessageHandler:self name:@"AppModel"];给JS注册了一个别名类
    //当JS通过这个别名对象QXApp调用OC代码的时候 这个方法就会接收到信息
    
    NSString *name=message.name;//就是我们注册给js的别名
    
    if([name isEqualToString:@"AppModel"]){
       
    
        NSLog(@"js 消息内容:%@", message.body);
    }
    
    
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
