//
//  MYViewControllerAnimatedTransition.h
//  MYNavigationControllerDemo
//
//  Created by 陈伟南 on 16/11/7.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 本类仅定义了固定动画(仿系统默认动画)，可自由发挥，定义各种动画，以枚举区分即可
 */

typedef NS_ENUM(NSUInteger, UIViewControllerPresentTransitionType) {
    UIViewControllerPresentTransitionTypePresent = 0,//present动画
    UIViewControllerPresentTransitionTypeDismiss,//dismiss动画
    UIViewControllerPresentTransitionTypePush,//push动画
    UIViewControllerPresentTransitionTypePop//pop动画
};

@interface MYViewControllerAnimatedTransitioningV2 : NSObject<UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) UIViewControllerPresentTransitionType type;

@end
