//
//  MYShareView.h
//  umengSDK_test
//
//  Created by 陈伟南 on 16/9/26.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ShareBtnClickdBlock)(NSInteger btnTag);

@interface MYUShareView : UIView

/**
 * 分享界面按钮点击回调
 * @note 分享按钮：btnTag = 012...[buttons count]-1
 *             取消按钮：btnTag = [buttons count]
 */
@property (copy, nonatomic) ShareBtnClickdBlock shareBtnClickdBlock;

/**
 *  配置分享界面
 *
 *  @param buttons       NSString(buttonTitle)
 *  @param images        NSString(imageName)
 *  @param lineBtnCount       设定每行显示几个分享按钮，决定按钮的宽度
 *  @param lineSpace       行间距
 *  @param edgeInset       shareView四周边距
 *  @param imageWidth         设定分享按钮图片的边长
 */
- (void)configShareViewWithButtons:(NSArray *)buttons images:(NSArray *)images lineBtnsCount:(NSInteger)lineBtnsCount lineSpace:(CGFloat)lineSpace edgeInset:(UIEdgeInsets)edgeInset imageWidth:(CGFloat)imageWidth;

/**
 *  弹出分享视图
 *
 */
- (void)show;

/**
 *  关闭分享视图
 *
 */
- (void)hide;

/**
 *  关闭分享视图(带回调)
 *
 */
- (void)hideWithHiddenBlock:(void(^)(BOOL hasHidden))block;

@end
