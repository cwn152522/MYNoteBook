//
//  MYWaterView.m
//  MYRefresh
//
//  Created by 陈伟南 on 2016/10/20.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "MYWaterView.h"

@interface MYWaterView ()

@property (strong, nonatomic) CADisplayLink *timer;//重绘计时器
@property (assign, nonatomic) CFTimeInterval startTime;//计时开始时间记录
@property (assign, nonatomic) CFTimeInterval deltaTime;//计时时间记录
@property (assign, nonatomic) CGFloat a;
@property (assign, nonatomic) CGFloat b;
@property (assign, nonatomic) BOOL jia;

@end

@implementation MYWaterView

- (void)dealloc{
     [_timer removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initData];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self initData];
    }
    return self;
}

- (void)initData{
    _fillColor = [UIColor colorWithRed:21/255.0 green:169/255.0 blue:188/255.0 alpha:1];
    _currentLinePointY = self.frame.size.height;
    
    _a = 8;
    _b = 0;
    _jia = NO;
    
    _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(waterWaving:)];
    _startTime = 0.0;
    _deltaTime = 0.0;
    [self resumeTimer];
    
    [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self updateLevel:context andRect:rect];
}

- (void)updateLevel:(CGContextRef)context andRect:(CGRect)rect{
    float y = _currentLinePointY;
    //绘图
    CGContextMoveToPoint(context, 0, y);
    for(int x =0; x <= rect.size.width; x ++){
        y = _a * sin(1.0/100*M_PI*x + 4*_b/M_PI ) + _currentLinePointY;
        CGContextAddLineToPoint(context, x, y);
    }
    
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextAddLineToPoint( context, 0, rect.size.height);
    CGContextClosePath(context);
    
    [_fillColor set];//描色+填充色
    
    CGContextDrawPath(context, kCGPathFillStroke);//描线+填充路径
}


- (void)resumeTimer{
    if(_timer.isPaused)
    [_timer setPaused:NO];
}

- (void)waterWaving:(CADisplayLink *)sender{
    if(_startTime == 0)
        _startTime = sender.timestamp;

    _deltaTime = sender.timestamp - _startTime;
    if(_deltaTime >= 0.0066){
        
        [self setNeedsDisplay];
        
        if (_jia) //曲线振幅大小变化
            _a += 0.01;
        else
            _a -= 0.01;
        
        if (_a<= 2)
            _jia = YES;
        else if (_a>= 8)
            _jia = NO;
        
        _b += 0.1;//曲线不断左移动
        
        _startTime = sender.timestamp;
    }
}

- (void)pauseTimer{
    [_timer setPaused:YES];
}

@end
