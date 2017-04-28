//
//  MYCornerLabel.m
//  cornerLabel
//
//  Created by 陈伟南 on 16/4/8.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "MYCornerLabel.h"

@interface MYCornerLabel()

@property (assign, nonatomic) CGFloat cornerRadius;

@property (strong, nonatomic) UIColor *fillColor;

@end

@implementation MYCornerLabel

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        self.cornerRadius = 2;
        self.fillColor = [UIColor colorWithRed:0.0 green:162.0/255.0 blue:154.0/255.0 alpha:1.0] ;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.cornerRadius = 2;
        self.fillColor = [UIColor colorWithRed:0.0 green:162.0/255.0 blue:154.0/255.0 alpha:1.0] ;
    }
    return self;
}

- (void)setFillColor:(UIColor *)fillColor andCornerRadius:(CGFloat)cornerRadius{
    self.fillColor = fillColor;
    self.cornerRadius = cornerRadius;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:_cornerRadius];
    [self.fillColor setFill];
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


@end
