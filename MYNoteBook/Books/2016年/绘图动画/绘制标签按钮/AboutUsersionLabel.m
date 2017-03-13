//
//  WNDialogLabel.m
//  BezierPathLabel
//
//  Created by 陈伟南 on 15/12/19.
//  Copyright © 2015年 陈伟南. All rights reserved.
//

#import "AboutUsVersionLabel.h"

@implementation AboutUsVersionLabel

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        self.lineColor = [UIColor colorWithRed:0.0 green:162.0/255.0 blue:154.0/255.0 alpha:1.0] ;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
  
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGRect rect1 = CGRectMake(rect.origin.x+6, rect.origin.y+6, rect.size.width-12, rect.size.height-12);
    CGPoint leftButtonPoint = CGPointMake(rect1.origin.x, rect1.origin.y+rect1.size.height);
    
    CGPoint firstPoint = CGPointMake(leftButtonPoint.x-rect1.size.height/5, leftButtonPoint.y+1);
    CGPoint secondPoint = CGPointMake(leftButtonPoint.x, leftButtonPoint.y-rect1.size.height/5);
    CGPoint thirdPoint = CGPointMake(leftButtonPoint.x+rect1.size.height/5, leftButtonPoint.y);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect1 byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(rect1.size.height/5, rect1.size.height/5)];
    path.lineCapStyle = kCGLineCapSquare;
    path.lineJoinStyle = kCGLineCapRound;
    
    [path moveToPoint:firstPoint];
    [path addLineToPoint:secondPoint];
    
    [path addLineToPoint:thirdPoint];
    [path closePath];
    [self.lineColor setFill];
    [path fillWithBlendMode:kCGBlendModeNormal alpha:1];
    [super drawRect:rect];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    [self setNeedsDisplay];
}
@end
