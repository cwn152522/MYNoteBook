//
//  MYULoginManager.m
//  UMengShareV6_test
//
//  Created by 陈伟南 on 16/9/28.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "MYULoginManager.h"

static MYULoginManager *instance;

@implementation MYULoginManager

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

#pragma mark public methods

+ (id)defaultManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MYULoginManager alloc] init];
    });
    return instance;
}

- (BOOL)isAuth:(UMSocialPlatformType)platformType{
    return [[UMSocialDataManager defaultManager] isAuth:platformType];
}

- (void)authWithPlatform:(UMSocialPlatformType)platformType currentVC:(UIViewController *)controller completion:(void (^)(UMSocialAuthResponse *, NSError *))completion{
    [[UMSocialManager defaultManager]  authWithPlatform:platformType currentViewController:controller completion:^(id result, NSError *error) {
        UMSocialAuthResponse *authresponse = result;
        if(completion){
            completion(authresponse, error);
        }
    }];
}

- (void)cancelAuthWithPlatform:(UMSocialPlatformType)platformType completion:(UMSocialRequestCompletionHandler)completion{
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:platformType completion:^(id result, NSError *error) {
        if(completion){
            completion(result, error);
        }
    }];
}

- (void)getUserInfoWithPlatform:(UMSocialPlatformType)platformType currentVC:(UIViewController *)currentViewController completion:(void (^)(UMSocialUserInfoResponse *, NSError *))completion{
    [[UMSocialManager defaultManager]  getUserInfoWithPlatform:platformType currentViewController:currentViewController completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *userinfo =result;
        if(completion){
            completion(userinfo, error);
        }
    }];
}

@end
