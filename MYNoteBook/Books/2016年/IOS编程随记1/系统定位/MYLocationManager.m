//
//  MYLocationManager.m
//  CLLocationDemo
//
//  Created by 陈伟南 on 16/10/9.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "MYLocationManager.h"

//------------------------------------------------------------CLLocationManagerOptions----------------------------------------------------------------//

@implementation CLLocationManagerOptions

- (void)setDistanceFilter:(CLLocationDistance)distanceFilter{
    [MYLocationManager defaultManager].locationManager.distanceFilter = distanceFilter;
}

- (void)setDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy{
    [MYLocationManager defaultManager].locationManager.desiredAccuracy = desiredAccuracy;
}

@end

//-----------------------------------------------------------------MYLocationManager----------------------------------------------------------------------//

static MYLocationManager *instance;

@interface MYLocationManager ()<CLLocationManagerDelegate>

@property (strong, nonatomic) CLGeocoder *geoCoder;
@property (assign, nonatomic) BOOL isGeo;//是否需要逆向解析
@property (assign, nonatomic) UIBackgroundTaskIdentifier backTaskIdentifier;

@end

@implementation MYLocationManager

+ (instancetype)defaultManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MYLocationManager alloc] init];
        instance.locationManager = [[CLLocationManager alloc] init];
        if([CLLocationManager locationServicesEnabled]){
            instance.locationManager.delegate = instance; // 设置代理
            instance.locationManager.distanceFilter = 100;
            instance.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            //在ios 8.0下要求用户主动请求对程序授权, 授权状态改变就会通知代理
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
                [instance.locationManager requestAlwaysAuthorization];  //调用了这句,就会弹出允许框了.
            if([instance.locationManager respondsToSelector:@selector(allowsBackgroundLocationUpdates)])
                instance.locationManager.allowsBackgroundLocationUpdates = NO;
            instance.locationManager.pausesLocationUpdatesAutomatically = YES;//设置iOS设备是否可暂停定位来节省电池的电量
        }
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

#pragma mark Public Methods

- (BOOL)canLocation{
    BOOL serviceEnable = [CLLocationManager locationServicesEnabled];//用户是否开启了系统定位
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    _authorizationStatus = authorizationStatus;
    
    if ((authorizationStatus==kCLAuthorizationStatusAuthorized || authorizationStatus==kCLAuthorizationStatusAuthorizedWhenInUse || authorizationStatus == kCLAuthorizationStatusAuthorizedAlways) && serviceEnable) {//用户是否允许应用定位
        return YES;
    } else if (authorizationStatus == kCLAuthorizationStatusNotDetermined) {//用户还没允许定位
        return YES;
    }

    return NO;
}

- (void)turnToSettingLocationServicePage{
    NSString *openUrlStr = @"prefs:root=LOCATION_SERVICES";
    NSURL *openUrl = [NSURL URLWithString:openUrlStr];
    [[UIApplication sharedApplication] openURL:openUrl];
}

- (void)startUpdatingLocationWithReverseGeo:(BOOL)isGeo{
    _isGeo = isGeo;
    if([self canLocation])
    [_locationManager startUpdatingLocation];
}

- (void)stopUpdatingLocation{
    [_locationManager stopUpdatingLocation];
}

- (void)startMonitoringSignificantLocationChanges:(BOOL)isGeo{
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    if([_locationManager respondsToSelector:@selector(allowsBackgroundLocationUpdates)])
        _locationManager.allowsBackgroundLocationUpdates = YES;

    
    _isGeo = isGeo;
     if([self canLocation])
    [_locationManager startMonitoringSignificantLocationChanges];
}

- (void)stopMonitoringSignificantLocationChanges{
    _locationManager.pausesLocationUpdatesAutomatically = YES;
    if([_locationManager respondsToSelector:@selector(allowsBackgroundLocationUpdates)])
        _locationManager.allowsBackgroundLocationUpdates = NO;

    
    [_locationManager stopMonitoringSignificantLocationChanges];
}

- (void)applicationDidEnterBackground{
    if([self canLocation] == NO)
        return;
    
    if ([CLLocationManager significantLocationChangeMonitoringAvailable]){//表明设备能否报告基于significant location changges的更新
        [self stopUpdatingLocation];
        [self startMonitoringSignificantLocationChanges:NO];
    }
    else{
        NSLog(@"Significant location change monitoring is not available.");
    }
    
    __weak typeof(self) weakSelf = self;
    if(_backTaskIdentifier)
        [[UIApplication sharedApplication] endBackgroundTask:self.backTaskIdentifier];

    _backTaskIdentifier =  [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication] endBackgroundTask:weakSelf.backTaskIdentifier];
        weakSelf.locationManager.pausesLocationUpdatesAutomatically = YES;
        if([weakSelf.locationManager respondsToSelector:@selector(allowsBackgroundLocationUpdates)])
            weakSelf.locationManager.allowsBackgroundLocationUpdates = NO;

    }];
}

- (void)applicationDidBecomeActive{
    if([self canLocation] == NO)
        return;
    
    if(_backTaskIdentifier){
        [[UIApplication sharedApplication] endBackgroundTask:self.backTaskIdentifier];
        _backTaskIdentifier = 0;
    }
    
    if ([CLLocationManager significantLocationChangeMonitoringAvailable]){
        [self stopMonitoringSignificantLocationChanges];
        [self startUpdatingLocationWithReverseGeo:_isGeo];
    }
    else{
        NSLog(@"Significant location change monitoring is not available.");
    }
}

- (void)applicationWillTerminate{//由于程序被kill前还会调用一次applicationDidEnterBackground，导致applicationDidBecomeActive禁用的后台定位线程再次开启，所以需要在此禁止后台定位服务
    if([self canLocation] == NO)
        return;
    
    if(self.backTaskIdentifier)
        [[UIApplication sharedApplication] endBackgroundTask:self.backTaskIdentifier];
    
    if ([CLLocationManager significantLocationChangeMonitoringAvailable]){
        [self stopMonitoringSignificantLocationChanges];
        [self stopUpdatingLocation];
    }
    else{
        NSLog(@"Significant location change monitoring is not available.");
    }
}

- (void)getAddressDetailWithLocation:(CLLocationCoordinate2D)location{
    if(!_geoCoder){
    _geoCoder = [[CLGeocoder alloc] init];
    }
    [_geoCoder reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude] completionHandler:^(NSArray *array, NSError *error){
        if(error){
            if(_locationFinishBlock){
                _locationFinishBlock(location, nil, error);
            }
            return ;
        }
        
         if (array.count >0){
             CLPlacemark *placeMark = [array firstObject];
             if(_locationFinishBlock){
                 _locationFinishBlock(location, placeMark, nil);
             }
         }else{
             NSError *emptyError = [NSError errorWithDomain:@"找不到对应地址" code:-1234 userInfo:nil];
             if(_locationFinishBlock){
                 _locationFinishBlock(location, [[CLPlacemark alloc] init], emptyError);
             }
         }
     }];
}

- (CLLocationDistance)getDistanceBetweenLocation1:(CLLocation *)location1 andLocation2:(CLLocation *)location2{
    CLLocationDistance meters= [location1 distanceFromLocation:location2];
    return meters;
}

- (BOOL)location:(CLLocation *)location isInCircleArea:(CLLocation *)center circleRadius:(CLLocationDistance)radius{
    if([location distanceFromLocation:center] < radius){
        return YES;
    }else
        return NO;
}

#pragma mark CLLocationManagerDelegate

/** 获取到新的位置信息时调用*/
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations firstObject];
    if(_isGeo){
        [self getAddressDetailWithLocation:location.coordinate];
    }else{
        if(_locationFinishBlock){
            _locationFinishBlock(location.coordinate, nil, nil);
        }
    }
}

/** 不能获取位置信息时调用*/
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if(_locationFinishBlock){
        _locationFinishBlock(kCLLocationCoordinate2DInvalid, nil, error);
    }
}

/** 定位服务状态改变时调用*/
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:{
            NSLog(@"用户还未决定授权");
            break;
        }
        case kCLAuthorizationStatusRestricted:{
            NSLog(@"访问受限");
            break;
        }
        case kCLAuthorizationStatusDenied:{
            // 类方法，判断是否开启定位服务
            if ([CLLocationManager locationServicesEnabled]) {
                NSLog(@"定位服务开启，被拒绝");
            } else {
                NSLog(@"定位服务关闭，不可用");
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:{
            NSLog(@"获得前后台授权");
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:{
            NSLog(@"获得前台授权");
            break;
        }
        default:
            break;
    }
}


@end
