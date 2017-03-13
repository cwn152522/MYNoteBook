//
//  YXHNavigationBar.m
//  MYCloudHeaderDemo
//
//  Created by 陈伟南 on 16/3/10.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "MYNavigationBar.h"

@implementation MYNavigationBar

- (void)scrollViewDidScroll:(CGPoint)contentOffset{
    CGFloat delta = contentOffset.y;
    CGFloat alpha = delta / 100.0f;
    [self setMyBackgroundColorAlpha:alpha];
}

- (void)setMyBackgroundColor:(UIColor *)color {
    if (self.coverView != nil) {
        self.coverView.backgroundColor = color;
    } else {
        [self setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        [self setShadowImage:[[UIImage alloc] init]];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height + 20)];
        view.userInteractionEnabled = NO;
        [view setAutoresizingMask:UIViewAutoresizingNone];
        [self insertSubview:view atIndex:0];
        view.backgroundColor = color;
        self.coverView = view;
    }
}

- (void)setMyBackgroundColor:(UIColor *)color withScrollView:(UIScrollView *)scrollView {
    [self setMyBackgroundColor:color];
    [self scrollViewDidScroll:scrollView.contentOffset];
}

- (void)setMyBackgroundColorAlpha:(CGFloat)alpha {
    if (self.coverView == nil) {
        return;
    } else {
        self.coverView.backgroundColor = [self.coverView.backgroundColor colorWithAlphaComponent:alpha];
    }
}

@end

#pragma mark - Support

@implementation UINavigationController (YXHNavigationBar)

- (MYNavigationBar *)yxhNavigationBar {
    UINavigationBar *navBar = self.navigationBar;
    if ([navBar isKindOfClass:[MYNavigationBar class]]) {
        return (MYNavigationBar *)navBar;
    }    
    return nil;
}

- (void)pushWithBackgroundColor:(UIColor *)backgroundColor andTintColor:(UIColor *)tintColor {
    [self.yxhNavigationBar setTintColor:tintColor];
    [self.yxhNavigationBar setMyBackgroundColor:backgroundColor];
}

- (void)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(nonnull UINavigationItem *)item {
    [self.yxhNavigationBar setMyBackgroundColorAlpha:1.0f];
}

@end


