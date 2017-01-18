//
//  NSArray+SafeMethod.m
//  图片浏览器
//
//  Created by 陈伟南 on 16/1/6.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "NSArray+SafeMethod.h"

@implementation NSArray (SafeMethod)

- (id)objectSafetyAtIndex:(NSUInteger)index
{
    if (index >= [self count]) {
        return nil;
    }
    return [self objectAtIndex:index];
}

@end
