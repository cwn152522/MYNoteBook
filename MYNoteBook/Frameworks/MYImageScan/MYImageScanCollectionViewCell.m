//
//  MYImageScanCollectionViewCell.m
//  图片浏览器
//
//  Created by 陈伟南 on 16/1/21.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "MYImageScanCollectionViewCell.h"
#import "MYImageScan.h"

@interface MYImageScanCollectionViewCell ()<UIScrollViewDelegate>



@end

@implementation MYImageScanCollectionViewCell

-(instancetype)init
{
    if (self = [super init]) {

    }
    return self;
}

- (void)configCellWithImagePath:(NSString *)imagePath {
    //[self performSelector:@selector(setImageWithImagePath:) withObject:imagePath afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
    self.scrollImageView = [[MYImageScanScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.scrollImageView.delegate = self;
    [self.contentView addSubview:self.scrollImageView];
    [self.scrollImageView configImageView:imagePath];

}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.scrollImageView.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    [(MYImageScanScrollView *)scrollView imageView].center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,scrollView.contentSize.height * 0.5 + offsetY);
}


@end
