//
//  CWNLineView.h
//  MYCloud
//
//  Created by 陈伟南 on 16/2/18.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYUShareLineView : UIView

@property (nonatomic, strong) UIColor *lineColor;

- (void)drawLineWithColor:(UIColor *)lineColor;

@end
