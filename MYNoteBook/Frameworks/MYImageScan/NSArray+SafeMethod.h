//
//  NSArray+SafeMethod.h
//  图片浏览器
//
//  Created by 陈伟南 on 16/1/6.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SafeMethod)

- (id)objectSafetyAtIndex:(NSUInteger)index;

@end
