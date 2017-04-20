//
//  DrawAnimation_ViewController.m
//  MYNoteBook
//
//  Created by 伟南 陈 on 2017/4/20.
//  Copyright © 2017年 chenweinan. All rights reserved.
//

#import "DrawAnimation_ViewController.h"

@interface DrawAnimation_ViewController ()

@property (strong, nonatomic) CAShapeLayer *shapLayer;

@end

@implementation DrawAnimation_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绘图过程动画的实现";
    
    self.shapLayer = [CAShapeLayer layer];
    self.shapLayer.frame = CGRectMake(0, 300, CGRectGetWidth([UIScreen mainScreen].bounds), 40);
    
    self.shapLayer.lineWidth = 1;
    self.shapLayer.strokeColor = [UIColor redColor].CGColor;
    self.shapLayer.fillColor = [UIColor clearColor].CGColor;
    
    [self.view.layer addSublayer:self.shapLayer];
    
    // Do any additional setup after loading the view.
}
- (void)drawPath{
    //用贝塞尔曲线绘制
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 40 * sin( 2.0 * M_PI / 60  * 0))];
    for (int i = 1; i < CGRectGetWidth([UIScreen mainScreen].bounds); i ++) {
        CGFloat y = 40 * sin( 2.0 * M_PI / 60  * i) ;
        [path addLineToPoint:CGPointMake(i, y)];
    }
    
    self.shapLayer.path = path.CGPath;
    
    //使用CoreGraphic库方法绘图
    //    CGMutablePathRef path1 = CGPathCreateMutable();
    //    CGPathMoveToPoint(path1, nil, 0, 40 * cos( 2.0 * M_PI / 60  * 0));
    //    for (int i = 1; i < CGRectGetWidth([UIScreen mainScreen].bounds); i ++) {
    //        CGFloat y = 40 * cos( 2.0 * M_PI / 60  * i) ;
    //        CGPathAddLineToPoint(path1, nil, i, y);
    //    }
    //
    //    self.shapLayer.path = path1;
}

- (void)startAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 2.5f;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.shapLayer addAnimation:animation forKey:@"dfas"];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self drawPath];
    [self startAnimation];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self startAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
