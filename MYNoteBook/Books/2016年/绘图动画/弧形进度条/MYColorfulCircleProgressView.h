//
//  MYColorfulCircleProgressView.h
//  MYColorsProgressView
//
//  Created by chenweinan on 16/11/1.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYColorfulCircleProgressView : UIView

/**
 * 动画状态
 */
@property (assign, nonatomic, readonly) BOOL isLoading;

/**
 * 自动刷新
 * @ note 在进度达到1时自动执行动画，默认值为YES
 */
@property (assign, nonatomic) BOOL autoAnimating;

/**
 * 设置进度
 *
 * @ param 进度条进度 范围: 0-1
 */
- (void)setProgress:(float)progress;

/**
 * 开始动画
 *
 */
- (void)beginAnimating;

/**
 * 结束动画
 *
 */
- (void)stopAnimating;

@end
