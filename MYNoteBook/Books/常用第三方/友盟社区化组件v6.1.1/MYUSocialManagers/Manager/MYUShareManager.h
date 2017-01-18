//
//  MYShareTool.h
//  umengSDK_test
//
//  Created by 陈伟南 on 16/9/26.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>

typedef void(^MYUShareCompletionBlock)(id result, NSError *error);

@interface MYUShareManager : NSObject

/**
 * 标题
 * @note 标题的长度依各个平台的要求而定
 */
@property (nonatomic, copy) NSString *title;

/**
 * 描述
 * @note 描述内容的长度依各个平台的要求而定
 */
@property (nonatomic, copy) NSString *descr;

/**
 * 缩略图
 * @note UIImage或者NSData类型或者NSString类型（图片url）
 */
@property (nonatomic, strong) id thumbImage;

/**
 * 获取单例对象
 *
 */
+ (id)defaultManager;

/**
 * 纯文本分享
 *
 * @param text    分享的文本内容
 * @param type   分享的平台
 * @param currentVC   分享所在controller，，只对sms,email等平台需要传入viewcontroller的平台，其他不需要的平台可以传入nil
 * @param completion   分享结果的回调
 */
- (void)shareText:(NSString *)text platformType:(UMSocialPlatformType)type currentVC:(UIViewController *)controller completion:(MYUShareCompletionBlock)completion;

/**
 * 图片或图文分享
 * @note 由于iOS系统限制(iOS9+)，非HTTPS的URL图片可能会分享失败，请使用HTTPS的 URL
 *             图片分享参数可设置URL、NSData类型
 *
 * @param image    分享的图片
 * @param type   分享的平台
 * @param currentVC   分享所在controller
 * @param completion   分享结果的回调
 */
- (void)shareImage:(NSString *)image platformType:(UMSocialPlatformType)type currentVC:(UIViewController *)controller completion:(MYUShareCompletionBlock)completion;

/**
 * 音乐分享
 *
 * @param musicUrl    分享的音乐地址
 * @param type   分享的平台
 * @param currentVC   分享所在controller
 * @param completion   分享结果的回调
 */
- (void)shareMusicUrl:(NSString *)musicUrl platformType:(UMSocialPlatformType)type currentVC:(UIViewController *)controller completion:(MYUShareCompletionBlock)completion;

/**
 * 视频分享
 *
 * @param videoUrl    分享的视频地址
 * @param type   分享的平台
 * @param currentVC   分享所在controller
 * @param completion   分享结果的回调
 */
- (void)shareVideoUrl:(NSString *)videoUrl platformType:(UMSocialPlatformType)type currentVC:(UIViewController *)controller completion:(MYUShareCompletionBlock)completion;


@end
