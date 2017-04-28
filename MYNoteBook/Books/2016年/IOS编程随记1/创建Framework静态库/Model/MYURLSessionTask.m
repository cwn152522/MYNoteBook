//
//  MYURLSessionTask.m
//  MYRongCloudDemo
//
//  Created by chenweinan on 16/10/7.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "MYURLSessionTask.h"

@implementation MYURLSessionTask

- (MYNetworkResponse *)netWorkResponse{
    if(!_netWorkResponse){
        _netWorkResponse = [[MYNetworkResponse alloc] init];
    }
    return _netWorkResponse;
}

- (void)setTask:(NSURLSessionTask *)task{
    _task = task;
    _requestId = task.taskIdentifier;
    self.netWorkResponse.requestId = _requestId;
}

- (BOOL)isEqual:(id)object{
    MYURLSessionTask *task = (MYURLSessionTask *)object;
    if(task == self)
        return YES;
    if([task isMemberOfClass:[self class]]){
        if(task.requestId == self.requestId)
            return YES;
    }
    return [super isEqual:object];
}

- (NSUInteger)hash{
    return _requestId ^ [_task hash] ^ [_netWorkResponse hash];
}

@end
