//
//  MYNavControllerTransitioningDelegate.m
//  MYNavigationControllerDemo
//
//  Created by 陈伟南 on 16/11/7.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "MYNavControllerTransitioningDelegateV2.h"
#import "MYViewControllerAnimatedTransitioningV2.h"

@interface MYNavControllerTransitioningDelegateV2 ()

@property (assign, nonatomic) BOOL interActiving;

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition* percentDrivenInteractiveTransition;
@property (strong, nonatomic) MYViewControllerAnimatedTransitioningV2 *animation;

@property (strong, nonatomic) UINavigationController *navController;

@end

@implementation MYNavControllerTransitioningDelegateV2

- (instancetype)initWithNavigationController:(UINavigationController *)controller{
    if(self = [super init]){
        _navController = controller;
        [controller setDelegate:self];
        
        _animation = [[MYViewControllerAnimatedTransitioningV2 alloc] init];
        _percentDrivenInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        
        _interactivePopPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [_navController.view addGestureRecognizer:_interactivePopPanGestureRecognizer];
        
        _interactivePopEdgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        _interactivePopEdgePanGestureRecognizer.edges = UIRectEdgeLeft;
        [_navController.view addGestureRecognizer:_interactivePopEdgePanGestureRecognizer];
    }
    return self;
}



#pragma mark private methods

-(void)handleGesture:(UIPanGestureRecognizer *)gesture {
    UIView* view = self.navController.view;
    CGPoint translation = [gesture translationInView:gesture.view];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            _interActiving = YES;
            if([self.navController.viewControllers count] > 1){
                [self.navController popViewControllerAnimated:YES];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGFloat fraction = translation.x / view.bounds.size.width;
            if(fraction < 0)
                fraction = 0;
                [_percentDrivenInteractiveTransition updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            _interActiving = NO;
            CGFloat fraction = translation.x / view.bounds.size.width;
            if ((fraction > 0 && fraction < 0.5) || gesture.state == UIGestureRecognizerStateCancelled || fraction <=0) {
                [_percentDrivenInteractiveTransition cancelInteractiveTransition];
            } else {
                [_percentDrivenInteractiveTransition finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark UINavigationControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        _animation.type  = UIViewControllerPresentTransitionTypePop;
        return _animation;
    }else  if (operation == UINavigationControllerOperationPush) {
        _animation.type  = UIViewControllerPresentTransitionTypePush;
        return _animation;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return self.interActiving ? self.percentDrivenInteractiveTransition : nil;
}

@end
