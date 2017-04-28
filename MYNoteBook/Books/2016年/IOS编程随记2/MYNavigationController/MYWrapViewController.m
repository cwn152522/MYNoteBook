//
//  MYWrapViewController.m
//  MYNavigationController
//
//  Created by chenweinan on 16/11/8.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "MYWrapViewController.h"
#import "MYNavigationController.h"
#import "MYWrapNavigationController.h"
#import "UIViewController+MYWrapViewController.h"

@interface MYWrapViewController ()

@end

@implementation MYWrapViewController

+ (instancetype)wrapViewControler:(UIViewController<MYNavigationControllerCustomBar> *)controller{
    MYWrapNavigationController *wrapNavController;
    if([controller conformsToProtocol:@protocol(MYNavigationControllerCustomBar) ])
        wrapNavController = [[MYWrapNavigationController alloc] initWithNavigationBarClass:[controller myNavigationControllerCustomBar] toolbarClass:nil];
        else
     wrapNavController = [[MYWrapNavigationController alloc] init];
    wrapNavController.viewControllers = @[controller];
    MYWrapViewController *wrapViewController = [[MYWrapViewController alloc] init];
    [wrapViewController.view addSubview:wrapNavController.view];
    [wrapViewController addChildViewController:wrapNavController];
    controller.wrapViewController = wrapViewController;
    return wrapViewController;
}

- (UIViewController *)rootViewController{
    UIViewController *controller = [(UINavigationController *)self.childViewControllers[0] viewControllers][0];
    return controller;
}

@end
