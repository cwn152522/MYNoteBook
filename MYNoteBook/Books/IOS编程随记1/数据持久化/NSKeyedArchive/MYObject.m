//
//  MYObject.m
//  NSKeyedArchive
//
//  Created by 陈伟南 on 16/10/11.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "MYObject.h"

@implementation MYObject

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:_number forKey:@"number"];
    [aCoder encodeObject:_string forKey:@"string"];
    [aCoder encodeObject:_child forKey:@"child"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
    _number = [aDecoder decodeIntegerForKey:@"number"];
    _string = [aDecoder decodeObjectForKey:@"string"];
    _child = [aDecoder decodeObjectForKey:@"child"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    MYObject *object = [[MYObject alloc] init];
    object.number = _number;
    object.string = [_string copyWithZone:zone];
    object.child = [_child copyWithZone:zone];
    return object;
}


@end
