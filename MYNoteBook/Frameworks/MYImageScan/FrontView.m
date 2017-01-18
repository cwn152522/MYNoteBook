//
//  FrontView.m
//  图片浏览器
//
//  Created by 陈伟南 on 16/1/7.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "FrontView.h"
#import "MYImageScan.h"
#import "MYImageScanScrollView.h"

@implementation FrontView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

#pragma mark - initViews

-(UIButton *)saveButton
{
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *buttonImage = [UIImage imageNamed:@"dd_ezhan_erweimgb"];
        [_saveButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        _saveButton.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
        _saveButton.center = CGPointMake(screenWidth/3, self.frame.size.height-40);
    }
    return _saveButton;
}

-(UIButton *)shareButton
{
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *buttonImage = [UIImage imageNamed:@"dd_ezhan_erweimfx"];
        [_shareButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        _shareButton.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
        _shareButton.center = CGPointMake(2*screenWidth/3, self.frame.size.height-40);
    }
    return _shareButton;
}

-(UILabel *)label
{
    if (!_label) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenWidth - 20, 68)];
        self.label.textColor = [UIColor whiteColor];
        self.label.numberOfLines = 0;
    }
    return _label;
}

-(void)setScrollViewStyle:(MYImageScanScrollViewStyle)scrollViewStyle
{
    _scrollViewStyle = scrollViewStyle;
    switch (self.scrollViewStyle) {
        case MYImageScanScrollViewDefault:
            
            break;
        case MYImageScanScrollViewTitle:
            [self addSubview:self.label];
            break;
        case MYImageScanScrollViewSave:
            [self addSubview:self.saveButton];
            break;
        case MYImageScanScrollViewTitleAndSave:
            [self addSubview:self.label];
            [self addSubview:self.saveButton];
            break;
        case MYImageScanScrollViewSaveAndShare:
            [self addSubview:self.saveButton];
            [self addSubview:self.shareButton];
            break;
        default:
            break;
    }
}

@end
