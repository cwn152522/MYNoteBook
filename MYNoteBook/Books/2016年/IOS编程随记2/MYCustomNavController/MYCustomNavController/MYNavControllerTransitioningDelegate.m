//
//  MYNavControllerTransitioningDelegate.m
//  MYNavigationControllerDemo
//
//  Created by chenweinan on 16/11/7.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "MYNavControllerTransitioningDelegate.h"
#import "MYViewControllerAnimatedTransitioning.h"

@interface MYNavControllerTransitioningDelegate ()

@property (assign, nonatomic) BOOL interActiving;

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition* percentDrivenInteractiveTransition;
@property (strong, nonatomic) MYViewControllerAnimatedTransitioning *animation;

@property (strong, nonatomic) UINavigationController *navController;

@end

@implementation MYNavControllerTransitioningDelegate

- (instancetype)initWithNavigationController:(UINavigationController *)controller{
    if(self = [super init]){
        _navController = controller;
        _navController.interactivePopGestureRecognizer.enabled = NO;
        [controller setDelegate:self];
        
        _animation = [[MYViewControllerAnimatedTransitioning alloc] init];
        _percentDrivenInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        
        UIScreenEdgePanGestureRecognizer *edgePanRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        edgePanRecognizer.edges = UIRectEdgeLeft;
        [_navController.view addGestureRecognizer:edgePanRecognizer];
    }
    return self;
}

#pragma mark private methods

- (void)navigationControllerPreparedForPush{
    [_animation shotNavigationBarForPush:YES popToVcIndex:0];
}

- (void)navigationControllerPreparedForPop:(UIViewController *)toVc{
    NSInteger index = [self.navController.viewControllers indexOfObject:toVc];
    [_animation shotNavigationBarForPush:NO popToVcIndex:index];
}

-(void)handleGesture:(UIPanGestureRecognizer *)gesture {
    UIView* view = self.navController.view;
    CGPoint translation = [gesture translationInView:gesture.view];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            _interActiving = YES;
            if([self.navController.viewControllers count] > 1)
            [self.navController popViewControllerAnimated:YES];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGFloat fraction = fabs(translation.x / view.bounds.size.width);
            [_percentDrivenInteractiveTransition updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            _interActiving = NO;
            CGFloat fraction = fabs(translation.x / view.bounds.size.width);
            if (fraction < 0.5 || [gesture velocityInView:view].x < 0 || gesture.state == UIGestureRecognizerStateCancelled) {
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
