//
//  MYNavControllerTransitioningDelegate.h
//  MYNavigationControllerDemo
//
//  Created by 陈伟南 on 16/11/7.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 本类定义了MYNavigationController的代理，主要处理push、pop动画触发事件
 */

@interface MYNavControllerTransitioningDelegateV2 : NSObject<UINavigationControllerDelegate>

@property (strong, nonatomic) UIPanGestureRecognizer *interactivePopPanGestureRecognizer;//全屏返回手势
@property (strong, nonatomic) UIScreenEdgePanGestureRecognizer *interactivePopEdgePanGestureRecognizer;//边缘返回手势

- (instancetype)initWithNavigationController:(UINavigationController *)controller;

@end
