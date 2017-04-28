//
//  PersonHelper.m
//  arraysEqualJudgeDemo
//
//  Created by chenweinan on 16/7/28.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "PersonHelper.h"

@implementation PersonHelper

- (NSInteger)sayhello:(NSString *)words{
    NSLog(@"这是备援接受者%@", words);
    return 100;//随便返回个值
}

@end
