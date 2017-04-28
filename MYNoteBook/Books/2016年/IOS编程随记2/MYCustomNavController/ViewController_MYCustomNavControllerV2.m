//
//  ViewController_MYCustomNavControllerV2.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/27.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_MYCustomNavControllerV2.h"
#import "AppDelegate.h"
#import "MYViewControllerTransitioningDelegate.h"

@interface ViewController_MYCustomNavControllerV2 ()

@end

@implementation ViewController_MYCustomNavControllerV2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    UIImage *navigationBackgroundImage = [(AppDelegate*)[[UIApplication sharedApplication] delegate] imageWithColor:[UIColor blueColor] size:CGSizeMake([[UIScreen mainScreen] bounds].size.width, 64)];
    [self.navigationController.navigationBar setBackgroundImage:navigationBackgroundImage forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickDismissViewController:(UIButton *)sender {
    //    MYViewControllerTransitioningDelegate *delegate = [[MYViewControllerTransitioningDelegate alloc] init];
    //    self.transitioningDelegate = delegate;
    //    [self dismissViewControllerAnimated:YES completion:nil];
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
