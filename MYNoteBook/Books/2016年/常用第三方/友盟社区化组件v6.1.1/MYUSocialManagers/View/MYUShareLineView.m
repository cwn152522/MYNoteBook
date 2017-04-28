//
//  CWNLineView.m
//  MYCloud
//
//  Created by 陈伟南 on 16/2/18.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "MYUShareLineView.h"

@implementation MYUShareLineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _lineColor = [UIColor colorWithWhite:198.0/255.0 alpha:1.0f];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        _lineColor = [UIColor colorWithWhite:198.0/255.0 alpha:1.0f];
    }
    
    return self;
}

- (void)drawLineWithColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    
    [self setNeedsDisplay];
}

- (void)setLineColor:(UIColor *)lineColor {
    [self drawLineWithColor:lineColor];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Retain屏幕画1像素
    CGFloat bottomInset = 0.25;
    CGContextSaveGState(context);
    // draw
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);
    
    if(rect.size.width == 1) {
        CGContextMoveToPoint(context, CGRectGetWidth(rect)-bottomInset, 0.0);
        CGContextAddLineToPoint(context, CGRectGetWidth(rect)-bottomInset, CGRectGetHeight(rect));
        CGContextStrokePath(context);
        CGContextRestoreGState(context);
        return ;
    }
    
    CGContextMoveToPoint(context, 0.0f, CGRectGetHeight(rect)-bottomInset);
    CGContextAddLineToPoint(context, CGRectGetWidth(rect), CGRectGetHeight(rect)-bottomInset);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
