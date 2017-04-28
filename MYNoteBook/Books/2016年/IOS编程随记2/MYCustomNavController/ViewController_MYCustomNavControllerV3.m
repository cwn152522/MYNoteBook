//
//  ViewController_MYCustomNavControllerV3.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/27.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_MYCustomNavControllerV3.h"
#import "AppDelegate.h"

@interface ViewController_MYCustomNavControllerV3 ()

@end

@implementation ViewController_MYCustomNavControllerV3

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
    UIImage *navigationBackgroundImage = [(AppDelegate*)[[UIApplication sharedApplication] delegate] imageWithColor:[UIColor greenColor] size:CGSizeMake([[UIScreen mainScreen] bounds].size.width, 64)];
    [self.navigationController.navigationBar setBackgroundImage:navigationBackgroundImage forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)popToRootViewController:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
