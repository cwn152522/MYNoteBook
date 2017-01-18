//
//  MYDashLineView.m
//  MYLineView
//
//  Created by 陈伟南 on 2016/10/18.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "MYDashLineView.h"

@implementation MYDashLineView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setBackgroundColor:[UIColor clearColor]];
        _lineColor = [UIColor blackColor];
        _lineLength = 8;
        _lineSpacing = 4;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder: aDecoder]){
        [self setBackgroundColor:[UIColor clearColor]];
        _lineColor = [UIColor blackColor];
        _lineLength = 8;
        _lineSpacing = 4;
    }
    return self;
}

- (void)setLineColor:(UIColor *)lineColor{
    _lineColor  = lineColor;
    [self setNeedsDisplay];
}

- (void)setLineLength:(int)lineLength{
    _lineLength = lineLength;
    [self setNeedsDisplay];
}

- (void)setLineSpacing:(int)lineSpacing{
    _lineSpacing = lineSpacing;
    [self setNeedsDisplay];
}

- (void)drawDashLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineRect:(CGRect)lineRect{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    [shapeLayer setStrokeColor:lineColor.CGColor];
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    
    if(CGRectGetWidth(lineRect) < CGRectGetHeight(lineRect))
        [shapeLayer setLineWidth:CGRectGetWidth(lineRect)];
    else
        [shapeLayer setLineWidth:CGRectGetHeight(lineRect)];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    if(CGRectGetWidth(lineRect) < CGRectGetHeight(lineRect))
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineRect));
    else
        CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineRect), 0);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [self.layer addSublayer:shapeLayer];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self drawDashLineLength:_lineLength lineSpacing:_lineSpacing lineColor:_lineColor lineRect:rect];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
