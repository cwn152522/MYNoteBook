//
//  MYNavigationController.m
//  MYNavigationController
//
//  Created by chenweinan on 16/11/8.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "MYNavigationController.h"
#import "MYWrapViewController.h"

@interface MYNavigationController ()

@end

@implementation MYNavigationController

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        UIViewController *rootViewController = [self.viewControllers firstObject];
        self.viewControllers = @[];//必须先置空后重新添加，重新初始化视图，否者rootViewController先初始化，导致后面显示异常，如首页title不显示
        return  [self initWithRootViewController:rootViewController];
    }
    return self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if(self = [super init]){
        MYWrapViewController *wrapViewController = [MYWrapViewController wrapViewControler:rootViewController];
        self.viewControllers = @[wrapViewController];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.hidden = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
