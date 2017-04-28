//
//  MYShareTool.m
//  umengSDK_test
//
//  Created by 陈伟南 on 16/9/26.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "MYUShareManager.h"

static MYUShareManager *instance;

@implementation MYUShareManager

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (instancetype)init{
    if(self = [super init]){
        _title = @"";
        _descr = @"";
        _thumbImage = nil;
    }
    return self;
}

#pragma mark public methods

+ (id)defaultManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MYUShareManager alloc] init];
    });
    return instance;
}

- (void)shareText:(NSString *)text platformType:(UMSocialPlatformType)type currentVC:(UIViewController *)controller completion:(MYUShareCompletionBlock)completion{
    // 分享数据对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
   messageObject.text = text;
    
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:controller completion:^(id result, NSError *error) {
        if(completion){
            completion(result, error);
        }
    }];
}

- (void)shareImage:(NSString *)image platformType:(UMSocialPlatformType)type currentVC:(UIViewController *)controller completion:(MYUShareCompletionBlock)completion{
    // 分享数据对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

    UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:_title descr:_descr thumImage:_thumbImage];
    [shareObject setShareImage:image];
    messageObject.shareObject = shareObject;
    
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:controller completion:^(id result, NSError *error) {
        if(completion){
            completion(result, error);
        }
    }];
}

- (void)shareMusicUrl:(NSString *)musicUrl platformType:(UMSocialPlatformType)type currentVC:(UIViewController *)controller completion:(MYUShareCompletionBlock)completion{
    // 分享数据对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:_title descr:_descr thumImage:_thumbImage];
    [shareObject setMusicUrl:musicUrl];
    messageObject.shareObject = shareObject;
    
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:controller completion:^(id result, NSError *error) {
        if(completion){
            completion(result, error);
        }
    }];
}

- (void)shareVideoUrl:(NSString *)videoUrl platformType:(UMSocialPlatformType)type currentVC:(UIViewController *)controller completion:(MYUShareCompletionBlock)completion{
    // 分享数据对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:_title descr:_descr thumImage:_thumbImage];
    [shareObject setVideoUrl:videoUrl];
    messageObject.shareObject = shareObject;
    
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:controller completion:^(id result, NSError *error) {
        if(completion){
            completion(result, error);
        }
    }];
}

@end
