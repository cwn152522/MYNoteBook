//
//  CABasicAnimationViewController.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/26.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "CABasicAnimationViewController.h"

@interface CABasicAnimationViewController ()

@property (strong, nonatomic) CALayer *layer;

@end

@implementation CABasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CABasicAnimation";
    _layer = [[CALayer alloc] init];
    _layer.bounds = CGRectMake(0, 0, 50, 50);
    _layer.position = CGPointMake(25, 100);
    _layer.allowsEdgeAntialiasing = YES;//防止边缘锯齿
    _layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:_layer];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    CAAnimation *animation = [_layer animationForKey:@"translation"];
    if(animation){
        if(_layer.speed == 1){
            [self animationPause];
        }else{
            [self animationResume];
        }
    }else{
        CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        [basicAnimation setValue:[NSValue valueWithCGPoint:point] forKey:@"KCBasicAnimationLocation"];
        [basicAnimation setDuration:5.f];
        [basicAnimation setToValue:[NSValue valueWithCGPoint:point]];
        [basicAnimation setBeginTime:CACurrentMediaTime()];
        [basicAnimation setFillMode:kCAFillModeForwards];
        [basicAnimation setDelegate:self];
        [basicAnimation setRemovedOnCompletion:NO];
        [_layer addAnimation:basicAnimation forKey:@"translation"];
        [self beginRotationObject];
    }
}

- (void)beginRotationObject{
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    [basicAnimation setDuration:0.8];
    [basicAnimation setRepeatCount:CGFLOAT_MAX];
    [basicAnimation setAutoreverses:YES];
    [basicAnimation setRemovedOnCompletion:NO];
    [basicAnimation setToValue:@(M_PI_2 * 3)];
    [_layer addAnimation:basicAnimation forKey:@"rotation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    CGPoint point = [[anim valueForKey:@"KCBasicAnimationLocation"] CGPointValue];
    _layer.position = point;
    [self animationPause];
    
    [CATransaction commit];
}

- (void)animationPause{
    NSLog(@"%f", [_layer convertTime:CACurrentMediaTime() fromLayer:nil]);
    CFTimeInterval interval = [_layer convertTime:CACurrentMediaTime() fromLayer:nil];
    [_layer setTimeOffset:interval];
    _layer.speed = 0;
}

- (void)animationResume{
    CFTimeInterval pausetime = _layer.timeOffset;
    _layer.timeOffset = 0;
    _layer.beginTime = 0;
    _layer.speed = 1;
    CFTimeInterval interval = [_layer convertTime:CACurrentMediaTime() fromLayer:nil]  -  pausetime;
    _layer.beginTime = interval;
}

- (IBAction)onClickNextController:(UIButton *)sender {
    switch (sender.tag) {
        case 1:{//帧动画
            UIViewController *controller = [[UIStoryboard storyboardWithName:@"CoreAnimation" bundle:nil] instantiateViewControllerWithIdentifier:@"aaa"];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 2:{//动画组
            UIViewController *controller = [[UIStoryboard storyboardWithName:@"CoreAnimation" bundle:nil] instantiateViewControllerWithIdentifier:@"bbb"];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 3:{//转场动画
            UIViewController *controller = [[UIStoryboard storyboardWithName:@"CoreAnimation" bundle:nil] instantiateViewControllerWithIdentifier:@"ccc"];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 4:{//UIView封装的动画
            UIViewController *controller = [[UIStoryboard storyboardWithName:@"CoreAnimation" bundle:nil] instantiateViewControllerWithIdentifier:@"basic"];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        default:
            break;
    }
}


@end
