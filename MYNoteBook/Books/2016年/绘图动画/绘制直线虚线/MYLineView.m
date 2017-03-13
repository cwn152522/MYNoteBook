//
//  MYLineView.m
//  MYLineView
//
//  Created by 陈伟南 on 2016/10/18.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "MYLineView.h"

@implementation MYLineView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
    _lineColor = [UIColor blackColor];
    [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        _lineColor = [UIColor blackColor];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)setLineColor:(UIColor *)lineColor{
    [self setBackgroundColor:[UIColor clearColor]];
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    [super  drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat bottomInset = 0.25;
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);
    
    if(rect.size.width == 1){
        CGContextMoveToPoint(context, CGRectGetWidth(rect) - bottomInset, 0.0);
        CGContextAddLineToPoint(context, CGRectGetWidth(rect) - bottomInset, CGRectGetHeight(rect));
        
        CGContextStrokePath(context);
        return;
    }
    
    CGContextMoveToPoint(context, 0.0f, CGRectGetHeight(rect) - bottomInset);
    CGContextAddLineToPoint(context, CGRectGetWidth(rect), CGRectGetHeight(rect) - bottomInset);
    
    CGContextStrokePath(context);
    
    return;
}

@end
