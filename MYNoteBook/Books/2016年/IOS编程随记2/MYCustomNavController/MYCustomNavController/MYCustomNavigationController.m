//
//  MYNavigationController.m
//  MYNavigationControllerDemo
//
//  Created by chenweinan on 16/11/6.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "MYCustomNavigationController.h"
#import "MYNavControllerTransitioningDelegate.h"

@interface MYCustomNavigationController ()

@property (nonatomic, strong) MYNavControllerTransitioningDelegate *navDelegate;

@end

@implementation MYCustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navDelegate = [[MYNavControllerTransitioningDelegate alloc] initWithNavigationController:self];
    [self.navigationBar setBackgroundImage:[self imageWithColor:[UIColor brownColor] size:CGSizeMake(1, 1)] forBarMetrics:UIBarMetricsDefault];
    // Do any additional setup after loading the view.
}

#pragma override methods

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self.navDelegate navigationControllerPreparedForPush];
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    NSAssert([self.viewControllers count] > 1, @"navigationcontroller.viewControllers.count must over 1 to enable popViewController");
    UIViewController *toVc = [self.viewControllers objectAtIndex:self.viewControllers.count - 2];
    [self.navDelegate navigationControllerPreparedForPop:toVc];
    return [super popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self.navDelegate navigationControllerPreparedForPop:viewController];
    return [super popToViewController:viewController animated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    UIViewController *controller = [self.viewControllers firstObject];
    [self.navDelegate navigationControllerPreparedForPop:controller];
    return [super popToRootViewControllerAnimated:animated];
}

#pragma mark private methods
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
