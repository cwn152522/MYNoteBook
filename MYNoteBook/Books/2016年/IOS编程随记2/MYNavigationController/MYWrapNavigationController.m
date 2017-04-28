//
//  MYWrapNavigationController.m
//  MYNavigationController
//
//  Created by chenweinan on 16/11/8.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "MYWrapNavigationController.h"
#import "MYWrapViewController.h"
#import "MYNavigationController.h"
#import "UIViewController+MYWrapViewController.h"
#import <objc/runtime.h>

void didTapBackButton(id self, SEL _cmd){
    UIViewController *controller = (UIViewController *)self;
    [controller.navigationController popViewControllerAnimated:YES];
}

@interface MYWrapNavigationController ()

@end

@implementation MYWrapNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark public methods

- (NSArray *)myViewControllers{
    MYNavigationController *navController = (MYNavigationController *)self.navigationController;
        NSMutableArray *viewControllers = [NSMutableArray array];
        for (MYWrapViewController *wrapViewController in navController.viewControllers) {
            [viewControllers addObject:wrapViewController.rootViewController];
        }
        return viewControllers.copy;
}

#pragma mark handle events

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //找到外层navigationController，对viewController进行包裹，然后进行push
    MYWrapViewController *controller = [MYWrapViewController wrapViewControler:viewController];
    UIImage *backItemImage = [UIImage imageNamed:@"mynavigationitem_back"];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backItemImage style:UIBarButtonItemStylePlain target:viewController action:@selector(didTapBackButton)];
    viewController.navigationItem.hidesBackButton = YES;
    class_addMethod([viewController class], @selector(didTapBackButton), (IMP)didTapBackButton, "v@:");
    [self.navigationController pushViewController:controller animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    [(UIViewController *)[self.viewControllers objectAtIndex:0] setWrapViewController:nil];//必须置空，否则循环引用导致viewcontroller不能释放
    return [self.navigationController popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    MYWrapViewController *wrapViewController = (MYWrapViewController*)viewController.wrapViewController;
    [(UIViewController *)[self.viewControllers objectAtIndex:0] setWrapViewController:nil];//必须置空，否则循环引用导致viewcontroller不能释放
    return [self.navigationController popToViewController:wrapViewController animated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    [(UIViewController *)[self.viewControllers objectAtIndex:0] setWrapViewController:nil];//必须置空，否则循环引用导致viewcontroller不能释放
    return [self.navigationController popToRootViewControllerAnimated:animated];
}

#pragma mark private methods

- (void)didTapBackButton{
//    [ (UIViewController *)[self.viewControllers objectAtIndex:0] setWrapViewController:nil];//必须置空，否则循环引用导致viewcontroller不能释放
//    [self.navigationController popViewControllerAnimated:YES];
}

@end
