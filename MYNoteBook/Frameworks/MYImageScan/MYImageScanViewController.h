//
//  MYImageScanViewController.h
//  图片浏览器
//
//  Created by 陈伟南 on 16/1/5.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYImageScan.h"
#import "MYImageScanScrollView.h"

@interface MYImageScanViewController : UICollectionViewController

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, assign) MYImageScanScrollViewStyle scrollViewStyle;

- (void)showImageScanVC:(UIViewController *)vc animated:(BOOL)animated;

@end
