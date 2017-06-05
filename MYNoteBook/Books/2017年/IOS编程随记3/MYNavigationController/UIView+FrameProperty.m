//
//  UIView+FrameProperty.m
//  GuDaShi
//
//  Created by 伟南 陈 on 2017/4/28.
//  Copyright © 2017年 songzhaojie. All rights reserved.
//

#import "UIView+FrameProperty.h"

@implementation UIView (FrameProperty)

- (CGFloat)frame_x{
    return CGRectGetMinX(self.frame);
}
- (CGFloat)frame_y{
    return CGRectGetMinY(self.frame);
}
- (CGFloat)frame_width{
    return CGRectGetWidth(self.frame);
}
- (CGFloat)frame_height{
    return CGRectGetHeight(self.frame);
}

- (void)setFrame_x:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (void)setFrame_y:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (void)setFrame_width:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)setFrame_height:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


- (void)setFrame_x:(CGFloat)frame_x withDuration:(CGFloat)duration withCompletionBlock:(void (^)())completion{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:duration animations:^{
        weakSelf.frame_x = frame_x;
    }completion:^(BOOL finished) {
        if(completion != nil)
            completion();
    }];
}

- (void)setFrame_y:(CGFloat)frame_y withDuration:(CGFloat)duration withCompletionBlock:(void (^)())completion{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:duration animations:^{
        weakSelf.frame_y = frame_y;
    }completion:^(BOOL finished) {
        if(completion != nil)
            completion();
    }];
}

- (void)setFrame_width:(CGFloat)frame_width withDuration:(CGFloat)duration withCompletionBlock:(void (^)())completion{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:duration animations:^{
        weakSelf.frame_width = frame_width;
    }completion:^(BOOL finished) {
        if(completion != nil)
            completion();
    }];
}

- (void)setFrame_height:(CGFloat)frame_height withDuration:(CGFloat)duration withCompletionBlock:(void (^)())completion{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:duration animations:^{
        weakSelf.frame_height = frame_height;
    }completion:^(BOOL finished) {
        if(completion != nil)
            completion();
    }];
}


@end
