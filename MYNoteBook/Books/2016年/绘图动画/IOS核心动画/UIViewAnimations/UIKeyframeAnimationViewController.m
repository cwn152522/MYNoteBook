//
//  UIKeyframeAnimationViewController.m
//  CAAnimation_Demo
//
//  Created by chenweinan on 16/10/30.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "UIKeyframeAnimationViewController.h"

@interface UIKeyframeAnimationViewController ()

@property (strong, nonatomic) UIView *redView;

@end

@implementation UIKeyframeAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UIKeyframeAnimation";
    _redView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 50, 50)];
    [_redView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_redView];
    _redView.layer.allowsEdgeAntialiasing = YES;
    // Do any additional setup after loading the view.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    __weak typeof(self) weakSelf = self;//暂时不支持path控制
    [UIView animateKeyframesWithDuration:4 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            weakSelf.redView.center = CGPointMake(50, 150);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.15 animations:^{
            weakSelf.redView.center = CGPointMake(45, 300);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.65 relativeDuration:0.25 animations:^{
            weakSelf.redView.center = CGPointMake(55, 400);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.9 relativeDuration:0.1 animations:^{
            weakSelf.redView.center = CGPointMake(80, 420);
        }];
    } completion:nil];
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
