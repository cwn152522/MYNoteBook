//
//  MYRefreshFooter.m
//  MYRefresh
//
//  Created by chenweinan on 16/10/20.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "MYRefreshFooter.h"
#import "MYWaterView.h"
#import "UIView+CWNView.h"

@interface MYRefreshFooter ()

@property (strong, nonatomic) CALayer *maskLayer;//遮掩图层
@property (strong, nonatomic) MYWaterView *waterView;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation MYRefreshFooter

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare{
    [super prepare];
    
    UIImage *image = [UIImage imageNamed:@"shuaxin"];
    
    _imageView = [[UIImageView alloc] init];
    [_imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    _imageView.image = image;
    
    _waterView = [[MYWaterView alloc] init];
    [_waterView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_waterView setBackgroundColor:[UIColor clearColor]];
    
    CALayer *maskLayer = [[CALayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, 48, 30);
    maskLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"shuaxin"].CGImage);
    [_waterView.layer setMask:maskLayer];
    
    [self addSubview:_imageView];
    [self addSubview:_waterView];
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews{
    [super placeSubviews];
    [_waterView setLayoutCenterX:self];
    [_waterView setLayoutCenterY:self];
    [_waterView setLayoutWidth:48];
    [_waterView setLayoutHeight:30];
    
    [_imageView setLayoutCenterX:self];
    [_imageView setLayoutCenterY:self];
    [_imageView setLayoutWidth:48];
    [_imageView setLayoutHeight:30];
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    [super scrollViewContentOffsetDidChange:change];
    CGPoint newValue = [change[@"new"] CGPointValue];
    CGFloat newValueY = newValue.y;
    self.waterView.currentLinePointY = 460 - newValueY;
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change{
    [super scrollViewPanStateDidChange:change];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [_waterView resumeTimer];
            break;
        case MJRefreshStatePulling:
            break;
        case MJRefreshStateRefreshing:
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent{
    [super setPullingPercent:pullingPercent];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


@end
