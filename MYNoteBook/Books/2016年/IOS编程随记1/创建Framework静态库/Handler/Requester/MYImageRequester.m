//
//  MYImageRequest.m
//  MYNetworkReview
//
//  Created by chenweinan on 16/11/20.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "MYImageRequester.h"

@implementation MYImageRequester

- (void)autoLoadImageWithURL:(NSURL *)url placeholderImage:(UIImage *)holdImage toImageView:(UIImageView *)imageView{
    if(!url||!imageView)
    return;
    
    [imageView sd_setImageWithURL:url placeholderImage:holdImage];
}

- (void)fetchImageWithURL:(NSURL *)url withFetchResultBlock:(MYNetworkImageFetchBlock)fetchBlock{
    if(!url)
    return;
    
    UIImage *image = [self getImageIfExisted:url];
    if(image)
    return fetchBlock([MYNetworkUtility changeImageToFitScreenScale:image], YES);
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        return fetchBlock([MYNetworkUtility changeImageToFitScreenScale:image], NO);
    }];
}

- (UIImage *)getImageIfExisted:(NSURL *)imageURL{
    if(!imageURL)
    return nil;
     
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    if([manager diskImageExistsForURL:imageURL]){
        return [[manager imageCache] imageFromDiskCacheForKey:imageURL.absoluteString];
    }
    return nil;
}

- (void)getImageCachesSizeWithResponseBlock:(MYNetworkImageCacheResponseBlock)responseBlock{
    [[SDImageCache sharedImageCache] calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
        responseBlock(totalSize);
    }];
}

- (void)clearImageCachesWithResponseBlock:(MYNetworkImageCacheResponseBlock)responseBlock{
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    [self getImageCachesSizeWithResponseBlock:^(NSUInteger cacheSize) {
        responseBlock(cacheSize);
    }];
}


@end
