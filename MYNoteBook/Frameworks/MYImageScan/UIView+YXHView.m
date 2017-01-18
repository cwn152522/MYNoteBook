//
//  UIView+YXHView.m
//  NSLayout封装
//
//  Created by 姚旭辉 on 15/12/29.
//  Copyright © 2015年 姚旭辉. All rights reserved.
//

#import "UIView+YXHView.h"

@implementation UIView (YXHView)

- (void)setLayoutWidth:(CGFloat)width
{
    if (self.superview != nil) {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:width];
        [self.superview addConstraint:constraint];
    }
}

- (void)setLayoutHeight:(CGFloat)height
{
    if (self.superview != nil) {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:height];
        [self.superview addConstraint:constraint];
    }
}

- (void)setLayoutLeft:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)c
{
    if (self.superview != nil) {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeRight multiplier:multiplier constant:c];
        [self.superview addConstraint:constraint];
    }
}

- (void)setLayoutRight:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)c
{
    if (self.superview != nil) {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeLeft multiplier:multiplier constant:-c];
        [self.superview addConstraint:constraint];
    }
}

- (void)setLayoutTop:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)c
{
    if (self.superview != nil) {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeBottom multiplier:multiplier constant:c];
        [self.superview addConstraint:constraint];
    }
}

- (void)setLayoutBottom:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)c
{
    if (self.superview != nil) {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeTop multiplier:multiplier constant:c];
        [self.superview addConstraint:constraint];
    }
}

- (void)setLayoutWidth:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)c
{
    if (self.superview != nil) {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeWidth multiplier:multiplier constant:c];
        [self.superview addConstraint:constraint];
    }
}

- (void)setLayoutHeight:(UIView *)targetView  multiplier:(CGFloat)multiplier constant:(CGFloat)c
{
    if (self.superview != nil) {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeHeight multiplier:multiplier constant:c];
        [self.superview addConstraint:constraint];
    }
}

- (void)setLayoutLeftFromSuperViewWithConstant:(CGFloat)c
{
    if (self.superview != nil) {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1.0f constant:c];
        [self.superview addConstraint:constraint];
    }
}

- (void)setLayoutRightFromSuperViewWithConstant:(CGFloat)c
{
    if (self.superview != nil) {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeRight multiplier:1.0f constant:-c];
        [self.superview addConstraint:constraint];
    }
}

- (void)setLayoutTopFromSuperViewWithConstant:(CGFloat)c
{
    if (self.superview != nil) {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:c];
        [self.superview addConstraint:constraint];
    }
}

- (void)setLayoutBottomFromSuperViewWithConstant:(CGFloat)c
{
    if (self.superview != nil) {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-c];
        [self.superview addConstraint:constraint];
    }
}

- (void)setLayoutCenterX:(UIView *)targetView
{
    if (self.superview != nil) {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0];
        [self.superview addConstraint:constraint];
    }
}

- (void)setLayoutCenterX:(UIView *)targetView constant:(CGFloat)c {
    if (self.superview != nil) {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:c];
        [self.superview addConstraint:constraint];
    }
}

- (void)setLayoutCenterY:(UIView *)targetView
{
    if (self.superview != nil) {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0];
        [self.superview addConstraint:constraint];
    }
}

- (void)setLayoutCenterY:(UIView *)targetView  constant:(CGFloat)c
{
    if (self.superview != nil) {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:c];
        [self.superview addConstraint:constraint];
    }
}

//- (void)setAlignTop:(UIView *)targetView
//{
//    if (self.superview != nil) {
//        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:targetView.frame.]
//    }
//}

@end
