//
//  UIViewControllerAnimatingManager.m
//  modalAnimationDemo
//
//  Created by 陈伟南 on 16/5/4.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "UIViewControllerAnimatingManager.h"

@interface UIViewControllerAnimatingManager ()

@property (assign, nonatomic) UIPresentTransitionType type;
@property (assign, nonatomic) UIPresentAnimationStyle style;
@property (assign, nonatomic) CGFloat duration;

@end

@implementation UIViewControllerAnimatingManager

+ (instancetype)transitionWithTransitionType:(UIPresentTransitionType)type andAnimationStyle:(UIPresentAnimationStyle)style andTransitionDuration:(CGFloat)duration{
    UIViewControllerAnimatingManager *manager = [[UIViewControllerAnimatingManager alloc] initWithTransitionType:type andAnimationStyle:style andTransitionDuration:(CGFloat)duration];
    return manager;
}

- (instancetype)initWithTransitionType:(UIPresentTransitionType)type andAnimationStyle:(UIPresentAnimationStyle)style andTransitionDuration:(CGFloat)duration{
    if(self = [super init]){
        _type = type;
        _style = style;
        _duration = duration;
    }
    return self;
}

#pragma mark UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return _duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_type) {
        case UIPresentTransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
            
        case UIPresentTransitionTypeDismiss:
            [self dismissAnimation:transitionContext];
            break;
            
        case UIPresentransitionTypePush:
            [self pushAnimation:transitionContext];
            break;
            
        case UIPresentransitionTypePop:
            [self popAnimation:transitionContext];
            
        default:
            break;
    }
}


#pragma mark modal动画

- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_style) {
        case UIPresentAnimationStyleCrossDissolve:
            [self crossDissolveAnimatingWithTransitionContext:transitionContext];
            break;
            
        default:
            break;
    }
}

- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_style) {
        case UIPresentAnimationStyleCrossDissolve:
            [self crossDissolveAnimatingWithTransitionContext:transitionContext];
            break;
            
        default:
            break;
    }
}

#pragma mark push动画

- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_style) {
        case UIPresentAnimationStyleCrossDissolve:
            [self crossDissolveAnimatingWithTransitionContext:transitionContext];
            break;
            
        default:
            break;
    }
}

- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_style) {
        case UIPresentAnimationStyleCrossDissolve:
            [self crossDissolveAnimatingWithTransitionContext:transitionContext];
            break;
            
        default:
            break;
    }
}

#pragma mark 动画实现

- (void)crossDissolveAnimatingWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController * toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *toView;
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        toView = toViewController.view;
    }
    toView.frame = [transitionContext finalFrameForViewController:toViewController];
    
    UIView *containerView = transitionContext.containerView;
    [containerView addSubview:toView];
    
    toView.alpha = 0.0f;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.alpha = 1.0;
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

@end
