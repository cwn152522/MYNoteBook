//
//  MYBaseTipsViewController.h
//  MYCloud
//
//  Created by 陈伟南 on 16/3/17.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYBaseTipsViewController : UIViewController

/**
 *  是否需要模糊效果
 */
@property (nonatomic, assign) BOOL isBlur;

/**
 *  模糊程度
 */
@property (nonatomic, assign) CGFloat blurRadius;

/**
 *  背景色  （PS：最好带透明度）
 */
@property (nonatomic, strong) UIColor *blurColor;

/**
 *  背景是否接受点击事件
 */
- (void)setBackgroundEnable:(BOOL)enable;

/**
 *  插入到parentViewController
 *
 *  @param superViewController parentViewController
 */
- (void)insertIntoParentViewController:(UIViewController *)parentViewController;

/**
 *  移除TipsViewController，默认动画
 */
- (void)onCloseWithAnimationDuration:(CGFloat)duration;

/**
 *  替换背景点击事件移除TipsViewController，自定义动画
 */
- (void)setTarget:(id)target tapSEL:(SEL) tapAction ;

/**
 *  中间展示视图是否需要动画
 *
 *  @param animationView 中间展示视图
 */
- (void)showViewWithAnimation:(UIView *)animationView;

@end
