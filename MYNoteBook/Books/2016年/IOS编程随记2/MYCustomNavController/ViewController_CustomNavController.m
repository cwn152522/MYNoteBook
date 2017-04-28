//
//  ViewController_CustomNavController.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/27.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_CustomNavController.h"
#import "AppDelegate.h"
#import "MYViewControllerTransitioningDelegate.h"

@interface ViewController_CustomNavController ()

@end

@implementation ViewController_CustomNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:243/255.0 green:212/255.0 blue:149/255.0 alpha:1];
    UIImage *navigationBackgroundImage = [(AppDelegate*)[[UIApplication sharedApplication] delegate] imageWithColor:[UIColor colorWithRed:243/255.0 green:212/255.0 blue:149/255.0 alpha:1] size:CGSizeMake([[UIScreen mainScreen] bounds].size.width, 64)];
    [self.navigationController.navigationBar setBackgroundImage:navigationBackgroundImage forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (IBAction)onClickPushViewController:(UIButton *)sender {
    UIViewController *controller = [[UIStoryboard storyboardWithName:@"CustomNav" bundle:nil] instantiateViewControllerWithIdentifier:@"second"];
    //    MYViewControllerTransitioningDelegate *delegate = [[MYViewControllerTransitioningDelegate alloc] init];
    //    controller.transitioningDelegate = delegate;
    //    [self presentViewController:controller animated:YES completion:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)popViewController:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
