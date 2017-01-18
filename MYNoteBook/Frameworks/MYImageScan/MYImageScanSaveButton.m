//
//  MYImageScanSaveButton.m
//  图片浏览器
//
//  Created by 陈伟南 on 16/1/7.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "MYImageScanSaveButton.h"

@implementation MYImageScanSaveButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.lineColor = [UIColor blackColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

    if (self.superview == nil) {
        return;
    }
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGRect newRect = CGRectMake(2, height/4, width-4, height*0.75-2);

    UIBezierPath *path = [UIBezierPath bezierPathWithRect:newRect];
    path.lineCapStyle = kCGLineCapSquare;
    path.lineJoinStyle = kCGLineJoinBevel;
    path.lineWidth = 2.0f;
    [[UIColor clearColor] setFill];
    [self.lineColor setStroke];
    [path stroke];
    [path fillWithBlendMode:kCGBlendModeNormal alpha:1];
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(width/3, height/4)];
    [path1 addLineToPoint:CGPointMake(width/3*2, height/4)];
    path1.lineWidth = 2.0f;
    [[UIColor blackColor] setStroke];
    [path1 stroke];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(width/2, 0)];
    [path2 addLineToPoint:CGPointMake(width/2, height*0.75)];
    [self.lineColor setStroke];
    path2.lineWidth = 2.0f;
    [path2 stroke];
    
    [path2 moveToPoint:CGPointMake(width/4, height*0.75-width/4)];
    [path2 addLineToPoint:CGPointMake(width/2, height*0.75)];
    [path2 addLineToPoint:CGPointMake(width*0.75, height*0.75-width/4)];
    [path2 stroke];
    
    [super drawRect:rect];
    
}

-(void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

@end
