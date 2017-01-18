//
//  CAKeyframeAnimationViewController.m
//  CAAnimation_Demo
//
//  Created by chenweinan on 16/10/30.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "CAKeyframeAnimationViewController.h"

@interface CAKeyframeAnimationViewController ()

@property (strong, nonatomic) CALayer *layer;

@end

@implementation CAKeyframeAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"CAKeyframeAnimation";
    _layer = [[CALayer alloc] init];
    _layer.bounds = CGRectMake(0, 0, 10, 20);
    _layer.position = CGPointMake(50, 150);
    _layer.backgroundColor = [UIColor redColor].CGColor;
    _layer.allowsEdgeAntialiasing = YES;
    [self.view.layer addSublayer:_layer];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //关键帧控制的两种方式 属性控制和绘图路径控制，后者优先于前者，设置路径则属性不起作用
//    [self translationAnimation];
    [self translationAnimation1];
}

- (void)translationAnimation{//属性数组
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *key0 = [NSValue valueWithCGPoint:CGPointMake(50, 150)];
    NSValue *key1 = [NSValue valueWithCGPoint:CGPointMake(80, 220)];
    NSValue *key2 = [NSValue valueWithCGPoint:CGPointMake(45, 300)];
    NSValue *key3 = [NSValue valueWithCGPoint:CGPointMake(55, 400)];
    NSValue *key4 = [NSValue valueWithCGPoint:CGPointMake(80, 420)];
    NSArray *values = @[key0, key1, key2, key3, key4];
    animation.values = values;
    animation.duration = 8.0f;
    animation.beginTime = CACurrentMediaTime() + 2;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [_layer addAnimation:animation forKey:@"translation"];
}

- (void)translationAnimation1{//贝赛尔路径
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 8.0f;
    animation.beginTime = CACurrentMediaTime() + 2;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint: _layer.position];
    [path addCurveToPoint:CGPointMake(_layer.position.x, _layer.position.y + 300) controlPoint1:CGPointMake(_layer.position.x + 50, _layer.position.y + 100) controlPoint2:CGPointMake(_layer.position.x  - 50, _layer.position.y + 300 - 100)];
    animation.path = path.CGPath;
    
    [_layer addAnimation:animation forKey:@"translation"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
