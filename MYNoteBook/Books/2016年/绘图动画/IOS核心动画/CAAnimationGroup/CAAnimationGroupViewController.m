//
//  CAAnimationGroupViewController.m
//  CAAnimation_Demo
//
//  Created by chenweinan on 16/10/30.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "CAAnimationGroupViewController.h"

@interface CAAnimationGroupViewController ()

@property (strong, nonatomic) CALayer *layer;

@end

@implementation CAAnimationGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CAAnimationGroup";
    _layer = [[CALayer alloc] init];
    _layer.bounds = CGRectMake(0, 0, 10, 20);
    _layer.position = CGPointMake(50, 150);
    _layer.backgroundColor = [UIColor redColor].CGColor;
    _layer.allowsEdgeAntialiasing = YES;
    [self.view.layer addSublayer:_layer];
    self.view.backgroundColor = [UIColor orangeColor];
    [self groupAnimation];
    // Do any additional setup after loading the view.
}

- (CABasicAnimation *)rotationAnimation{
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    [basicAnimation setAutoreverses:YES];
    [basicAnimation setRemovedOnCompletion:NO];
    [basicAnimation setToValue:@(M_PI_2 * 3.5)];
    [basicAnimation setValue:@(M_PI_2 * 3.5) forKey:@"lastRotation"];
    return basicAnimation;
}

- (CAKeyframeAnimation *)translationAnimation{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint: _layer.position];
    [path addCurveToPoint:CGPointMake(_layer.position.x, _layer.position.y + 300) controlPoint1:CGPointMake(_layer.position.x + 50, _layer.position.y + 100) controlPoint2:CGPointMake(_layer.position.x  - 50, _layer.position.y + 300 - 100)];
    animation.path = path.CGPath;
    
    [animation setValue:[NSValue valueWithCGPoint:CGPointMake(_layer.position.x, _layer.position.y + 300)] forKey:@"lastPoint"];
    return animation;
}

- (void)groupAnimation{
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    CABasicAnimation *basicAnimation = [self rotationAnimation];
    CAKeyframeAnimation *keyAnimation = [self translationAnimation];
    animationGroup.animations = @[basicAnimation, keyAnimation];
    animationGroup.delegate = self;
    animationGroup.duration = 8;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.beginTime = CACurrentMediaTime() + 5;
    [_layer addAnimation:animationGroup forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    CAAnimationGroup *group = (CAAnimationGroup *)anim;
    CABasicAnimation *basicAnimation = (CABasicAnimation *)group.animations[0];
    CAKeyframeAnimation *keyfFrameAnimation = (CAKeyframeAnimation *)group.animations[1];
    
    CGFloat toValue = [[basicAnimation valueForKey:@"lastRotation"] floatValue];
    CGPoint endPoint = [[keyfFrameAnimation valueForKey:@"lastPoint"]CGPointValue];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    _layer.position = endPoint;
    _layer.transform = CATransform3DMakeRotation(toValue, 0, 0, 1);
    
    [CATransaction commit];
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
