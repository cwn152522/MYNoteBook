//
//  ProjectStatusLabel.m
//  JCFindHouse
//
//  Created by Jam on 13-11-1.
//  Copyright (c) 2013年 jiamiao. All rights reserved.
//

#import "ProjectStatusLabel.h"

@implementation ProjectStatusLabel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.lineColor = [UIColor colorWithRed:0.0 green:162.0/255.0 blue:154.0/255.0 alpha:1.0] ;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.lineColor = [UIColor colorWithRed:0.0 green:162.0/255.0 blue:154.0/255.0 alpha:1.0] ;
        self.cornerRadius = self.bounds.size.height / 2.0f;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.lineColor = [UIColor colorWithRed:0.0 green:162.0/255.0 blue:154.0/255.0 alpha:1.0] ;
        self.cornerRadius = self.bounds.size.height / 2.0f;
    }
    return self;
}

- (instancetype)initWithLineColor:(UIColor *)lineColor cornerRadius:(CGFloat)cornerRadius {
    self = [super init];
    if (self) {
        self.lineColor = lineColor;
        self.cornerRadius = cornerRadius;
    }
    return self;
}

- (void)setLineColor:(UIColor *)lineColor andCornerRadius:(CGFloat)cornerRadius{
    _lineColor = lineColor;
    _cornerRadius = cornerRadius;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    
    if (self.cornerRadius == 0) {
        self.cornerRadius = self.bounds.size.height/2.0f;
    }
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.cornerRadius];
    [[UIColor clearColor] setFill];
    [path fillWithBlendMode:kCGBlendModeNormal alpha:1]; 
    [self.lineColor setStroke];
    path.lineWidth = 1;

    [path addClip];
    [path stroke];
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    [self setNeedsDisplay];
}

@end
