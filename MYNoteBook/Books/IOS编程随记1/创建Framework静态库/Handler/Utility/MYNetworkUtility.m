//
//  MYNetworkUtility.m
//  MYRongCloudDemo
//
//  Created by chenweinan on 16/10/18.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "MYNetworkUtility.h"
#import "MYURLSessionTask.h"
#import "MYTasksOperationQueue.h"
#import <MobileCoreServices/MobileCoreServices.h>//c语言api，获取文件MIME时需导入

// 分隔符
#define kBoundary @"----WebKitFormBoundary3pVJSvbLhiFiCeZC"
// 换行 并且要转码
#define kNewline [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]

@implementation MYNetworkUtility

+ (UIImage *)changeImageToFitScreenScale:(UIImage *)image{
    static CGFloat scale = 2.0f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = [UIScreen mainScreen].scale;
    });
    return [UIImage imageWithData:UIImagePNGRepresentation(image) scale:scale];
}

+ (NSString*) mk_urlEncodedString:(NSString *)string { // mk_ prefix prevents a clash with a private api
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          (__bridge CFStringRef) string,
                                                                          nil,
                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),
                                                                          kCFStringEncodingUTF8);
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) encodedCFString];
    if(!encodedString)
        encodedString = @"";
    return encodedString;
}

+ (void)setHttpHeadersWithRequestObject:(MYRequestObj *)requestObj request:(NSMutableURLRequest *)request{
    [[requestObj.httpHeaderDic allKeys] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [request addValue:requestObj.httpHeaderDic[obj] forHTTPHeaderField:obj];
    }];
}

+ (NSString *)getEncodedParamsFromDictionary:(NSDictionary *)dic{
    NSMutableString *str = [NSMutableString stringWithString:@""];
    for(NSString *param in [dic allKeys]){
        NSObject *value = [dic objectForKey:param];
        if([value isKindOfClass:[NSString class]])
            [str appendString:[NSString stringWithFormat:@"%@=%@&", [self mk_urlEncodedString:param], [self mk_urlEncodedString:(NSString *)value]]];
        else
            [str appendFormat:@"%@=%@&", [self mk_urlEncodedString: param], value];
    }
    if([str length] > 0)
        [str deleteCharactersInRange:NSMakeRange([str length] - 1, 1)];
    return str;
}

+ (NSDictionary *)getParamsDictionaryFromRequestObject:(MYRequestObj *)requestObj {
    NSMutableDictionary *paramsDict;
    paramsDict = [NSMutableDictionary dictionaryWithDictionary:[requestObj yy_modelToJSONObject]];
    [paramsDict removeObjectsForKeys:@[@"hostName", @"path", @"paramsDic", @"httpHeaderDic", @"requestCachePolicy", @"shouldSendCookies"]];
    if(requestObj.paramsDic)
        [paramsDict setValuesForKeysWithDictionary:requestObj.paramsDic];
    return paramsDict;
}

+ (NSMutableURLRequest *)getPostRequestWithRequestObj:(MYRequestObj *)requestObj{
    NSDictionary *paramsDic = [self getParamsDictionaryFromRequestObject:requestObj];
    NSString *params = [self getEncodedParamsFromDictionary:paramsDic];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",requestObj.hostName, requestObj.path]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    
    if(requestObj.httpHeaderDic)
        [self setHttpHeadersWithRequestObject:requestObj request:request];
    return request;
}

+ (NSMutableURLRequest *)getGetRequestWithRequestObj:(MYRequestObj *)requestObj{
    NSDictionary *paramsDic = [self getParamsDictionaryFromRequestObject:requestObj];
    NSString *params = [self getEncodedParamsFromDictionary:paramsDic];
    
    NSString *url = [[[NSString stringWithFormat:@"%@%@",requestObj.hostName, requestObj.path] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAppendingFormat:@"?%@", params];
    NSURL *URL = [NSURL URLWithString:url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    if(requestObj.httpHeaderDic)
        [self setHttpHeadersWithRequestObject:requestObj request:request];
    return request;
}

+ (NSMutableURLRequest *)getMultipartFormDataRequestWithRequestObj:(MYRequestObj *)requestObj filePath:(NSString *)filePath{
    
    NSDictionary *paramsDic = [self getParamsDictionaryFromRequestObject:requestObj];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", requestObj.hostName, requestObj.path]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:INT_MAX];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", kBoundary] forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *fileData = [NSMutableData data];
    
    //以--kBoundary kNewline分隔符代表新建了一个请求参数，若后面无参数构造，则有个请求参数为“”值为null
    [fileData appendData:[[NSString stringWithFormat:@"--%@",kBoundary]
                          dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:kNewline];
    //<<文件参数格式
    NSString *fileName = [filePath lastPathComponent];
    NSString *contentType = [self getContentTypeWithFilePath:filePath];
    [fileData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\";Content-Type=\"%@\"", fileName, contentType] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [fileData appendData:kNewline];
    [fileData appendData:kNewline];
    //将UIImage转为二进制NSData数据
    [fileData appendData:[NSData dataWithContentsOfFile:filePath]];
    [fileData appendData:kNewline];
    //文件参数格式>>
    [fileData appendData:[[NSString stringWithFormat:@"--%@", kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:kNewline];
    
    //Content-Disposition: form-data; name=（添加内容的方式，参数value要在两次kNewline后输入，以kNewline结束）
    [[paramsDic allKeys] enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //<<普通参数格式
        [fileData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"", obj] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [fileData appendData:kNewline];
        [fileData appendData:kNewline];
        [fileData appendData:[paramsDic[obj] dataUsingEncoding:NSUTF8StringEncoding]];
        [fileData appendData:kNewline];
        
        if(idx != [[paramsDic allKeys] count] - 1){
        [fileData appendData:[[NSString stringWithFormat:@"--%@", kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [fileData appendData:kNewline];
        }
        //普通参数格式>>
    }];
    
    request.HTTPBody = fileData;
    return request;
}

+ (NSURLRequest *)getDownloadRequestWithUrl:(NSURL *)url{
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:INT_MAX];
    return request;
}

+ (NSString *)getContentTypeWithFilePath:(NSString *)filePath{
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
        return nil;
    
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[filePath pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!MIMEType)
        return @"application/octet-stream";
    
    return (__bridge NSString *)(MIMEType);
}

+ (void)responseBlock:(MYNetworkResponseBlock)responseBlock withTask:(MYURLSessionTask *)task{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        responseBlock(task.netWorkResponse);
    });
}

+ (void)handleError:(NSError *)error withTask:(MYURLSessionTask *)task taskType:(MYNetworkTaskType)taskType{
    task.netWorkResponse.error = error;
    __weak typeof(self) weakSelf = self;
    [[MYTasksOperationQueue defaultQueue] sessionTaskDidCompleteSuccessfully:task taskType:taskType];
    switch (error.code) {
        case -999://请求已取消
            task.netWorkResponse.status = MYNetworkResponseStatusCancelled;
             return [weakSelf responseBlock:task.responseBlock withTask:task];
            break;
        case -1009://没有网络连接
            task.netWorkResponse.linkStatus = MYNetworkLinkStatusNotReachable;
            break;
        default:
            break;
    }
    task.netWorkResponse.status = MYNetworkResponseStatusFailed;
    [self responseBlock:task.responseBlock withTask:task];
}

+ (void)handleSuccessWithData:(NSData *)data entity:(NSString *)entityName sessionTask:(MYURLSessionTask *)task taskType:(MYNetworkTaskType)taskType{
    task.netWorkResponse.error = nil;
    task.netWorkResponse.status = MYNetworkResponseStatusSuccessed;
    MYResponedObj *model;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    [[MYTasksOperationQueue defaultQueue] sessionTaskDidCompleteSuccessfully:task taskType:taskType];
    if([entityName length]){
        model   =  [NSClassFromString(entityName)  yy_modelWithDictionary:dict];
        task.netWorkResponse.content = model;
    }else
    task.netWorkResponse.content = (MYResponedObj *)dict;
    [self responseBlock:task.responseBlock withTask:task];
    return;
}

+ (void)checkIfAllTheBackgroundTasksFinishedWithSession:(NSURLSession *)session handler:(void(^)())backgroundSessionCompletionHandler{
    // call completion handler if the app was resumed and got connected again to our background session
    [session getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        NSUInteger count = dataTasks.count + uploadTasks.count + downloadTasks.count;
        if (count == 0) {
             backgroundSessionCompletionHandler();//通知AppDelegate所有后台任务都已完成
        }
    }];
}

+ (void)checkIfTheBackgroundEnvironmentIsSettedCorrectly{
    BOOL methodImplemented = YES;
    methodImplemented = [[[UIApplication sharedApplication] delegate] respondsToSelector:@selector(application:handleEventsForBackgroundURLSession:completionHandler:)];
    if(!methodImplemented){
        NSLog(@"application:handleEventsForBackgroundURLSession:completionHandler: is not implemented in your application delegate......Download tasks might not work properly...... Please implement the method and set the completionHandler value to MYNetwork backgroundSessionCompletionHandler");
    }
}

+ (MYNetworkLinkStatus)getNetworkStates{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reach currentReachabilityStatus];
    
    switch (status) {
        case NotReachable:
        return MYNetworkLinkStatusNotReachable;
        break;
        case ReachableViaWiFi:
        return MYNetworkLinkStatusWifi;
        break;
        case ReachableViaWWAN:
        return MYNetworkLinkStatusCellular;
        break;
        default:
        break;
    }
}

+ (void)cancelRequestWithRequestId:(NSInteger)requestId taskType:(MYNetworkTaskType)taskType{
    if(requestId < 0)
    return;
    [[MYTasksOperationQueue defaultQueue] cancelSessionTaskFromTasksQueueWithRequestId:requestId taskType:taskType];
}
@end
