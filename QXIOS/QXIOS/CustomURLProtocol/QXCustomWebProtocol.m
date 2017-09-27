//
//  QXCustomWebProtocol.m
//  QXIOS
//
//  Created by 新然 on 2017/5/31.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import "QXCustomWebProtocol.h"
static const NSString *isHasRequest=@"CustomWebProtocol";

@interface QXCustomWebProtocol() <NSURLConnectionDelegate,NSURLConnectionDataDelegate>
@property(nonatomic,strong)NSURLConnection *connection;

@end

@implementation QXCustomWebProtocol

/**
 决定是否截取处理这个request 返回YES表示处理  然后开始调用
 +(NSURLRequest*)canonicalRequestForRequest:(NSURLRequest *)request
 */

+(BOOL)canInitWithRequest:(NSURLRequest *)request{
    
    //只处理图片相关的
    NSURL *url=request.URL;
    NSString *scheme=url.scheme;
    
    NSString *pathExtetion=url.pathExtension;
    
    if([scheme isEqualToString:@"http"]&&[self isImg:pathExtetion]){
    
        return YES;
    }


    return NO;
}

+(BOOL)isImg:(NSString*)pathExtetion{

    if([pathExtetion isEqualToString:@".png"]||[pathExtetion isEqualToString:@".jpg"]||[pathExtetion isEqualToString:@".gif"]){
    
        return YES;
    }
    return NO;

}

/**
 
 一旦确定截取request处理 就开始调用这个方法 在这个方法里 我们可以为所欲为的改动request的内容
 
 */

+(NSURLRequest*)canonicalRequestForRequest:(NSURLRequest *)request{

    NSMutableURLRequest *copyRequest=[request mutableCopy];
    
    return copyRequest;


}

/**
 截取以后 也处理了request 现在开始真正的加载网络数据了
 
 */

-(void)startLoading{


}
/**
 以下是代理的NSURLConnectionDelegate和NSURLConnectionDataDelegate的方法
 
 */


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{

}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{

}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

}

-(void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{

}

@end
