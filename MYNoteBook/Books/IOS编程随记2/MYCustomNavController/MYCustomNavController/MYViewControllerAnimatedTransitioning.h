//
//  MYViewControllerAnimatedTransition.h
//  MYNavigationControllerDemo
//
//  Created by chenweinan on 16/11/7.
//  Copyright © 2016年 chenweinan. All rights reserved.
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

@interface MYViewControllerAnimatedTransitioning : NSObject<UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) UIViewControllerPresentTransitionType type;

- (void)shotNavigationBarForPush:(BOOL)flag popToVcIndex:(NSInteger)index;

@end
