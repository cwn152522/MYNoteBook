//
//  UISpringAnimationViewController.m
//  CAAnimation_Demo
//
//  Created by chenweinan on 16/10/30.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "UISpringAnimationViewController.h"

@interface UISpringAnimationViewController ()

@property (strong, nonatomic) UIView *redView;

@end

@implementation UISpringAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UISpringAnimation";
    _redView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 50, 50)];
    [_redView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_redView];
    _redView.layer.allowsEdgeAntialiasing = YES;
    // Do any additional setup after loading the view.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:5 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        weakSelf.redView.center = point;
        int a = arc4random() % 2;
        switch (a) {//背景色也会弹性变化
            case 0:
                [_redView setBackgroundColor:[UIColor orangeColor]];
                break;
            case 1:
                [_redView setBackgroundColor:[UIColor redColor]];
                break;
            default:
                break;
        }

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
