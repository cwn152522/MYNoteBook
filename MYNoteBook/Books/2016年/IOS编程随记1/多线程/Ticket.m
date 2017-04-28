//
//  Ticket.m
//  售票系统_单例_GCD
//
//  Created by 陈伟南 on 16/6/1.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "Ticket.h"

static Ticket *sharedTicket;

@interface Ticket ()<NSCopying>

@end

@implementation Ticket

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTicket = [super allocWithZone:zone];
    });
    return sharedTicket;
}

+ (Ticket *)sharedTicket{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTicket = [[Ticket alloc] init];
        sharedTicket.ticket = 100;
    });
    return sharedTicket;
}

- (id)copyWithZone:(NSZone *)zone{
    return self;
}

@end
