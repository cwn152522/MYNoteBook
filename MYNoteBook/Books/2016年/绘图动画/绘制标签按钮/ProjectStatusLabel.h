//
//  ProjectStatusLabel.h
//  JCFindHouse
//
//  Created by Jam on 13-11-1.
//  Copyright (c) 2013年 jiamiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectStatusLabel : UILabel

@property (strong, nonatomic) UIColor *lineColor;
@property (assign, nonatomic) CGFloat cornerRadius;

- (instancetype)initWithLineColor:(UIColor *)lineColor cornerRadius:(CGFloat)cornerRadius;

- (void)setLineColor:(UIColor *)lineColor andCornerRadius:(CGFloat)cornerRadius;

@end
