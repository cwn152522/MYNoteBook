//
//  MYBannerScrollView.h
//  MYBannerScrollView
//
//  Created by 陈伟南 on 2016/10/21.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MYBannerScrollViewDelegate  <NSObject>

@optional
- (void)didClickScrollView:(NSInteger)pageIndex;

@end

@interface MYBannerScrollView : UIView

@property (strong, nonatomic, readonly) UIScrollView *scrollView;
@property (strong, nonatomic) UIImage *failImage;
@property (assign, nonatomic) NSTimeInterval autoDuration;
@property (assign, nonatomic) id<MYBannerScrollViewDelegate> delegate;
@property (assign, nonatomic) BOOL enableTimer;//是否开启定时轮播

//默认开启滚动视差效果和下拉放大效果
@property (assign, nonatomic) BOOL useHorizontalParallaxEffect;
@property (assign, nonatomic) BOOL useVerticalParallaxEffect;
@property (assign, nonatomic) BOOL useScaleEffect;

//未对重复调用loadImages进行具体处理，仅是return，因此暂时只能轮播一组图片
- (void)loadImages:(NSArray *)imagePaths estimateSize:(CGSize)estimateSize;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

- (void)pauseTimer;
- (void)resumeTimer;

@end
