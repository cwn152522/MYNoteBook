//
//  UIViewBasicAnimation.m
//  CAAnimation_Demo
//
//  Created by chenweinan on 16/10/30.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "UIBasicAnimationViewController.h"

@interface UIBasicAnimationViewController ()

@property (strong, nonatomic) UIView *redView;

@end

@implementation UIBasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UIBasicAnimation";
    
    _redView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 50, 50)];
    [_redView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_redView];
    _redView.layer.allowsEdgeAntialiasing = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickNextController:(UIButton *)sender {
    switch (sender.tag) {
        case 1:{//弹簧动画
            UIViewController *controller = [[UIStoryboard storyboardWithName:@"CoreAnimation" bundle:nil] instantiateViewControllerWithIdentifier:@"ddd"];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 2:{//帧动画
            UIViewController *controller = [[UIStoryboard storyboardWithName:@"CoreAnimation" bundle:nil] instantiateViewControllerWithIdentifier:@"eee"];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 3:{//转场动画
            UIViewController *controller = [[UIStoryboard storyboardWithName:@"CoreAnimation" bundle:nil] instantiateViewControllerWithIdentifier:@"fff"];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        weakSelf.redView.center = point;
    } completion:nil];
    
    
    [UIView beginAnimations:@"changeBackground" context:nil];
    [UIView setAnimationDuration:5];
    [UIView setAnimationDelay:0];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:0];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    int a = arc4random() % 2;
    switch (a) {
        case 0:
             [_redView setBackgroundColor:[UIColor orangeColor]];
            break;
        case 1:
             [_redView setBackgroundColor:[UIColor redColor]];
            break;
        default:
            break;
    }
    [UIView commitAnimations];
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
