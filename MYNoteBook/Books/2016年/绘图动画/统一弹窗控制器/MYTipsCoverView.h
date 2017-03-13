//
//  MYTipsCoverView.h
//  MYCloud
//
//  Created by 陈伟南 on 16/3/17.
//  Copyright © 2016年 Jam. All rights reserved.
//

@interface MYTipsCoverView : UIView

@property (nonatomic, assign) BOOL isBlur;
@property (nonatomic, assign) CGFloat blurRadius;
@property (nonatomic, strong) UIColor *blurColor;

- (id)initWithBlur:(BOOL)isBlur;

@end
