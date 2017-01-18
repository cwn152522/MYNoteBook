//
//  MYImageScan.h
//  图片浏览器
//
//  Created by 陈伟南 on 16/1/7.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#ifndef MYImageScan_h
#define MYImageScan_h

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

typedef NS_ENUM(NSInteger, MYImageScanScrollViewStyle) {
    MYImageScanScrollViewDefault = 0,
    MYImageScanScrollViewTitle,
    MYImageScanScrollViewSave,
    MYImageScanScrollViewTitleAndSave,
    MYImageScanScrollViewSaveAndShare
};

#endif /* MYImageScan_h */
