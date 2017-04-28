//
//  MYNavControllerTransitioningDelegate.h
//  MYNavigationControllerDemo
//
//  Created by chenweinan on 16/11/7.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MYNavControllerTransitioningDelegate : NSObject<UINavigationControllerDelegate>

- (instancetype)initWithNavigationController:(UINavigationController *)controller;

- (void)navigationControllerPreparedForPush;
- (void)navigationControllerPreparedForPop:(UIViewController *)toVc;

@end
