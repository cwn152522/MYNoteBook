//
//  NavigationView.h
//  GuDaShi
//
//  Created by songzhaojie on 17/1/12.
//  Copyright © 2017年 songzhaojie. All rights reserved.
//
#import "MYImageButton.h"
#import <UIKit/UIKit.h>

@protocol  NavigationViewViewDlegate<NSObject>
@optional
-(void)navigationViewLeftDlegate;
-(void)navigationViewReghtDlegate;
@end

@interface NavigationView : UIView
@property(nonatomic,strong)MYImageButton *leftBtn;
@property(nonatomic,strong) UILabel *zHongJianlable;
@property(nonatomic,strong)MYImageButton* reghtBtn;

@property(nonatomic,weak)id <NavigationViewViewDlegate>  delegate;
//左边设置图片
- (void)leftBtnSheZhiImage:(NSString *)image withText:(NSString *)text  withHidden:(BOOL)hidded;//autolayout
-(void)leftBtnSheZhiImage:(NSString *)image withText:(NSString *)text withHidden:(BOOL)hidded withfloatX:(float)floatX withfloatY:(float)floatY withWidth:(float)width withHeight:(float)height;

//中间设置lable
-(void)zhongJianLableSheZhiLable:(NSString *)lable withZiShiYing:(BOOL)ZiShiYing  withFont:(float)font;//autolayout
-(void)zhongJianLableSheZhiLable:(NSString *)lable withZiShiYing:(BOOL)ZiShiYing  withFont:(float)font withfloatX:(float)floatX withfloatY:(float)floatY withWidth:(float)width withHeight:(float)height;

//右边设置图片
-(void)reghtBtnSheZhiImage:(NSString *)image withText:(NSString *)text withHidden:(BOOL)hidded;//autolayout
-(void)reghtBtnSheZhiImage:(NSString *)image withText:(NSString *)text withHidden:(BOOL)hidded withfloatX:(float)floatX withfloatY:(float)floatY withWidth:(float)width withHeight:(float)height withImageWidth:(float)imageWidth withImageHeight:(float)imageHeight;
@end
