//
//  UIViewController+CATransition.h
//  modalAnimationDemo
//
//  Created by 陈伟南 on 16/5/12.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CATransitionType){
    CATransitionTypeCrossDissolve = 0,//淡入淡出
    CATransitionTypeRippleEffect,//水波纹
    CATransitionTypeSuckEffect,//吮吸
    CATransitionTypeOglFlip,//平面翻转
    CATransitionTypeCube,//立方体翻转
    CATransitionTypePageCurl,//正向翻页
    CATransitionTypePageUnCurl,//逆向翻页
    CATransitionTypePush,//推挤
    CATransitionTypeReveal,//揭开
    CATransitionTypeMoveIn,//覆盖
};

typedef NS_ENUM(NSUInteger, CATransitionSubType){
    CATransitionTransformFromDefault = 0,//默认为right
    CATransitionTransformFromLeft,
    CATransitionTransformFromTop,
    CATransitionTransformFromBottom
};


@interface UIViewController (CATransition)

- (void)presentViewController:(UIViewController *)viewController withTransitionType:(CATransitionType)type andSubType:(CATransitionSubType)subType andDuration:(CGFloat)duration;
- (void)dismissViewControllerWithTransitionType:(CATransitionType)type andSubType:(CATransitionSubType)subType andDuration:(CGFloat)duration;

- (void)pushViewController:(UIViewController *)controller withTransitionType:(CATransitionType)type andSubType:(CATransitionSubType)subType andDuration:(CGFloat)duration;
- (void)popViewControllerWithTransitionType:(CATransitionType)type andSubType:(CATransitionSubType)subType andDuration:(CGFloat)duration;
- (void)popViewControllerToViewController:(UIViewController *)controller WithTransitionType:(CATransitionType)type andSubType:(CATransitionSubType)subType andDuration:(CGFloat)duration;
- (void)popToRootViewControllerWithTransitionType:(CATransitionType)type andSubType:(CATransitionSubType)subType andDuration:(CGFloat)duration;

@end
