//
//  ThirdViewController.m
//  MYNavigationControllerDemo
//
//  Created by chenweinan on 16/11/7.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ThirdViewController.h"
#import "AppDelegate.h"
#import "NavigationView.h"
#import "MYNavigationControllerV2.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)dealloc{
    NSLog(@"页面内存已释放");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar_leftTitle = @"返回";
    self.navigationBar_title = @"特色指标子页面";
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.popPanGestureEnabled = YES;
}

- (IBAction)popToRootViewController:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark NavigationViewDelegate

- (void)navigationViewLeftDlegate{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
