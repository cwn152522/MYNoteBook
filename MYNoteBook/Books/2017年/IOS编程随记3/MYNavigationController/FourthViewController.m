//
//  FourthViewController.m
//  MYNavigationControllerDemo
//
//  Created by 伟南 陈 on 2017/5/5.
//  Copyright © 2017年 chenweinan. All rights reserved.
//

#import "FourthViewController.h"
#import "MYNavigationControllerV2.h"

@interface FourthViewController ()

@end

@implementation FourthViewController

- (void)dealloc{
    NSLog(@"页面内存已释放");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar_hidden = YES;
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.popPanGestureEnabled = NO;
}

- (IBAction)onClickPopBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
