//
//  MYImageScanScrollView.h
//  图片浏览器
//
//  Created by 陈伟南 on 16/1/7.
//  Copyright © 2016年 陈伟南 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYImageScanScrollView : UIScrollView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIColor *color;

- (void)configImageView:(NSString *)imagePath;

@end
