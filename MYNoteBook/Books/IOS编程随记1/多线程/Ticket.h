//
//  Ticket.h
//  售票系统_单例_GCD
//
//  Created by 陈伟南 on 16/6/1.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject

@property (assign, atomic) NSInteger ticket;

+ (Ticket *)sharedTicket;

@end
