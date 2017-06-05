//
//  SecondViewController.m
//  MYNavigationControllerDemo
//
//  Created by chenweinan on 16/11/6.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "SecondViewController.h"
#import "AppDelegate.h"
#import "NavigationView.h"
#import "MYNavigationControllerV2.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)dealloc{
    NSLog(@"页面内存已释放");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar_rightTitle = @"返回";
    self.navigationBar_title = @"特色指标";
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.popEdgePanGestureEnabled = YES;
}

- (IBAction)onClickDismissViewController:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark NavigationViewDelegate

- (void)navigationViewLeftDlegate{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navigationViewReghtDlegate{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
