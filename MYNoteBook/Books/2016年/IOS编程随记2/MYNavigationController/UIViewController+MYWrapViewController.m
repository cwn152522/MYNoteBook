//
//  UIViewController+MYWrapViewController.m
//  MYNavigationController
//
//  Created by chenweinan on 16/11/8.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "UIViewController+MYWrapViewController.h"
#import <objc/runtime.h>

@implementation UIViewController (MYWrapViewController)

- (void)setWrapViewController:(UIViewController *)wrapViewController{
    objc_setAssociatedObject(self, @selector(wrapViewController), wrapViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)wrapViewController{
    return objc_getAssociatedObject(self, _cmd);
}

@end
