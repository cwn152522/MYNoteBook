//
//  MYViewControllerAnimatedTransition.m
//  MYNavigationControllerDemo
//
//  Created by chenweinan on 16/11/7.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "MYViewControllerAnimatedTransitioning.h"

static const float kTransitionDuration = .33;

@interface MYViewControllerAnimatedTransitioning ()

@property (strong, nonatomic) NSMutableArray *navBarImagesShotdForPush;
@property (strong, nonatomic) UIImage *navBarImageShotdForPop;

@property (assign, nonatomic) BOOL trulyIsTranslucent;//push页面后的navBar值

@end

@implementation MYViewControllerAnimatedTransitioning

- (instancetype)init{
    if(self = [super init]){
        _navBarImagesShotdForPush = [NSMutableArray array];
    }
    return self;
}

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
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containView = [transitionContext containerView];
    [containView addSubview:toViewController.view];
    
    CGRect rect = [transitionContext finalFrameForViewController:toViewController];
    rect.origin.x = 0;
    rect.origin.y = rect.size.height;
    toViewController.view.frame = rect;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
     CGRect frame = rect;
        frame.origin.x = 0;
        frame.origin.y = 0;
        toViewController.view.frame = frame;
    } completion:^(BOOL finished) {
        BOOL isCanceled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCanceled];
    }];
}

- (void)animateDissmissTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containView = [transitionContext containerView];
    [containView addSubview:toViewController.view];
    //        1.NSLog(@"%@", containView.subviews);
    [containView addSubview:fromViewController.view];
    //        2.NSLog(@"%@", containView.subviews);//两次log视图数一样，说明：不会重复添加动画视图
    
    CGRect rect = [transitionContext initialFrameForViewController:fromViewController];
    toViewController.view.frame = rect;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = rect;
        frame.origin.x = 0;
        frame.origin.y = rect.size.height;
        fromViewController.view.frame = frame;
    } completion:^(BOOL finished) {
        //        1.NSLog(@"%@", containView.subviews);
        BOOL isCanceled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCanceled];
        //        2.NSLog(@"%@", containView.subviews);//第二次log为空，说明：结束系统自动清除使用完毕的transitionContext动画视图
    }];
}

- (void)animatePushTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromViewController= [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *naviBar = fromViewController.navigationController.navigationBar;
    UIView *containView = [transitionContext containerView];
    [containView addSubview:toViewController.view];
    [containView addSubview:naviBar];
    
    CGRect rect = [transitionContext finalFrameForViewController:toViewController];
    rect.origin.x = [[UIScreen mainScreen] bounds].size.width;
    BOOL isTranslucent = toViewController.navigationController.navigationBar.translucent;
    _trulyIsTranslucent = isTranslucent;
    CGFloat offset = isTranslucent  == NO?64:0;
    rect.origin.y = offset;
    toViewController.view.frame = rect;
    
    CGRect navRect = naviBar.frame;
    navRect.origin.x = [[UIScreen mainScreen] bounds].size.width;
    naviBar.frame = navRect;
    
    UIImageView *imageView =[[UIImageView alloc] initWithImage:[self.navBarImagesShotdForPush lastObject]];
    imageView.frame = CGRectMake(0, -offset, rect.size.width, 64);
    [fromViewController.view addSubview:imageView];
    
    toViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;//添加阴影
    toViewController.view.layer.shadowOffset = CGSizeMake(0, -128);
    toViewController.view.layer.shadowRadius = 3;
    toViewController.view.layer.shadowOpacity = 0.8;
    toViewController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, toViewController.view.frame.size.width, toViewController.view.frame.size.height + 128)].CGPath;
    
     [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = rect;
        frame.origin.x = 0;
        frame.origin.y = offset;
        toViewController.view.frame = frame;
        
        CGRect navRect1 = naviBar.frame;
        navRect1.origin.x = 0;
        naviBar.frame = navRect1;
        
        frame.origin.x = - [[UIScreen mainScreen] bounds].size.width/2;
        frame.origin.y = offset;
        fromViewController.view.frame = frame;
    } completion:^(BOOL finished) {
        BOOL isCanceled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCanceled];
        if(!isCanceled){
            [imageView removeFromSuperview];
        }
    }];
}

- (void)animatePopTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containView = [transitionContext containerView];
    UIView *fromViewControllerView = [containView.subviews firstObject];//No:1 -> No:3
    UIView *naviBar = [containView.subviews lastObject];//No:2 -> No:1
    [containView addSubview:toViewController.view];//No:2
    [containView bringSubviewToFront:fromViewControllerView];
    
    CGRect rect = [transitionContext finalFrameForViewController:toViewController];
    rect.origin.x = -[[UIScreen mainScreen] bounds].size.width/2;
    toViewController.view.frame = rect;
    
    BOOL isTranslucent = toViewController.navigationController.navigationBar.translucent;
    CGFloat offset = isTranslucent  == NO?64:0;
    //在pop出栈数大于1时(如popToRootViewController)，translucent居然临时变成YES了？？？导致navBar截图添加位置错误！！！
    if(!isTranslucent && _trulyIsTranslucent == YES)
        offset = 0;
    
    UIImageView *fromViewNavBar =[[UIImageView alloc] initWithImage:self.navBarImageShotdForPop];
    fromViewNavBar.frame = CGRectMake(0, -offset, rect.size.width, 64);
    [fromViewControllerView addSubview:fromViewNavBar];
    
    UIImageView *toViewNavBar =[[UIImageView alloc] initWithImage:[self.navBarImagesShotdForPush lastObject]];
    toViewNavBar.frame = CGRectMake(0, -offset, rect.size.width, 64);
    [toViewController.view addSubview:toViewNavBar];
    
    fromViewControllerView.layer.shadowColor = [UIColor blackColor].CGColor;//(2)pop前把(1)操作取消的阴影加上
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = rect;
        frame.origin.x = 0;
        frame.origin.y = offset;
        toViewController.view.frame = frame;
        
        frame.origin.x = [[UIScreen mainScreen] bounds].size.width;
        frame.origin.y = offset;
        fromViewControllerView.frame = frame;
    } completion:^(BOOL finished) {
        BOOL isCanceled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCanceled];
        if(!isCanceled){
            [containView bringSubviewToFront:naviBar];
            toViewController.view.layer.shadowColor = [UIColor clearColor].CGColor;//(1)解决pop结束阴影还在
            [fromViewNavBar removeFromSuperview];
            [toViewNavBar removeFromSuperview];
            [_navBarImagesShotdForPush removeLastObject];
        }else{//手势取消，containtView结构复位
            [fromViewNavBar removeFromSuperview];
            [toViewNavBar removeFromSuperview];
            [containView bringSubviewToFront:fromViewControllerView];
            [containView bringSubviewToFront:naviBar];
        }
    }];
}

- (void)shotNavigationBarForPush:(BOOL)flag popToVcIndex:(NSInteger)index{//index为popTo的页面
    CGSize size = [[UIScreen mainScreen] bounds].size;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, 64), YES, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[[[UIApplication sharedApplication] keyWindow] layer] renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if(flag){//push前的截屏
        [self.navBarImagesShotdForPush addObject: image];
    }
    else{//pop前的截屏
        NSInteger num = _navBarImagesShotdForPush.count;
        if(num > index + 1){//只保存至当前pop页面的前一个页面及index以前的保留即可
            [_navBarImagesShotdForPush removeObjectsInRange:NSMakeRange(index + 1, num - 1)];
        }
        self.navBarImageShotdForPop = image;//截取当前即将pop的页面
    }
}



@end
