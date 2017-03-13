//
//  UIViewController+Base.m
//  MYCloud
//
//  Created by 陈伟南 on 16/1/5.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "UIViewController+Base.h"
#import "MYIndicatorView.h"
#define MESSAGE_VIEW_TAG 10003
#define MESSAGE_PROGRESS_TITLE_TAG 10004
#define MESSAGE_INDICATORVIEW_TAG 10076

@implementation UIViewController (Base)

- (void)showProgress:(NSString *)message {
    [self.view layoutIfNeeded];
    [self showProgress];
    UIView *messageView = [self.view viewWithTag:MESSAGE_VIEW_TAG];
    [self.view bringSubviewToFront:messageView];
    
    UILabel *titleLabel = [messageView viewWithTag:MESSAGE_PROGRESS_TITLE_TAG];
    
    if (titleLabel == nil) {
        titleLabel = [[UILabel alloc] init];
        [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [messageView addSubview:titleLabel];
        [titleLabel setTag:MESSAGE_PROGRESS_TITLE_TAG];
        
        NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:messageView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:messageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-8.0f];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:15.0f];
        [messageView addConstraint:centerX];
        [messageView addConstraint:bottomConstraint];
        [messageView addConstraint:height];
    }
    [titleLabel setText:message];
}

- (void)showProgress {
    UIView *messageView = [self.view viewWithTag:MESSAGE_VIEW_TAG];
    
    if (messageView == nil) {
        UIView *messageView = [[UIView alloc] init];
        [messageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        messageView.backgroundColor = [UIColor colorWithRed:0x10/255.0 green:0x10/255.0 blue:0x10/255.0 alpha:0.6];
        messageView.layer.cornerRadius = 5.0;
        [self.view addSubview:messageView];
        [messageView setTag:MESSAGE_VIEW_TAG];
        
        UIImage *image = [UIImage imageNamed:@"shuaxin"];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((80-image.size.width)/2,(80-image.size.height)/2 ,image.size.width, image.size.height)];
        imageView.image = image;
        
        [messageView addSubview:imageView];
        MYIndicatorView *indicatorView = [[MYIndicatorView alloc] init];
        [messageView addSubview:imageView];
        [messageView addSubview:indicatorView];
        [indicatorView setTag:MESSAGE_INDICATORVIEW_TAG];
        [indicatorView startAnimating];
        NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:messageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
        NSLayoutConstraint *centerY;
//        if(iPhone4s)
//        {
//            centerY = [NSLayoutConstraint constraintWithItem:messageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
//        }
//        else{
            centerY = [NSLayoutConstraint constraintWithItem:messageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
//        }
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:messageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:80];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:messageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:80];
        
        [self.view addConstraint:centerX];
        [self.view addConstraint:centerY];
        [self.view addConstraint:width];
        [self.view addConstraint:height];
        
    }
}

- (void)hideProgress {
    UIView *messageView = [self.view viewWithTag:MESSAGE_VIEW_TAG];
    
    if (messageView) {
        [messageView removeFromSuperview];
        MYIndicatorView *indicatorView = [messageView viewWithTag:MESSAGE_INDICATORVIEW_TAG];
        [indicatorView stopAnimating];
    }
}

@end
