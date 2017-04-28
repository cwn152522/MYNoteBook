//
//  MYColorfulCircleProgressView.m
//  MYColorsProgressView
//
//  Created by chenweinan on 16/11/1.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "MYColorfulCircleProgressView.h"

@interface MYColorfulCircleProgressView ()

@property (strong, nonatomic) CAShapeLayer *backgroundLayer;
@property (strong, nonatomic) CAShapeLayer *cycleLayer;

@property (strong, nonatomic) CABasicAnimation *animation;

@end

@implementation MYColorfulCircleProgressView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self layoutIfNeeded];
        [self initialState:self.frame];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self  initialState:frame];
    }
    return self;
}

- (void)initialState:(CGRect)frame{
    if(frame.size.width != frame.size.height){
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.width);
    }
    _backgroundLayer = [CAShapeLayer layer];
    _backgroundLayer.bounds = CGRectMake(2, 2, frame.size.width - 4, frame.size.height - 4);
    _backgroundLayer.position = CGPointMake(frame.size.width/2, frame.size.height/2);
    _backgroundLayer.strokeColor = [UIColor grayColor].CGColor;
    _backgroundLayer.fillColor = [UIColor clearColor].CGColor;
    _backgroundLayer.lineCap = kCALineCapRound;
    _backgroundLayer.allowsEdgeAntialiasing = YES;
    [_backgroundLayer setLineWidth:2];
    [self.layer addSublayer:_backgroundLayer];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:_backgroundLayer.position radius:self.frame.size.width/2 - 2 startAngle:-M_PI_2 endAngle:2 * M_PI - M_PI_2 clockwise:YES];
    [_backgroundLayer setPath:path.CGPath];
    _backgroundLayer.opacity = 0;
    
    _cycleLayer = [CAShapeLayer layer];
    _cycleLayer.bounds = CGRectMake(2, 2, frame.size.width - 4, frame.size.height - 4);
    _cycleLayer.position = CGPointMake(frame.size.width/2, frame.size.height/2);
    _cycleLayer.strokeColor = [UIColor redColor].CGColor;
    _cycleLayer.fillColor = [UIColor clearColor].CGColor;
    _cycleLayer.opacity = 1;
    _cycleLayer.lineCap = kCALineCapRound;
    _cycleLayer.allowsEdgeAntialiasing = YES;
    [_cycleLayer setLineWidth:2];
    [self.layer addSublayer:_cycleLayer];
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:_backgroundLayer.position radius:self.frame.size.width/2 - 2 startAngle:-M_PI_2 endAngle:-M_PI_2 + 2 * M_PI clockwise:YES];
    _cycleLayer.strokeEnd = 0;
    [_cycleLayer setPath:path1.CGPath];
    
    //  创建 CAGradientLayer 对象
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    //  设置 gradientLayer 的 Frame
    gradientLayer1.frame = CGRectMake(0, 0, frame.size.width/2, frame.size.height);
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer1.colors = @[(id)[UIColor redColor].CGColor,
                              (id)[UIColor yellowColor].CGColor];
    //  设置两种颜色变化点，取值范围 0.0~1.0
    gradientLayer1.locations = @[@(0.5f), @(0.9f)];
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer1.startPoint = CGPointMake(0.5, 1);
    gradientLayer1.endPoint = CGPointMake(0.5, 0);
    //  添加渐变色到创建的 UIView 上去
    [gradientLayer addSublayer:gradientLayer1];
    
    CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];
    gradientLayer2.frame = CGRectMake(frame.size.width/2, 0, frame.size.width/2, frame.size.height);
    gradientLayer2.colors = @[(id)[UIColor yellowColor].CGColor,
                              (id)[UIColor blueColor].CGColor];
    gradientLayer2.locations = @[@(0.1f), @(0.5f)];
    gradientLayer2.startPoint = CGPointMake(0.5, 0);
    gradientLayer2.endPoint = CGPointMake(0.5, 1);
    [gradientLayer addSublayer:gradientLayer2];
    
    [self.layer addSublayer:gradientLayer];
    [gradientLayer setMask:_cycleLayer];
    
    _isLoading = NO;
    _autoAnimating = YES;
}

#pragma mark public methods

- (void)setProgress:(float)progress{
    if(progress < 0){
        if(_cycleLayer.strokeEnd != 0)
        _cycleLayer.strokeEnd = 0;
        _backgroundLayer.opacity = 0;
        return;
    }
    if(progress >= 1){
        progress = 1;
        if(_autoAnimating)
        [self beginAnimating];
        else{
            _cycleLayer.strokeEnd =  1;
            _backgroundLayer.opacity = 0.3;
        }
    }else{
        _cycleLayer.strokeEnd = progress;
        _backgroundLayer.opacity = 0.3 * progress;
    }
}

- (void)beginAnimating{
    _isLoading = YES;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:_backgroundLayer.position radius:self.frame.size.width/2 - 2 startAngle:-M_PI_2 endAngle:2 * M_PI - M_PI_2 clockwise:YES];
    [_backgroundLayer setPath:path.CGPath];
    _backgroundLayer.opacity = 0.3;
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:_backgroundLayer.position radius:self.frame.size.width/2 - 2 startAngle:-M_PI endAngle:-M_PI_2 clockwise:YES];
    [_cycleLayer setPath:path1.CGPath];
    _cycleLayer.strokeEnd =  1;
    
    _animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    _animation.duration = 0.66;
    _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    _animation.repeatCount = CGFLOAT_MAX;
    _animation.toValue = @(2 * M_PI);
    _animation.beginTime = CACurrentMediaTime();
    [_cycleLayer addAnimation:_animation forKey:@"rotation"];
}

- (void)stopAnimating{
    _isLoading = NO;
    [_cycleLayer removeAnimationForKey:@"rotation"];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _cycleLayer.strokeEnd = 0;
    _backgroundLayer.opacity = 0;
    [CATransaction commit];

    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:_backgroundLayer.position radius:self.frame.size.width/2 - 2 startAngle:-M_PI_2 endAngle:-M_PI_2 + 2 * M_PI clockwise:YES];
    _cycleLayer.path = path1.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 0.33;
    animation.toValue = @0;
    [self.layer addAnimation:animation forKey:@"removeSubViews"];
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation1.duration = 0.33;
    animation1.fromValue = @0.3;
    animation1.toValue = @0;
    animation1.removedOnCompletion = NO;
    [self.backgroundLayer addAnimation:animation1 forKey:@"removeSubView"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
