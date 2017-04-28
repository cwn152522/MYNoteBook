//
//  MYObject.h
//  NSKeyedArchive
//
//  Created by 陈伟南 on 16/10/11.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYObject : NSObject<NSCoding, NSCopying>

@property (copy, nonatomic) NSString *string;//字符串

@property (assign, nonatomic) NSInteger number;//基本数据类型

@property (strong, nonatomic) MYObject *child;//对象

@end
