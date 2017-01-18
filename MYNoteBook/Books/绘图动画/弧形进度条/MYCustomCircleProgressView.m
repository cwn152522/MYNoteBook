//
//  MYCustomCircleProgressView.m
//  MYNoteBook
//
//  Created by chenweinan on 16/12/9.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "MYCustomCircleProgressView.h"

@interface MYCustomCircleProgressView ()

@property (assign, nonatomic) CGSize size;
@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end

@implementation MYCustomCircleProgressView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        self.lineColor = [UIColor grayColor];
        self.lineWidth = 2.0f;
        self.circleLayer = [[CAShapeLayer alloc] init];
        self.circleLayer.fillColor = [UIColor clearColor].CGColor;
        self.circleLayer.allowsEdgeAntialiasing = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGFloat radius = MIN(rect.size.width, rect.size.height);
    self.size = CGSizeMake(radius, radius);
}

#pragma mark Private Methods

- (void)drawCircleProgressLayer{
    [self.layer setOpacity:1];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.size.width/2, self.size.height/2) radius:self.size.width/2 - self.lineWidth startAngle:0.1 endAngle:M_PI * 2 clockwise:YES];
    self.circleLayer.path = path.CGPath;
    self.circleLayer.frame = CGRectMake(0, 0, self.size.width, self.size.height);
    self.circleLayer.lineWidth = self.lineWidth;
    self.circleLayer.lineCap = kCALineCapRound;
    self.circleLayer.allowsEdgeAntialiasing = YES;
    self.circleLayer.strokeColor = self.lineColor.CGColor;
    [self.layer addSublayer:self.circleLayer];
    
    
    //  创建 CAGradientLayer 对象
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    //  设置 gradientLayer 的 Frame
    gradientLayer1.frame = CGRectMake(0, self.size.height/2, self.size.width, self.size.height/2);
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer1.colors = @[(id)[UIColor groupTableViewBackgroundColor].CGColor, (id)[UIColor grayColor].CGColor];
    //  设置两种颜色变化点，取值范围 0.0~1.0
    gradientLayer1.locations = @[@(0.1f), @(0.9f)];
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer1.startPoint = CGPointMake(1, 0.5);
    gradientLayer1.endPoint = CGPointMake(0, 0.5);
    //  添加渐变色到创建的 UIView 上去
    [gradientLayer addSublayer:gradientLayer1];
    
    CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];
    gradientLayer2.frame = CGRectMake(0, 0, self.size.width, self.size.height/2);
    gradientLayer2.colors = @[(id)[UIColor grayColor].CGColor, (id)[UIColor grayColor].CGColor];
    gradientLayer2.locations = @[@(0.1f), @(0.9f)];
    gradientLayer1.startPoint = CGPointMake(1, 0.5);
    gradientLayer1.endPoint = CGPointMake(0, 0.5);
    [gradientLayer addSublayer:gradientLayer2];
    
    [self.layer addSublayer:gradientLayer];
    [gradientLayer setMask:_circleLayer];
}

#pragma mark Public Methods

- (void)startAnimating{
    if(self.isLoading){
        return;
    }
    
    [self drawCircleProgressLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 3.0f;
    animation.toValue = @(M_PI *2);
    animation.removedOnCompletion = NO;
    animation.repeatCount = INT_MAX;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:animation forKey:@"rotation"];
    _isLoading = YES;
    
    CABasicAnimation *interAnimation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    interAnimation1.duration = 1.0f;
    interAnimation1.fromValue = @0;
    interAnimation1.toValue = @1;
    interAnimation1.beginTime = 0;
    interAnimation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *interAnimation2 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    interAnimation2.duration = 1.0f;
    interAnimation2.fromValue = @0;
    interAnimation2.toValue = @1;
    interAnimation2.beginTime = 1;
    interAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *interAnimations = [CAAnimationGroup animation];
    interAnimations.duration = 2.0f;
    interAnimations.fillMode = kCAFillModeForwards;
    interAnimations.animations = @[interAnimation1, interAnimation2];
    interAnimations.repeatCount = INT_MAX;
    interAnimations.removedOnCompletion = NO;
    [self.circleLayer addAnimation:interAnimations forKey:@"interAnimations"];
}

- (void)stopAnimating{
    if(!_isLoading)
        return;
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [self.layer setOpacity:0];
    [CATransaction commit];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 0.33;
    animation.fromValue = @1;
    animation.toValue = @0;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    [self.layer addAnimation:animation forKey:@"opacity"];
}

#pragma mark CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if(flag){
        _isLoading = NO;
        [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
