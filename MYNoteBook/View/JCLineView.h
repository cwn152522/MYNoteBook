//
//  JCLineView.h
//  JCFindHouse
//
//  Created by Jam on 14-10-22.
//  Copyright (c) 2014年 Hannover. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLineView : UIView

@property (nonatomic, strong) UIColor *lineColor;

- (void)drawLineWithColor:(UIColor *)lineColor;

@end
