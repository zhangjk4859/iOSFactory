//
//  THURLProtocol.m
//  iOSFactory
//
//  Created by kevin on 2019/1/11.
//  Copyright © 2019 jumu. All rights reserved.
//

#import "THURLProtocol.h"


@interface THURLProtocol()<NSURLSessionDelegate>
@property (nonatomic, strong) NSURLSessionDataTask *dnstask;
@end


/**
 原理
 1.拦截系统大部分http请求
 2.向自己的的DNS服务器进行请求
 3.处理返回结果
 */



static NSString * const URLProtocolHandledKey = @"URLProtocolHandledKey";
@implementation THURLProtocol

//对进来的请求进行拦截
//判断哪些request需要拦截，需要返回YES；不需要返回NO
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    //只处理http和https请求
    NSString *scheme = [[request URL] scheme];
    if ( ([scheme caseInsensitiveCompare:@"http"] == NSOrderedSame || [scheme caseInsensitiveCompare:@"https"] == NSOrderedSame)) {
        //看看是否已经处理过了，防止无限循环
        if ([NSURLProtocol propertyForKey:URLProtocolHandledKey inRequest:request]) {
            return NO;
        }
        
        //post请求不拦截
        if ([request.HTTPMethod isEqualToString:@"POST"]) {
            return NO;
        }
        
        /*
        NSString *hostStr = [request.URL host];
        HttpDnsService *httpdns = [HttpDnsService sharedInstance];
        NSString *httpDnsIP = [httpdns getIpByHostAsync:hostStr];
        if (httpDnsIP) {
            return YES;
        }
         */
    }
    
    return NO;
}

//上面的方法完成后直接走这个方法 不处理也可以
//对拦截的request进行处理，修改host,添加cookie
+ (NSURLRequest *) canonicalRequestForRequest:(NSURLRequest *)request {
    NSMutableURLRequest *mutableReqeust = [request mutableCopy];
    mutableReqeust = [self redirectHostInRequset:mutableReqeust];
    return [mutableReqeust copy];
}

//服务于上一个方法
+(NSMutableURLRequest*)redirectHostInRequset:(NSMutableURLRequest*)request {
    if ([request.URL host].length == 0) {
        return request;
    }
    
    //URL全路径
    NSString *originUrlString = [request.URL absoluteString];
    //URL 域名
    NSString *originHostString = [request.URL host];
    
    NSRange hostRange = [originUrlString rangeOfString:originHostString];
    if (hostRange.location == NSNotFound) {
        return request;
    }
    /**
     苹果原生网络请求
     1。创建一个request  用get请求,信息放在头文件
     2。
     */
    
    /*
    HttpDnsService *httpdns = [HttpDnsService sharedInstance];
    NSString *httpDnsIP = [httpdns getIpByHostAsync:originHostString];
    */
    
    //获取后的ip地址 123.456.789.123
    NSString *httpDnsIP;
    if (httpDnsIP) {
        //根据范围 把域名换成 ip
        NSString *urlString = [originUrlString stringByReplacingCharactersInRange:hostRange withString:httpDnsIP];
        NSURL *url = [NSURL URLWithString:urlString];
        request.URL = url;
        
        //注意：若包头的host（key-value中的host）本身就是一个IP，则需要将这个IP替换成域名（该域名需要从referer中获取）
        if ([self isValidIP:originHostString]) {
            //从referer中获取域名
            NSString *referStr = [request valueForHTTPHeaderField:@"Referer"];
            NSArray *firstArray = [referStr componentsSeparatedByString:@"://"];
            NSString *secondStr;
            if (firstArray.count >= 2) {
                secondStr = firstArray[1];
            } else if (firstArray.count == 1) {
                secondStr = firstArray[0];
            }
            if (secondStr) {
                NSRange range = [secondStr rangeOfString:@"/"];
                if (range.length > 0) {
                    originHostString = [[secondStr componentsSeparatedByString:@"/"] firstObject];
                    originUrlString = [originUrlString stringByReplacingOccurrencesOfString:httpDnsIP withString:originHostString];
                }
            }
        }
        //将从referer中取出的域名，放到请求包头的Host中
        [request setValue:originHostString forHTTPHeaderField:@"Host"];
        
        //设置http的header的cookie
        NSArray *cookiesArray = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:originUrlString]];
        NSDictionary *cookieDict = [NSHTTPCookie requestHeaderFieldsWithCookies:cookiesArray];
        NSString *cookie = [cookieDict objectForKey:@"Cookie"];
        [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    return request;
}

/**
 *判断一个字符串是否是一个IP地址
 **/
+ (BOOL)isValidIP:(NSString *)ipStr {
    if (nil == ipStr) {
        return NO;
    }
    
    NSArray *ipArray = [ipStr componentsSeparatedByString:@"."];
    if (ipArray.count == 4) {
        for (NSString *ipnumberStr in ipArray) {
            int ipnumber = [ipnumberStr intValue];
            if (!(ipnumber>=0 && ipnumber<=255)) {
                return NO;
            }
        }
        return YES;
    }
    return NO;
}

//对拦截的请求做处理 域名换成IP 然后发出去
- (void)startLoading {
    NSMutableURLRequest *mutableReqeust = [[self request] mutableCopy];
    //标识该request已经处理过了，防止无限循环
    [NSURLProtocol setProperty:@YES forKey:URLProtocolHandledKey inRequest:mutableReqeust];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.protocolClasses = @[[self class]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    self.dnstask = [session dataTaskWithRequest:mutableReqeust];
    NSString *referStr = [mutableReqeust valueForHTTPHeaderField:@"Referer"];
    NSLog(@"start loading httpDNS********************\nstart loading httpDNS \n *****url :%@\n *****host:%@ \n *****referer:%@\n", mutableReqeust.URL, [mutableReqeust valueForHTTPHeaderField:@"Host"], referStr);
    [self.dnstask resume];
}

- (void)stopLoading {
    [self.dnstask cancel];
}







//代理
#pragma mark NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [[self client] URLProtocol:self didLoadData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    // 请求完成,成功或者失败的处理
    if (!error) {
        //成功
        [self.client URLProtocolDidFinishLoading:self];
    } else {
        //失败
        [self.client URLProtocol:self didFailWithError:error];
    }
}

- (BOOL)evaluateServerTrust:(SecTrustRef)serverTrust forDomain:(NSString *)domain {
    /*
     * 创建证书校验策略
     */
    NSMutableArray *policies = [NSMutableArray array];
    if (domain) {
        [policies addObject:(__bridge_transfer id) SecPolicyCreateSSL(true, (__bridge CFStringRef) domain)];
    } else {
        [policies addObject:(__bridge_transfer id) SecPolicyCreateBasicX509()];
    }
    /*
     * 绑定校验策略到服务端的证书上
     */
    SecTrustSetPolicies(serverTrust, (__bridge CFArrayRef) policies);
    /*
     * 评估当前serverTrust是否可信任，
     * 官方建议在result = kSecTrustResultUnspecified 或 kSecTrustResultProceed
     * 的情况下serverTrust可以被验证通过，https://developer.apple.com/library/ios/technotes/tn2232/_index.html
     * 关于SecTrustResultType的详细信息请参考SecTrust.h
     */
    SecTrustResultType result;
    SecTrustEvaluate(serverTrust, &result);
    if (result == kSecTrustResultUnspecified || result == kSecTrustResultProceed) {
        return YES;
    }
    return NO;
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler {
    if (!challenge) {
        return;
    }
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    NSURLCredential *credential = nil;
    
    
    /*
     * 获取原始域名信息。
     */
    NSString* host = [[self.request allHTTPHeaderFields] objectForKey:@"host"];
    if (!host) {
        host = self.request.URL.host;
    }
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([self evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:host]) {
            disposition = NSURLSessionAuthChallengeUseCredential;
            credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        } else {
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        }
    } else {
        disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    }
    // 对于其他的challenges直接使用默认的验证方案
    completionHandler(disposition,credential);
}


@end
