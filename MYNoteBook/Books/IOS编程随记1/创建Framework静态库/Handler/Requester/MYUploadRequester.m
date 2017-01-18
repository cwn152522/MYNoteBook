//
//  MYUploadRequester.m
//  MYNetworkReview
//
//  Created by chenweinan on 16/11/20.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "MYUploadRequester.h"
#import "MYURLSessionTask.h"
#import "MYTasksOperationQueue.h"

@interface MYUploadRequester ()<NSURLSessionDataDelegate>

@property (strong, nonatomic) NSURLSession *uploadSession;

@end

@implementation MYUploadRequester

- (NSURLSession *)uploadSession{
    static NSURLSession *session;
    static dispatch_once_t onceToken;
    static NSURLSessionConfiguration *configuration;
    dispatch_once(&onceToken, ^{
        configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    });
    return session;
}

- (NSInteger)upLoadFileWithRequestObj:(MYRequestObj *)requestObj filePath:(NSString *)filePath entityClass:(NSString *)entityName withUpLoadBlock:(MYNetworkResponseBlock)responseBlock{
    if(!requestObj || !filePath){
        NSLog(@"requestObj or filePath can't be null!");
        return 0;
    }
    
    NSMutableURLRequest *request = [MYNetworkUtility getMultipartFormDataRequestWithRequestObj:requestObj filePath:filePath];
    request.cachePolicy = requestObj.requestCachePolicy;
    request.HTTPShouldHandleCookies = requestObj.shouldSendCookies;
    
    MYURLSessionTask *task = [[MYURLSessionTask alloc]init];
    task.task = [self.uploadSession uploadTaskWithRequest:request fromData:request.HTTPBody completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if([(NSHTTPURLResponse *)response statusCode] == 500)
        error = [NSError errorWithDomain:@"服务器内部错误" code:500 userInfo:nil];
        
        if(error){
            [MYNetworkUtility handleError:error withTask:task taskType:MYNetworkTaskTypeUpload];
            return;
        }
        
        [MYNetworkUtility handleSuccessWithData:data entity:entityName sessionTask:task taskType:MYNetworkTaskTypeUpload];
        return;
    }];
    
    task.responseBlock = responseBlock;
    [[MYTasksOperationQueue defaultQueue] startSessionTaskFromTasksQueueWithTask:task taskType:MYNetworkTaskTypeUpload];
    return task.requestId;
}

#pragma mark NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend{
    MYURLSessionTask *uploadTask = [[MYTasksOperationQueue defaultQueue] getTaskWithRequestId:task.taskIdentifier taskType:MYNetworkTaskTypeUpload];
    if(uploadTask == nil)
    return;
    uploadTask.netWorkResponse.status = MYNetworkResponseStatusUploading;
    uploadTask.netWorkResponse.progress = 1.0*totalBytesSent/totalBytesExpectedToSend;
    [MYNetworkUtility responseBlock:uploadTask.responseBlock withTask:uploadTask];
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
