//
//  YXHNavigationBar.h
//  MYCloudHeaderDemo
//
//  Created by 陈伟南 on 16/3/10.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYNavigationBar : UINavigationBar

@property (nonatomic, strong) UIView *coverView;

- (void)setMyBackgroundColor:(UIColor *)color;
- (void)setMyBackgroundColor:(UIColor *)color withScrollView:(UIScrollView *)scrollView;
- (void)setMyBackgroundColorAlpha:(CGFloat)alpha;
- (void)scrollViewDidScroll:(CGPoint)contentOffset;

@end

@interface UINavigationController (YXHNavigationBar)<UINavigationBarDelegate>

@property (nonatomic, readonly) MYNavigationBar *yxhNavigationBar;

- (void)pushWithBackgroundColor:(UIColor *)backgroundColor andTintColor:(UIColor *)tintColor;

@end
