//
//  JCContext.h
//  JC139house
//
//  Created by Jam on 13-3-20.
//  Copyright (c) 2013年 Jam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
//#import "MYGetBasicInfoResponed.h"
//#import "MYMemberInfo.h"
//#import "MYLoginResponed.h"
//#import "MYScanInfo.h"

typedef NS_ENUM(NSInteger, JCSearchLocationType) {
    CurrentLocationType,
    SearchLocationType
};

typedef NS_ENUM(NSInteger, MYAlterPassWordType) {
    AlterPasswordType,
    AlterPayType
};

typedef NS_ENUM(NSInteger, MYSearchType) {
    MYSearchTypeNormal,
    MYSearchESiteType,
    MYSearchAllType,
    MYSearchMemberEnrollType,
    MYSearchMemberTrackType,
    MYSearchMemberType,
    MYSearchPartTimeType
};


@interface JCContext : NSObject                         //保存各种请求参数

//@property (nonatomic, strong) MYMemberInfo *appMemberInfo;

@property (nonatomic, assign) BOOL isLocate;            //城市不同时，是否弹出切换弹窗
@property (nonatomic, strong) NSString *locationLat;    //定位经度
@property (nonatomic, strong) NSString *locationLng;    //定位纬度

@property (nonatomic, strong) NSString *cityName;       //城市名字
@property (nonatomic, strong) NSString *cityId;         //城市ID

@property (strong, nonatomic) NSMutableArray *stackRefreshMethod;

////记录登录信息用来进入注册页面做判断
//@property (nonatomic, strong) MYLoginResponed *logInfo;

//刷新逻辑
@property (nonatomic, assign) BOOL isRefreshFullTime;
@property (nonatomic, assign) BOOL isRefreshPartTime;
@property (nonatomic, assign) BOOL isRefreshEnroll;
@property (nonatomic, assign) BOOL isRefreshTrack;

//@property (nonatomic, strong) NSDictionary *bankAccountType;//开户类型
@property (nonatomic, strong) NSDictionary *bankType;//开户银行
//@property (nonatomic, strong) NSArray *bankAreaInfo;//开户区域信息
@property (nonatomic, assign) MYAlterPassWordType alterType;

//location
@property (nonatomic, assign) CLLocationCoordinate2D destinationLocation;
@property (nonatomic, strong) NSString *destinationAddress;

@property (nonatomic, assign) CLLocationCoordinate2D startLocation;
@property (nonatomic, strong) NSString *startAddress;

@property (nonatomic, assign) CLLocationCoordinate2D tempLocation;
@property (nonatomic, strong) NSString *tempAddress;

@property (nonatomic, strong) NSArray *forwordOrgLibs;
@property (nonatomic, strong) NSArray *tagLists;
@property (nonatomic, strong) NSDictionary *userInfo;

@property (nonatomic, assign) NSInteger regStatus;//app登录状态

//搜索类型
@property (nonatomic, assign) MYSearchType searchType;

//热门搜索词
@property (nonatomic, strong) NSArray *hotCompany;
@property (nonatomic, strong) NSArray *hotJob;

+ (id)shareContext;

@end