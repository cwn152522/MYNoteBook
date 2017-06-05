//
//  ViewController.m
//  MYNavigationControllerDemo
//
//  Created by chenweinan on 16/11/6.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_MYNav.h"
#import "AppDelegate.h"
#import "MYNavigationControllerV2.h"

@interface ViewController_MYNav ()

@end

@implementation ViewController_MYNav

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar_title = @"MYNavigationController";
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)onClickPushViewController:(UIButton *)sender {
    UIViewController *controller = [[UIStoryboard storyboardWithName:@"MYNav" bundle:nil] instantiateViewControllerWithIdentifier:@"second"];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)onClickDissmissViewController:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
