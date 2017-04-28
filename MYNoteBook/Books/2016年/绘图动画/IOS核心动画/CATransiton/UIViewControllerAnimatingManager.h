//
//  UIViewControllerAnimatingManager.h
//  modalAnimationDemo
//
//  Created by 陈伟南 on 16/5/4.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UIPresentTransitionType) {
    UIPresentTransitionTypePresent = 0,//present动画
    UIPresentTransitionTypeDismiss,//dismiss动画
    UIPresentransitionTypePush,//push动画
    UIPresentransitionTypePop//pop动画
};

typedef NS_ENUM(NSUInteger, UIPresentAnimationStyle){
    UIPresentAnimationStyleCrossDissolve = 0,//淡入淡出
    
};

@interface UIViewControllerAnimatingManager : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(UIPresentTransitionType)type andAnimationStyle:(UIPresentAnimationStyle)style andTransitionDuration:(CGFloat)duration;
- (instancetype)initWithTransitionType:(UIPresentTransitionType)type andAnimationStyle:(UIPresentAnimationStyle)style andTransitionDuration:(CGFloat)duration;

@end
