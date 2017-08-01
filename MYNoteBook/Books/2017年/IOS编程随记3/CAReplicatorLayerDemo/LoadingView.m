//
//  LoadingView.m
//  CAReplicatorLayerDemo
//
//  Created by 伟南 陈 on 2017/8/1.
//  Copyright © 2017年 chenweinan. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView ()

@property (strong, nonatomic) CALayer *animationView;
@property (strong, nonatomic) CAReplicatorLayer *replicatorLayer;

@end

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
    }
    return self;
}

- (void)startAnimation{
    [self.layer setSublayers:nil];
    
    [self.layer addSublayer:self.replicatorLayer];
    self.replicatorLayer.bounds = self.layer.bounds;
    self.replicatorLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    [self.replicatorLayer addSublayer:self.animationView];
    self.animationView.bounds = CGRectMake(0, 0, self.bounds.size.width / 10, self.bounds.size.width / 10);
    self.animationView.cornerRadius = self.animationView.bounds.size.width / 2;
    self.animationView.position = CGPointMake(CGRectGetMidX(self.layer.bounds), CGRectGetMaxY(self.layer.bounds) - 10);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.8f;
    animation.fromValue = @1.1;
    animation.toValue = @0.6;
    animation.repeatCount = CGFLOAT_MAX;
    [self.animationView addAnimation:animation forKey:@"animation"];
}

#pragma mark  - 控件get方法

- (CALayer *)animationView{
    if(!_animationView){
        _animationView = [CALayer layer];
        _animationView.backgroundColor = [UIColor grayColor].CGColor;
        _animationView.masksToBounds = YES;
        _animationView.allowsEdgeAntialiasing = YES;
        _animationView.transform = CATransform3DMakeScale(0., 0., 0.);
    }
    return _animationView;
}

- (CAReplicatorLayer *)replicatorLayer{
    if(!_replicatorLayer){
        _replicatorLayer = [CAReplicatorLayer layer];
        _replicatorLayer.instanceCount = 10;
        _replicatorLayer.instanceDelay = .08f;
        _replicatorLayer.instanceAlphaOffset = -0.06f;
        _replicatorLayer.instanceTransform = CATransform3DMakeRotation((2 * M_PI / 10), 0, 0, 1);
    }
    return _replicatorLayer;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
