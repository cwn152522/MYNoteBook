//
//  UIView+YXHView.h
//  NSLayout封装
//
//  Created by 姚旭辉 on 15/12/29.
//  Copyright © 2015年 姚旭辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YXHView)

- (void)setLayoutWidth:(CGFloat)width;

- (void)setLayoutHeight:(CGFloat)height;

- (void)setLayoutLeft:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)c;

- (void)setLayoutRight:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)c;

- (void)setLayoutTop:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)c;

- (void)setLayoutBottom:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)c;

- (void)setLayoutWidth:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)c;

- (void)setLayoutHeight:(UIView *)targetView  multiplier:(CGFloat)multiplier constant:(CGFloat)c;

- (void)setLayoutLeftFromSuperViewWithConstant:(CGFloat)c;

- (void)setLayoutRightFromSuperViewWithConstant:(CGFloat)c;

- (void)setLayoutTopFromSuperViewWithConstant:(CGFloat)c;

- (void)setLayoutBottomFromSuperViewWithConstant:(CGFloat)c;

- (void)setLayoutCenterX:(UIView *)targetView;

- (void)setLayoutCenterX:(UIView *)targetView constant:(CGFloat)c;

- (void)setLayoutCenterY:(UIView *)targetView;

- (void)setLayoutCenterY:(UIView *)targetView constant:(CGFloat)c;

@end
