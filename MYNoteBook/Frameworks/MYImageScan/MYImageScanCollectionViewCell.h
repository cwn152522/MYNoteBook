//
//  MYImageScanCollectionViewCell.h
//  图片浏览器
//
//  Created by 陈伟南 on 16/1/21.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYImageScanScrollView.h"

@interface MYImageScanCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) MYImageScanScrollView *scrollImageView;

- (void)configCellWithImagePath:(NSString *)imagePath;

@end
