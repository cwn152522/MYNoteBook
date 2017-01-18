//
//  Person.m
//  arraysEqualJudgeDemo
//
//  Created by 陈伟南 on 15/12/23.
//  Copyright © 2015年 陈伟南. All rights reserved.
//

#import "Person1.h"
#import <objc/runtime.h>

int say(id self, SEL _cmd, NSString *str)
{
    NSLog(@"%@", str);
    return 100;//随便返回个值
}

int wolegequGetter(id self, SEL _cmd){
    //读取sef.字典，key为cmd的string，将读到的返回
    return 100;
}

void wolegequSetter(id self, SEL _cmd, NSInteger wolequ){
    NSLog(@"%ld", wolequ);
    //写个self.字典，设置key为cmd的string，value 为 str；
//    Person *person = (Person *)self;
}

@implementation Person1
@dynamic wolegequ;

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSString *selStr = NSStringFromSelector(sel);
//    if([selStr hasPrefix:@"say"]){
//        class_addMethod(self, sel, (IMP)say, "i@:@");
//        return YES;
//    }
    if([selStr hasPrefix:@"set"]){
        class_addMethod(self, sel, (IMP)wolegequSetter, "v@:i");
        return YES;
    }
    if([selStr hasPrefix:@"wole"]){
        class_addMethod(self, sel, (IMP)wolegequGetter, "i@:");
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSString *selector = NSStringFromSelector(aSelector);
    if([selector hasPrefix:@"say"]){
        //注意以下区别
        return [[[NSClassFromString(@"PersonHelper") class] alloc] init];//实例方法
//        return [NSClassFromString(@"PersonHelper") class];//类方法
    }
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature *signature = [NSMethodSignature methodSignatureForSelector:aSelector];
    return signature;
}
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    [super forwardInvocation:anInvocation];
}
@end
