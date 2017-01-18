//
//  UITransitionViewController.m
//  CAAnimation_Demo
//
//  Created by chenweinan on 16/10/30.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "UITransitionViewController.h"
#import "UIBasicAnimationViewController.h"

@interface UITransitionViewController ()

@property (strong, nonatomic) UIView *centerView;

@end

@implementation UITransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UITransitionAnimation";
    _centerView = [[UIView alloc] init];
    [_centerView setBounds:CGRectMake(0, 0, 200, 100)];
    [_centerView setCenter:CGPointMake(self.view.center.x, 120)];
    [_centerView.layer setBackgroundColor:[UIColor blueColor].CGColor];
    [self.view addSubview:_centerView];
    // Do any additional setup after loading the view.
}

- (IBAction)onClickTransitionView:(UIButton *)sender {
    [UIView transitionWithView:_centerView duration:1.0f options:UIViewAnimationOptionTransitionCurlUp animations:^{
    } completion:nil];
}

- (IBAction)onClickTransitionController:(UIButton *)sender {
    UIBasicAnimationViewController *controller = [[UIBasicAnimationViewController alloc] init];
    [self.navigationController pushViewController:controller animated:NO];
    [UIView transitionFromView:self.view toView:controller.view duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
    }];
    //    [self presentViewController:controller animated:NO completion:nil];
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
