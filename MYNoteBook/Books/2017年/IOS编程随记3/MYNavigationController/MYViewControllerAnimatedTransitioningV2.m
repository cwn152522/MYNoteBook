//
//  MYViewControllerAnimatedTransition.m
//  MYNavigationControllerDemo
//
//  Created by 陈伟南 on 16/11/7.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "MYViewControllerAnimatedTransitioningV2.h"
#import "UIView+FrameProperty.h"

static const float kTransitionDuration = .28;

@interface MYViewControllerAnimatedTransitioningV2 ()

@property (strong, nonatomic) UIView *tabBarSuperview;

@end

@implementation MYViewControllerAnimatedTransitioningV2

#pragma mark UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return kTransitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_type) {
        case UIViewControllerPresentTransitionTypePresent:
            [self animatePresentTransition:transitionContext];
            break;
        case UIViewControllerPresentTransitionTypeDismiss:
            [self animateDissmissTransition:transitionContext];
            break;
        case UIViewControllerPresentTransitionTypePush:
            [self animatePushTransition:transitionContext];
            break;
        case UIViewControllerPresentTransitionTypePop:
            [self animatePopTransition:transitionContext];
        default:
            break;
    }
}

#pragma mark private methods

- (void)animatePresentTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
}

- (void)animateDissmissTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
}

- (void)animatePushTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromViewController= [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containView = [transitionContext containerView];
    
    UIView *tabbar = fromViewController.tabBarController.tabBar;
    if(tabbar != nil && ![containView.subviews containsObject:tabbar]){
        self.tabBarSuperview = tabbar.superview;
        tabbar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 49, [UIScreen mainScreen].bounds.size.width, 49);
        [containView addSubview:tabbar];
    }
    
    [containView addSubview:toViewController.view];
    
    CGRect rect = [transitionContext finalFrameForViewController:toViewController];
    rect.origin.x = [[UIScreen mainScreen] bounds].size.width;

    CGFloat offset = 0;
    rect.origin.y = offset;
    toViewController.view.frame = rect;
    
    toViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;//添加阴影
    toViewController.view.layer.shadowOffset = CGSizeMake(0, 0);
    toViewController.view.layer.shadowRadius = 3;
    toViewController.view.layer.shadowOpacity = 0.8;
    toViewController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, toViewController.view.frame.size.width, toViewController.view.frame.size.height)].CGPath;
    
     [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = rect;
        frame.origin.x = 0;
        frame.origin.y = offset;
        toViewController.view.frame = frame;
        
        frame.origin.x = - [[UIScreen mainScreen] bounds].size.width/3;
        frame.origin.y = offset;
        fromViewController.view.frame = frame;
         
         if(tabbar != nil && [containView.subviews containsObject:tabbar]){
             tabbar.frame_x =  [[UIScreen mainScreen] bounds].size.width * 2 / 3;
         }
    } completion:^(BOOL finished) {
        BOOL isCanceled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCanceled];
        if(!isCanceled){
        }
    }];
}

- (void)animatePopTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromViewControllerView = [transitionContext viewForKey:UITransitionContextFromViewKey];//No:1 -> No:3
    
    UIView *containView = [transitionContext containerView];
    
    [containView addSubview:toViewController.view];//No:2
    
    UIView *tabbarview = toViewController.tabBarController.tabBar;
    if(tabbarview != nil && [containView.subviews containsObject:tabbarview]){
        [containView bringSubviewToFront:tabbarview];
    }else{
        self.tabBarSuperview = tabbarview.superview;
        tabbarview.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width * 2 / 3, [UIScreen mainScreen].bounds.size.height - 49, [UIScreen mainScreen].bounds.size.width, 49);
        [containView addSubview:tabbarview];
    }
    
    [containView bringSubviewToFront:fromViewControllerView];
    
    CGRect rect = [transitionContext finalFrameForViewController:toViewController];
    rect.origin.x = -[[UIScreen mainScreen] bounds].size.width/3;
    toViewController.view.frame = rect;
    
    if(tabbarview != nil && [containView.subviews containsObject:tabbarview]){
        tabbarview.frame_x = - [[UIScreen mainScreen] bounds].size.width/3;
    }
    
    CGFloat offset = 0;
    
    fromViewControllerView.layer.shadowColor = [UIColor blackColor].CGColor;//(2)pop前把(1)操作取消的阴影加上
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = rect;
        frame.origin.x = 0;
        frame.origin.y = offset;
        toViewController.view.frame = frame;
        
        if(tabbarview != nil && [containView.subviews containsObject:tabbarview]){
            tabbarview.frame_x = 0;
        }
        
        frame.origin.x = [[UIScreen mainScreen] bounds].size.width;
        frame.origin.y = offset;
        fromViewControllerView.frame = frame;
    } completion:^(BOOL finished) {
        BOOL isCanceled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCanceled];
        if(!isCanceled){
            toViewController.view.layer.shadowColor = [UIColor clearColor].CGColor;//(1)解决pop结束阴影还在
            if(tabbarview != nil && [containView.subviews containsObject:tabbarview]){
                tabbarview.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 49, [UIScreen mainScreen].bounds.size.width, 49);
                [weakSelf.tabBarSuperview addSubview:tabbarview];
            }
        }else{//手势取消，containtView结构复位
            if(tabbarview != nil && [containView.subviews containsObject:tabbarview]){
                [containView bringSubviewToFront:tabbarview];
            }
            [containView bringSubviewToFront:fromViewControllerView];
        }
    }];
}


@end
