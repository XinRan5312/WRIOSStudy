//
//  QXWebViewController.m
//  QXIOS
//
//  Created by 新然 on 2017/5/22.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import "QXWebViewController.h"
#import "UIViewController+OptionsMethod.h"

@interface QXWebViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lable;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,assign)BOOL isToRequest;

@end

@implementation QXWebViewController
/**
 
 // 代理属性 重点需要知道代理方法的使用
 @property (nullable, nonatomic, assign) id <UIWebViewDelegate> delegate;
 
 // 这个是webView内部的scrollView 只读,但是利用这个属性,设置scrollView的代理,就可以控制整个webView的滚动事件
 @property(nonatomic, readonly, strong) UIScrollView *scrollView;
 
 // webView的请求,这个属性一般在整个加载完成后才能拿到
 @property (nullable, nonatomic, readonly, strong) NSURLRequest *request;
 
 // A Boolean value indicating whether the receiver can move backward. (read-only)
 // If YES, able to move backward; otherwise, NO.
 // 如果这个属性为YES,才能后退
 @property (nonatomic, readonly, getter=canGoBack) BOOL canGoBack;
 
 // A Boolean value indicating whether the receiver can move forward. (read-only)
 // If YES, able to move forward; otherwise, NO.
 // 如果这个属性为YES,才能前进
 @property (nonatomic, readonly, getter=canGoForward) BOOL canGoForward;
 
 // A Boolean value indicating whether the receiver is done loading content. (read-only)
 // If YES, the receiver is still loading content; otherwise, NO.
 // 这个属性很好用,如果为YES证明webView还在加载数据,所有数据加载完毕后,webView就会为No
 @property (nonatomic, readonly, getter=isLoading) BOOL loading;
 
 //A Boolean value determining whether the webpage scales to fit the view and the user can change the scale.
 //If YES, the webpage is scaled to fit and the user can zoom in and zoom out. If NO, user zooming is disabled. The default value is NO.
 // YES代表网页可以缩放,NO代表不可以缩放
 @property (nonatomic) BOOL scalesPageToFit;
 
 // 设置某些数据变为链接形式，这个枚举可以设置如电话号，地址，邮箱等转化为链接
 @property (nonatomic) UIDataDetectorTypes dataDetectorTypes NS_AVAILABLE_IOS(3_0);
 
 // iPhone Safari defaults to NO. iPad Safari defaults to YES
 // 设置是否使用内联播放器播放视频
 @property (nonatomic) BOOL allowsInlineMediaPlayback NS_AVAILABLE_IOS(4_0);
 
 // iPhone and iPad Safari both default to YES
 // 设置视频是否自动播放
 @property (nonatomic) BOOL mediaPlaybackRequiresUserAction NS_AVAILABLE_IOS(4_0);
 
 // iPhone and iPad Safari both default to YES
 // 设置音频播放是否支持ari play功能
 @property (nonatomic) BOOL mediaPlaybackAllowsAirPlay NS_AVAILABLE_IOS(5_0);
 
 // iPhone and iPad Safari both default to NO
 // 设置是否将数据加载入内存后渲染界面
 @property (nonatomic) BOOL suppressesIncrementalRendering NS_AVAILABLE_IOS(6_0);
 
 // default is YES
 // 设置用户是否能打开keyboard交互
 @property (nonatomic) BOOL keyboardDisplayRequiresUserAction NS_AVAILABLE_IOS(6_0);
 
  以后的新特性
// 这个属性用来设置一种模式，当网页的大小超出view时，将网页以翻页的效果展示，枚举如下：
@property (nonatomic) UIWebPaginationMode paginationMode NS_AVAILABLE_IOS(7_0);
typedef NS_ENUM(NSInteger, UIWebPaginationMode) {
    UIWebPaginationModeUnpaginated, //不使用翻页效果
    UIWebPaginationModeLeftToRight, //将网页超出部分分页，从左向右进行翻页
    UIWebPaginationModeTopToBottom, //将网页超出部分分页，从上向下进行翻页
    UIWebPaginationModeBottomToTop, //将网页超出部分分页，从下向上进行翻页
    UIWebPaginationModeRightToLeft //将网页超出部分分页，从右向左进行翻页
};

// This property determines whether certain CSS properties regarding column- and page-breaking are honored or ignored.
// 这个属性决定CSS的属性分页是可用还是忽略。默认是UIWebPaginationBreakingModePage
@property (nonatomic) UIWebPaginationBreakingMode paginationBreakingMode NS_AVAILABLE_IOS(7_0);

// 设置每一页的长度
@property (nonatomic) CGFloat pageLength NS_AVAILABLE_IOS(7_0);

// 设置每一页的间距
@property (nonatomic) CGFloat gapBetweenPages NS_AVAILABLE_IOS(7_0);

// 获取页数
@property (nonatomic, readonly) NSUInteger pageCount NS_AVAILABLE_IOS(7_0);


 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _webView.dataDetectorTypes=UIDataDetectorTypeAll;//监测所有数据
    
    _webView.delegate=self;
    [self oc2Js];

    [self loadPDF];
}


-(void)loadhttpStr{
    
    NSString *strUrl=@"<html><head><title>Test WebView</title></head><body><h1>hello webview</h1><ul><li>1</li><li>2</li><li>3</li></body></html>";
    
    [_webView loadHTMLString:strUrl baseURL:nil];
    
}

-(void)loadWWW{
    
    NSURL *url=[NSURL URLWithString:@"https://www.hao123.com/"];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:request];
}

//获取指定URL mimeType

-(NSString*)getMimeTypeOfUrl:(NSURL*)url{


    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    //使用同步方法获取mimeType
    
    NSHTTPURLResponse *reponse=nil;
    NSError *error=nil;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    
    if(!error){
        return reponse.MIMEType;
    }else{
    
        return nil;
    
    }

}
-(void)loadTxt{//类似的还可以加载本地html
    NSString *path=[[NSBundle mainBundle] pathForResource:@"out" ofType:@"txt"];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    [_webView loadRequest:request];

}

-(void)loadPDF{//加载本地PDF
   
    NSString* path=[[NSBundle mainBundle] pathForResource:@"Groovy" ofType:@"pdf"];
    
    
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    [_webView loadRequest:request];
}

-(void)goBack{

    [_webView goBack];
}

-(void)goForward{

    [_webView goForward];
}

-(void)stopLoading{
    [_webView stopLoading];

}

-(void)refreshing{

    [_webView reload];
}

-(BOOL)canGoBack{
    return [_webView canGoBack];
}

-(BOOL)canGoForward{

    return [_webView canGoForward];
}

/**
 与js交互
 
 主要有两方面：js执行OC代码、oc调取写好的js代码
 
    js执行OC代码：js是不能执行oc代码的，但是可以变相的执行，js可以将要执行的操作封装到网络请求里面，然后oc拦截这个请求，获取url里面的字符串解析即可，这里用到代理协议的- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType函数。
 oc调取写好的js代码：这里用到UIwebview的一个方法。示例代码一个是网页定位，一个是获取网页title：
 */

-(void)oc2Js{
    NSString *title=[_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    NSLog(@"当前页面title=%@",title);
    
    NSString *url=[_webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    
    NSLog(@"当前页面的URL=%@",url);
    
    //修改利用js的知识修改html的属性
    NSString *jsStr1=@"document.getElementByTagName('body')[0].style.webkitTextSizeAdjust='60%'";
    
    [_webView stringByEvaluatingJavaScriptFromString:jsStr1];
    
    //创建一个元素加入到html中
    NSString *jsStr2=[NSString stringWithFormat:@"var meta=document.createElement(meta);meta.name='viewport';meta.content= 'width=%f,initial-scale=%f,minimum-scale=0.1,maximum-scale=1.0,user-scalable=yes'",_webView.frame.size.width,_webView.frame.size.width/1000];
    
    [_webView setScalesPageToFit:YES];
    
    [_webView stringByEvaluatingJavaScriptFromString:jsStr2];
    
    // 实现自动定位js代码, htmlLocationID为定位的位置(由js开发人员给出)，实现自动定位代码，应该在网页加载完成之后再调用
//    NSString *javascriptStr = [NSString stringWithFormat:@"window.location.href = '#%@'",htmlLocationID];
//    // webview执行代码
//    [self.webView stringByEvaluatingJavaScriptFromString:javascriptStr];

}
//是否对这个请求进行过滤处理 开始请求之前
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //比如对特殊的scheme或者url进行过滤 或者是解析js构成的商量好的协议，然后解析出来调用相应的OC代码，然后再处理 return YES;
    NSString *urlStr=[[request URL] absoluteString];
    
    urlStr=[urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSArray<NSString*> *compentArray=[urlStr componentsSeparatedByString:@"://"];
    
    NSURL *url=[request URL];
    
   NSString *scheme= url.scheme;
    
    NSString *host=url.host;
    
    NSString *path=url.path;
    
    NSString *pathExtention=url.pathExtension;
    
    NSString *query=url.query;
    //上面的东西都有了你是想过滤什么就过滤什么啊 比如
    if([host isEqualToString:@"main"]){
    
        //跳转到mainViewController
    }
    
    if([pathExtention isEqualToString:@"goBack"]){
    
        [webView goBack];
    }
    
//    typedef NS_ENUM(NSInteger, UIWebViewNavigationType) {
//        UIWebViewNavigationTypeLinkClicked,
//        UIWebViewNavigationTypeFormSubmitted,
//        UIWebViewNavigationTypeBackForward,
//        UIWebViewNavigationTypeReload,
//        UIWebViewNavigationTypeFormResubmitted,
//        UIWebViewNavigationTypeOther
//    } __TVOS_PROHIBITED;
    
    switch (navigationType) {
            //进来的前的触发行为 然后针对性的过滤处理
            
        case UIWebViewNavigationTypeLinkClicked:
            //点击的是链接
            
            break;
            
        case UIWebViewNavigationTypeReload:
            //reload  可以做reload记录数加1
            
            break;
        case UIWebViewNavigationTypeBackForward:
            //点击的是向前
            
            break;
        case UIWebViewNavigationTypeFormSubmitted:
            //提交表单
            
            break;
        case UIWebViewNavigationTypeFormResubmitted:
            //重新提交表达
            
            break;
            
        default://UIWebViewNavigationTypeOther
            
            
            break;
    }
    
    //也可以预先处理403和404状态码
    
    NSHTTPURLResponse *response=nil;
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    
    if(!_isToRequest){//代表这个请求是第一次或者是以前给isToRequest赋值过NO
        
        if(response.statusCode==403){
    
    //处理403
    }else if(response.statusCode==404){
     //处理404
    
    }else{
    
        [webView loadData:data MIMEType:@"text/html" textEncodingName:@"NSUTF8StringEncoding" baseURL:nil];
        _isToRequest=YES;//已经经历过403和404的过滤 这次直接去请求吧 再走一次本方法
        
        return NO;//代表本次请求到这里结束下面系统方法不走了  我拦截了
    }
    }else{
    
        _isToRequest=NO;
        
        return YES;
    
    }
    
    
    
    return YES;//我是拦截了修改了 些东西 但是本次请求还是照样走
    
    

}

-(void)webViewDidStartLoad:(UIWebView *)webView{//已经开始请求
    
    NSURLRequest *request=[webView request];
    
    NSString *requestMthod=[request HTTPMethod];
    
   NSData *bodyData= [request HTTPBody];
    
    
    BOOL b=[request HTTPShouldHandleCookies];


}

//请求完毕 服务端响应回调 没有错误
-(void)webViewDidFinishLoad:(UIWebView *)webView{

    NSURLRequest *request=[webView request];
    
    NSURL *url=[request URL];
    
    if([url.path isEqualToString:@"/wr/qx"]){
        //做点什么什么事儿
    
    }
}

//请求完毕 但是服务端响应错误，没有成功

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSURLRequest *request=[webView request];
    
    NSURL *url=[request URL];
    
    
    NSLog(@"请求url=%@,错误=%@",[url absoluteString],error);


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
