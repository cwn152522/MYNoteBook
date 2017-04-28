//
//  MYULoginManager.h
//  UMengShareV6_test
//
//  Created by 陈伟南 on 16/9/28.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>

@interface MYULoginManager : NSObject

/**
 * 获取单例对象
 *
 */
+ (id)defaultManager;

/**
 * 授权状态判断
 *
 * @param platform 平台
 */
- (BOOL)isAuth:(UMSocialPlatformType)platformType;

/**
 * 授权操作
 *
 * @note 在isAuth: 返回 NO时进行
 * @param platform 平台
 * @param currentVC 授权操作所在页面，只对sms,email等平台需要传入viewcontroller的平台，其他不需要的平台可以传入nil
 * @param completion 授权结果的回调，含uid，token等信息
 */
- (void)authWithPlatform:(UMSocialPlatformType)platformType currentVC:(UIViewController *)controller completion:(void(^)(UMSocialAuthResponse *result, NSError *error))completion;

/**
 * 取消授权操作
 *
 * @note 在isAuth: 返回 YES时进行
 * @param platform 平台
 * @param completion 取消授权结果的回调
 */
- (void)cancelAuthWithPlatform:(UMSocialPlatformType)platformType completion:(UMSocialRequestCompletionHandler)completion;

/**
 * 获取用户信息
 *
 * @note 在授权后进行获取
 * @param platform 平台
 * @param currentVC 授权操作所在页面
 * @param completion 信息获取结果的回调
 */
- (void)getUserInfoWithPlatform:(UMSocialPlatformType)platformType currentVC:(UIViewController *)currentViewController completion:(void(^)(UMSocialUserInfoResponse *, NSError *error))completion;


@end
