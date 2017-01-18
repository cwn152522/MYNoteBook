//
//  JCLineView.m
//  JCFindHouse
//
//  Created by Jam on 14-10-22.
//  Copyright (c) 2014年 Hannover. All rights reserved.
//

#import "JCLineView.h"

@implementation JCLineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _lineColor = GLOBAL_CELL_LINE_COLOR;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        _lineColor = GLOBAL_CELL_LINE_COLOR;
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

@end
