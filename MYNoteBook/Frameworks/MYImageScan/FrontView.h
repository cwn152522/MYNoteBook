//
//  FrontView.h
//  图片浏览器
//
//  Created by 陈伟南 on 16/1/7.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYImageScan.h"
#import "MYImageScanSaveButton.h"

@interface FrontView : UIView

@property (nonatomic, assign) MYImageScanScrollViewStyle scrollViewStyle;
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UILabel *label;

@end
