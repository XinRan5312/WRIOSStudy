//
//  QXCustomDataProtocol.m
//  QXIOS
//
//  Created by 新然 on 2017/5/27.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import "QXCustomDataProtocol.h"

/**
 
 # iOS中的 NSURLProtocol
 
 URL loading system 原生已经支持了http,https,file,ftp,data这些常见协议，当然也允许我们定义自己的protocol去扩展，或者定义自己的协议。当URL
 loading system通过NSURLRequest对象进行请求时，将会自动创建NSURLProtocol的实例（可以是自定义的）。这样我们就有机会对该请求进行处理。
 
 */

static NSString const * hasInitKey=@"CustomDataProtocolKey";

@interface QXCustomDataProtocol() 

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *connection;

@end

@implementation QXCustomDataProtocol

/**
 这个方法是自定义protocol的入口，如果你需要对自己关注的请求进行处理则返回YES，这样，URL
 loading system将会把本次请求的操作都给了你这个protocol。
 */
+(BOOL)canInitWithRequest:(NSURLRequest *)request{

    if([NSURLProtocol propertyForKey:hasInitKey inRequest:request]){
        //过滤已经请求过的 防止一直递归调用
    
        return NO;
    
    }
    NSURL *url=request.URL.absoluteURL;
    
    NSString *scheme=url.scheme;
    
    NSString *host=url.host;
    
    NSString *path=url.path;
    
    NSString *pathExtention=url.pathExtension;
    
    NSString *query=url.query;
    //我们也可以过滤这些东西 然后确定我们是否要拦截处理请求
    return YES;

}
/**
   这个方法主要是用来返回格式化好的request，如果自己没有特殊需求的话，直接返回当前的request就好了。如果你想做些其他的，比如地址重定向，或者请求头的重新设置，你可以copy下这个request然后进行设置。
 
 */

+(NSURLRequest*)canonicalRequestForRequest:(NSURLRequest *)request{

    NSMutableURLRequest *copyRequest=[request mutableCopy];
    
    //在这里你可以把原来的request改的面目全非  甚至一点关系都没有  也可以就加个请求Header等等
    //反正你拦截了 处理权就交给你了 处理完 返回给我就好了
    
    return copyRequest;
}

/**
 1.+(BOOL)canInitWithRequest:(NSURLRequest *)request经过这个方法返回YES，确定拦截处理
 
 2.+(NSURLRequest*)canonicalRequestForRequest:(NSURLRequest *)request 修改成自己想要的request
 
 3.正式开始加载了 也就是说在这里你可以拦截 然后自定义返回数据 其实都没请求真正的网罗，你也可以大发善心让其去请求
 
 */

-(void)startLoading{
    
    //首先把请求copy过来
    
    NSMutableURLRequest *copyRequest=[self.request mutableCopy];
    
    //做一下标记  防止递归调用  跟上面过滤它的时候是一一对应的
    
    [NSURLProtocol setProperty:@YES forKey:hasInitKey inRequest:copyRequest];
    
    //下面就是你正真干坏事儿的地方了
    //我们可以全局配置一个flag这里我就不设置了 假设是debug模式
    BOOL isDebug=YES;
    if(isDebug){
        
        //模拟假数据返回 加入返回一个String字符串
        
        NSString *responseStr=@"Hello 你知道你接收到的是假数据吗";
        
        NSData *data=[responseStr dataUsingEncoding:NSUTF8StringEncoding];
        
        //有了数据开始构造假的Response
        
        NSURLResponse *respons=[[NSURLResponse alloc]initWithURL:copyRequest.URL MIMEType:@"text/plain" expectedContentLength:data.length textEncodingName:nil];
        
        //调用回应过程中相应的周期代理方法 把response返回给请求对象
        
        __weak typeof(self) weakSelf=self;
        
        [self.client URLProtocol:weakSelf didReceiveResponse:respons cacheStoragePolicy:NSURLCacheStorageNotAllowed];//模拟调用让client端收到相应
        
        [self.client URLProtocol:weakSelf didLoadData:data];//模拟client端收到数据了
        
        //中间还有好多过程 代理方法  就不模拟一一调用了
        
        [self.client URLProtocolDidFinishLoading:weakSelf];//完成了
        
    
    
    }else{//饶了你 正常调用请求吧
        
        self.connection=[NSURLConnection connectionWithRequest:copyRequest delegate:self];
    
    
    }


}

-(void)stopLoading{
    if(self.connection)
    [self.connection cancel];

}

#pragma mark -NSURLConnectionDelegate
/**
 的代理方法 这些接口方法都是可选的 其实他就是代理调用客户端的相关方法
 还有就是相应的SSL（https）安全认证也是在这里
 
 */

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    [self.client URLProtocol:self didFailWithError:error];
}
//- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection{
//    return YES;
//    
//}
//- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
//
//}
//- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace NS_DEPRECATED(10_6, 10_10, 3_0, 8_0, "Use -connection:willSendRequestForAuthenticationChallenge: instead."){
//    
//}
//- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge NS_DEPRECATED(10_2, 10_10, 2_0, 8_0, "Use -connection:willSendRequestForAuthenticationChallenge: instead."){
//    
//}
//- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge NS_DEPRECATED(10_2, 10_10, 2_0, 8_0, "Use -connection:willSendRequestForAuthenticationChallenge: instead."){
//
//}

#pragma mark - NSURLConnectionDataDelegate

/**
 这里主要是处理响应数据的各个代理方法 也都是可选择的
 
 */

- (nullable NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(nullable NSURLResponse *)response{
    
    return request;

}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.responseData appendData:data];
    
    [self.client URLProtocol:self didLoadData:data];

}

//- (nullable NSInputStream *)connection:(NSURLConnection *)connection needNewBodyStream:(NSURLRequest *)request{
//    [connection ]
//
//}
//- (void)connection:(NSURLConnection *)connection   didSendBodyData:(NSInteger)bytesWritten
// totalBytesWritten:(NSInteger)totalBytesWritten
//totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite{
//
//}
//
//- (nullable NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse{
//
//}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{

    [self.client URLProtocolDidFinishLoading:self];
}


/**
 
   这个方法用于判断你的自定义reqeust是否相同，这里返回默认实现即可。它的主要应用场景是某些直接使用缓存而非再次请求网络的地方。
 
 */

//+(BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b{
//
//    return YES;
//}

+(BOOL)canInitWithTask:(NSURLSessionTask *)task{

    return YES;
}

@end
