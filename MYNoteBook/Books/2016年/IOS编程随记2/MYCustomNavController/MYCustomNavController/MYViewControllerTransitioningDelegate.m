//
//  MYViewControllerTransition.m
//  MYNavigationControllerDemo
//
//  Created by chenweinan on 16/11/6.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "MYViewControllerTransitioningDelegate.h"
#import "MYViewControllerAnimatedTransitioning.h"

@interface MYViewControllerTransitioningDelegate ()

@property (nonatomic, strong) MYViewControllerAnimatedTransitioning *animatedTransitioning;

@end

@implementation MYViewControllerTransitioningDelegate

- (instancetype)init{
    if(self = [super init]){
        self.animatedTransitioning = [[MYViewControllerAnimatedTransitioning alloc] init];
    }
    return self;
}

#pragma mark UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
     self.animatedTransitioning.type = UIViewControllerPresentTransitionTypePresent;
    return self.animatedTransitioning;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
     self.animatedTransitioning.type = UIViewControllerPresentTransitionTypeDismiss;
    return self.animatedTransitioning;
}

@end
