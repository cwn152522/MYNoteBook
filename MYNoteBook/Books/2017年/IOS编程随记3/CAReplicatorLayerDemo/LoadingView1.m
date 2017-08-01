//
//  LoadingView1.m
//  CAReplicatorLayerDemo
//
//  Created by 伟南 陈 on 2017/8/1.
//  Copyright © 2017年 chenweinan. All rights reserved.
//

#import "LoadingView1.h"

@interface LoadingView1 ()

@property (strong, nonatomic) CALayer *animationView;
@property (strong, nonatomic) CAReplicatorLayer *replicatorLayer;

@end

@implementation LoadingView1

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
    self.animationView.bounds = CGRectMake(0, 0, self.bounds.size.width / 6, self.bounds.size.width / 6);
    self.animationView.cornerRadius = self.animationView.bounds.size.width / 2;
    self.animationView.position = CGPointMake(CGRectGetMidX(self.bounds) - self.bounds.size.width / 4, CGRectGetMidY(self.layer.bounds));
    self.replicatorLayer.instanceTransform = CATransform3DMakeTranslation(self.bounds.size.width / 4, 0, 0);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.6f;
    animation.fromValue = @0.3;
    animation.toValue = @1.;
    animation.autoreverses = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.repeatCount = CGFLOAT_MAX;
    [self.animationView addAnimation:animation forKey:@"animation"];
}

#pragma mark  - 控件get方法

- (CALayer *)animationView{
    if(!_animationView){
        _animationView = [CALayer layer];
        _animationView.backgroundColor = [UIColor colorWithRed:201/255.0 green:8/255.0 blue:19/255.0 alpha:1].CGColor;
        _animationView.masksToBounds = YES;
        _animationView.allowsEdgeAntialiasing = YES;
        _animationView.transform = CATransform3DMakeScale(0.3, 0.3, 0.3);
    }
    return _animationView;
}

- (CAReplicatorLayer *)replicatorLayer{
    if(!_replicatorLayer){
        _replicatorLayer = [CAReplicatorLayer layer];
        _replicatorLayer.instanceCount = 3;
        _replicatorLayer.instanceDelay = .2f;
        _replicatorLayer.instanceAlphaOffset = .3f;
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
