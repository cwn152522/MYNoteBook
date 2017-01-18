//
//  MYDataRequester.m
//  MYNetworkReview
//
//  Created by chenweinan on 16/11/20.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "MYDataRequester.h"
#import "MYURLSessionTask.h"
#import "MYTasksOperationQueue.h"

@interface MYDataRequester ()<NSURLSessionDataDelegate>

@property (strong ,nonatomic) NSURLSession *dataSession;

@end

@implementation MYDataRequester

- (NSURLSession *)dataSession{
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    static NSURLSessionConfiguration *configuration;
    dispatch_once(&onceToken, ^{
        configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    });
    return session;
}

- (NSInteger)httpPostWithRequestObj:(MYRequestObj *)requestObj entityClass:(NSString *)entityName withCompleteBlock:(MYNetworkResponseBlock)responseBlock{
    if(!requestObj){
        NSLog(@"requestObj can't null!");
        return 0;
    }
    
    NSMutableURLRequest *request = [MYNetworkUtility getPostRequestWithRequestObj:requestObj];
    request.cachePolicy = requestObj.requestCachePolicy;
    request.HTTPShouldHandleCookies = requestObj.shouldSendCookies;
    
    MYURLSessionTask *task = [[MYURLSessionTask alloc] init];
    task.task = [self.dataSession dataTaskWithRequest:request
                                    completionHandler:
                 ^(NSData *data, NSURLResponse *response, NSError *error) {
                     if([(NSHTTPURLResponse *)response statusCode] == 500)
                     error = [NSError errorWithDomain:@"服务器内部错误" code:500 userInfo:nil];
                     
                     if(error){
                         [MYNetworkUtility handleError:error withTask:task taskType:MYNetworkTaskTypeData];
                         return;
                     }
                     
                     [MYNetworkUtility handleSuccessWithData:data entity:entityName sessionTask:task taskType:MYNetworkTaskTypeData];
                     return;
                 }];
    
    task.responseBlock = responseBlock;
    [[MYTasksOperationQueue defaultQueue] startSessionTaskFromTasksQueueWithTask:task taskType:MYNetworkTaskTypeData];
    return task.requestId;
}

- (NSInteger)httpGetWithRequestObj:(MYRequestObj *)requestObj entityClass:(NSString *)entityName withCompleteBlock:(MYNetworkResponseBlock)responseBlock{
    if(!requestObj){
        NSLog(@"requestObj can't be null!");
        return 0;
    }

    NSMutableURLRequest *request = [MYNetworkUtility getGetRequestWithRequestObj:requestObj];
    request.cachePolicy = requestObj.requestCachePolicy;
    request.HTTPShouldHandleCookies = requestObj.shouldSendCookies;
    
    MYURLSessionTask *task = [[MYURLSessionTask alloc] init];
    task.task = [self.dataSession dataTaskWithRequest:request
                                    completionHandler:
                 ^(NSData *data, NSURLResponse *response, NSError *error) {
                     if([(NSHTTPURLResponse *)response statusCode] == 500)
                     error = [NSError errorWithDomain:@"服务器内部错误" code:500 userInfo:nil];
                     
                     if(error){
                         [MYNetworkUtility handleError:error withTask:task taskType:MYNetworkTaskTypeData];
                         return;
                     }
                     
                     [MYNetworkUtility handleSuccessWithData:data entity:entityName sessionTask:task taskType:MYNetworkTaskTypeData];
                     return;
                 }];
    
    task.responseBlock = responseBlock;
    [[MYTasksOperationQueue defaultQueue] startSessionTaskFromTasksQueueWithTask:task taskType:MYNetworkTaskTypeData];
    return task.requestId;
}

#pragma mark NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler//通过调用block，来告诉NSURLSession要不要收到这个证书
{
    //(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler
    //NSURLSessionAuthChallengeDisposition （枚举）如何处理这个证书
    //NSURLCredential 授权
    
    //证书分为好几种：服务器信任的证书、输入密码的证书  。。，所以这里最好判断
    
    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){//服务器信任证书
        
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];//服务器信任证书
        if(completionHandler)
        completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
    }
    NSLog(@"....completionHandler---:%@",challenge.protectionSpace.authenticationMethod);
}

@end
