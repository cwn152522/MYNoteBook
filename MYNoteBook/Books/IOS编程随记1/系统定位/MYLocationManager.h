//
//  MYLocationManager.h
//  CLLocationDemo
//
//  Created by 陈伟南 on 16/10/9.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

//------------------------------------------------------------CLLocationManagerOptions----------------------------------------------------------------//

@interface CLLocationManagerOptions : NSObject

/**
 * 设置定位距离过滤参数 (当本次定位和上次定位之间的距离大于或等于这个值时，调用代理方法)
 */
@property(assign, nonatomic) CLLocationDistance distanceFilter;

/**
 * 设置定位精度(精度越高越耗电)
 */
@property(assign, nonatomic) CLLocationAccuracy desiredAccuracy;

@end

//-----------------------------------------------------------------MYLocationManager----------------------------------------------------------------------//

/**
 * @ note 若addressDetail＝nil即为定位回调，否者为地址反编译结果的回调
 */
typedef void(^MYLocationFinshBlock)(CLLocationCoordinate2D location, CLPlacemark *addressDetail, NSError *error);

@interface MYLocationManager : NSObject

/**
 * 定位服务管理对象
 */
@property (strong, nonatomic) CLLocationManager *locationManager;

/**
 * 定位服务配置选项
 * @ note 为nil时所有参数为默认
 */
@property (strong, nonatomic) CLLocationManagerOptions *options;

/**
 * 定位授权状态
 * @ note 状态值为kCLAuthorizationStatusDenied说明定位服务开启被用户拒绝了或者系统定位服务没开
 *     此时可以弹窗提示用户去设置中开启定位服务，最好直接跳转至设置定位服务页面，增强用户体验
 */
@property (assign, nonatomic) CLAuthorizationStatus authorizationStatus;

/**
 * 定位、反地理编码回调
 */
@property (copy, nonatomic) MYLocationFinshBlock locationFinishBlock;

/**
 * 获取定位服务管理对象实例
 *
 */
+ (instancetype)defaultManager;

/**
 * 系统是否允许定位判断
 *
 */
- (BOOL)canLocation;

/**
 * 打开设置定位服务界面
 *
 */
- (void)turnToSettingLocationServicePage;

/**
 * 开启定位
 *
 * @ param isGeo 定位结果是否需要反编译
 */
- (void)startUpdatingLocationWithReverseGeo:(BOOL)isGeo;

/**
 * 关闭定位
 *
 * @ note 不用的时候记得关闭定位
 */
- (void)stopUpdatingLocation;

/**
 * 启用后台定位
 *
 * @ note 可以在后台或者前台都能监视到用户位置的移动，即使程序没有启动
 */
- (void)startMonitoringSignificantLocationChanges:(BOOL)isGeo;

/**
 * 关闭后台定位
 *
 * @ note 可以在后台或者前台都能监视到用户位置的移动，即使程序没有启动
 */
- (void)stopMonitoringSignificantLocationChanges;

/**
 * 应用挂起时启用后台定位
 *
 */
- (void)applicationDidEnterBackground;

/**
 * 应用回到前台时禁用后台定位
 *
 */
- (void)applicationDidBecomeActive;

/**
 * 应用强退时禁用后台定位
 *
 * @ note 防止应用被kill了还进行不必要的耗电的定位操作
 */
- (void)applicationWillTerminate;

/**
 * 获取指定坐标的地址详情
 *
 * @ param location 指定经纬度坐标
 */
- (void)getAddressDetailWithLocation:(CLLocationCoordinate2D)location;

/**
 * 计算两坐标点距离
 *
 * @ param location1 指定经纬度坐标
 * @ param location2 指定经纬度坐标
 */
- (CLLocationDistance)getDistanceBetweenLocation1:(CLLocation *)location1 andLocation2:(CLLocation *)location2;

/**
 * 判断位置是否在指定区域内
 *
 */
- (BOOL)location:(CLLocation *)location isInCircleArea:(CLLocation *)center circleRadius:(CLLocationDistance)radius;

@end
