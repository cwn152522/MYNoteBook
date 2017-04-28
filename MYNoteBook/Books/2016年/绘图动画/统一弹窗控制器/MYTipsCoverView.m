//
//  MYTipsCoverView.m
//  MYCloud
//
//  Created by 陈伟南 on 16/3/17.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "MYTipsCoverView.h"
#import "UIImage+ImageEffects.h"

@interface MYTipsCoverView (){
    UIImageView *_bg;
}

@end

@implementation MYTipsCoverView

- (instancetype)init {
    if (self = [super init]) {
        self.frame = [[UIScreen mainScreen] bounds];
        _bg = [[UIImageView alloc] initWithFrame:self.frame];
        [self.layer addSublayer:_bg.layer];
    }
    return self;
}

- (id)initWithBlur:(BOOL)isBlur {
    self.isBlur = isBlur;
    self = [super init];
    if (self) {
        self.blurRadius = 6.0f;
        self.blurColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self performScreenshotAndBlur];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if (self) {
        _bg = [[UIImageView alloc] initWithFrame:self.frame];
        [self addSubview:_bg];
        self.blurRadius = 6.0f;
        self.blurColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self performScreenshotAndBlur];
    }
    
    return self;
}

- (void)performScreenshotAndBlur {
    UIImage *bgImage = [self convertViewToImage];
    if (self.isBlur) {
        bgImage = [bgImage applyBlurWithRadius:self.blurRadius tintColor:self.blurColor saturationDeltaFactor:1.0 maskImage:nil];
    } else {
        bgImage = [bgImage applyBlurWithRadius:0 tintColor:self.blurColor saturationDeltaFactor:1.0 maskImage:nil];
    }
    [_bg setImage:bgImage];
    _bg.alpha = 1.0f;
}

- (void)setIsBlur:(BOOL)isBlur {
    _isBlur = isBlur;
    [self performScreenshotAndBlur];
}

- (void)setBlurColor:(UIColor *)blurColor {
    _blurColor = blurColor;
    [self performScreenshotAndBlur];
}

- (void)setBlurRadius:(CGFloat)blurRadius {
    _blurRadius = blurRadius;
    [self performScreenshotAndBlur];
}


#pragma mark private Method

-(UIImage *)convertViewToImage {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size,YES, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *capturedScreen = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return capturedScreen;
}


@end
