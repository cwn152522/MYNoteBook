//
//  CATransitionViewController.m
//  CAAnimation_Demo
//
//  Created by chenweinan on 16/10/30.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "CATransitionViewController.h"
#import "ViewController.h"

@interface CATransitionViewController ()

@property (strong, nonatomic) UIView *centerView;

@end

@implementation CATransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CATransition";
    _centerView = [[UIView alloc] init];
    [_centerView setBounds:CGRectMake(0, 0, 200, 100)];
    [_centerView setCenter:CGPointMake(self.view.center.x, 120)];
    [_centerView.layer setBackgroundColor:[UIColor blueColor].CGColor];
    [self.view addSubview:_centerView];
    // Do any additional setup after loading the view.
}
- (IBAction)onClickTransitionView:(UIButton *)sender {
    CATransition *transition = [CATransition animation];
    transition.type = @"pageCurl";
    transition.subtype = kCATransitionFromLeft;
    transition.duration = 1.0f;
    [_centerView.layer addAnimation:transition forKey:@"pageCurl"];
}
- (IBAction)onClickTransitionController:(UIButton *)sender {
    ViewController *controller = [[ViewController alloc] init];
    CATransition *transition = [[CATransition  alloc] init];
    transition.type = @"rippleEffect";
    transition.duration = 1.0f;
    [self.navigationController.navigationController.view.layer addAnimation:transition forKey:@"rippleEffect"];
    [self.navigationController pushViewController:controller animated:NO];
    //    [self.view.window.layer addAnimation:transition forKey:@"rippleEffect"];
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
