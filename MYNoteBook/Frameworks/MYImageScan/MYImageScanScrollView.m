//
//  MYImageScanScrollView.m
//  图片浏览器
//
//  Created by 陈伟南 on 16/1/7.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "MYImageScanScrollView.h"
//#import <JCNetwork/JCNetwork.h>
#import "MYImageScanProgressView.h"
#import "MYImageScan.h"

@interface MYImageScanScrollView()

@property (nonatomic, strong)MYImageScanProgressView *progressView;

@end

@implementation MYImageScanScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentSize = [UIScreen mainScreen].bounds.size;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor blackColor];
        self.multipleTouchEnabled = YES;
        self.maximumZoomScale = 3.0f;
        self.minimumZoomScale = 1.0f;
        
        self.imageView = [[UIImageView alloc] init];
        self.imageView.center = self.center;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImage)];
        tap.numberOfTapsRequired = 2;
        self.imageView.userInteractionEnabled = YES;
        [self.imageView addGestureRecognizer:tap];
    }
    return self;
}

- (void)configImageView:(NSString *)imagePath
{
//    if ([[imagePath substringToIndex:7] isEqualToString:@"http://"]) {
//        [self loadImageFromNet:imagePath];
//    } else {
        [self loadImageFromLocal:imagePath];
//    }
}

#pragma mark - privite method

- (void)onClickImage{
    if(self.zoomScale == 3)
        [self setZoomScale:1 animated:YES];
    else
    [self setZoomScale:3 animated:YES];
}

- (void)loadImageFromNet:(NSString *)imagePath
{
//    JCRequestProxy *jcRequest = [JCRequestProxy sharedInstance];
//    NSURL *imageUrl = [NSURL URLWithString:imagePath];
//    UIImage *image = [jcRequest getImageIfExisted:imageUrl];
//    if (image != nil) {
//        self.imageView.image = image;
//        self.imageView.frame = [self resetImageViewFrame:image];
//        return;
//    }
//    
//    [self addSubview:self.progressView];
//    @WeakObj(self);
//    [jcRequest loadImageWithURL:imageUrl size:CGSizeZero completionHandler:^(UIImage *fetchImage, BOOL isCache) {
//        if (fetchImage == nil) {
//            fetchImage = [UIImage imageNamed:@"jiazaishibai.pdf"];
//            fetchImage = image;
//        }
//        selfWeak.imageView.image = fetchImage;
//        selfWeak.imageView.frame = [selfWeak resetImageViewFrame:fetchImage];
//        [selfWeak.progressView removeFromSuperview];
//    }];
}

- (void)loadImageFromLocal:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    self.imageView.image = image;
    self.imageView.frame = [self resetImageViewFrame:image];
}


- (CGRect)resetImageViewFrame:(UIImage *)image
{
    CGSize newSize;
    newSize.width = [UIScreen mainScreen].bounds.size.width;
    newSize.height = [UIScreen mainScreen].bounds.size.width/image.size.width * image.size.height;
    return CGRectMake(0, ([UIScreen mainScreen].bounds.size.height-newSize.height)/2, newSize.width, newSize.height);
}

-(MYImageScanProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[MYImageScanProgressView alloc] initWithFrame:CGRectMake(screenWidth/2-15, screenHeight/2-15, 30, 30) andLineWidth:3.0f andLineColor:[UIColor whiteColor]];
    }
    return _progressView;
}

@end
