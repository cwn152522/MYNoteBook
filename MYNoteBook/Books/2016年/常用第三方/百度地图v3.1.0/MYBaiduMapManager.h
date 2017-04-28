//
//  MYBaiduMapManager.h
//  MYBaiduMapDemo
//
//  Created by chenweinan on 16/7/2.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaiduMapHeader.h"

typedef NS_OPTIONS(NSUInteger,  BMKRouteSearchType)  {
    BMKRouteSearchTypeUnknown = 0,
    BMKRouteSearchTypeTransiting = 1 << 0,
    BMKRouteSearchTypeDriving = 1 << 1,
    BMKRouteSearchTypeWalking = 1<<2
};

typedef void (^BaiduLocationFinishBlock)(CLLocationCoordinate2D location, BMKAddressComponent* addressDetail, NSError *error);//addressDetail是nil时为获取当前定位地址结果，非nil时为获取指定地址详情结果
typedef void (^BaiduGeoCodeSearchFinishBlock)(CLLocationCoordinate2D location, NSString *addressDetail, NSError *error);//正向地理编码结果
typedef void (^BaiduRouteSearchFinishBlock)(NSArray* routes, BMKRouteSearchType searchType, NSError *error );//路线检索结果
typedef void (^BaiduRadarNearBySearchFinishBlock)(NSArray* usersNearby, NSError *error );//周边雷达检索结果
typedef void (^BaiduSuggestionSearchFinishBlock)(BMKSuggestionResult *suggestionResult, NSError *error);//建议检索结果
typedef void (^BaiduPoiSearchFinishBlock)(BMKPoiResult *poiResult, NSError *error);//兴趣点检索结果
typedef void (^BaiduPoiDetailSearchFinishBlock)(BMKPoiDetailResult *poiDetailResult, NSError *error);//兴趣点详情检索结果
typedef void (^BaiduSharedUrlGetFinishBlock)(NSString *url, NSError *error);//Url分享结果

@interface MYBaiduMapManager : NSObject

@property (nonatomic, assign) BOOL didGetPermission;//是否授权
@property (nonatomic, copy) BaiduLocationFinishBlock locationFinishBlock;
@property (nonatomic, copy) BaiduGeoCodeSearchFinishBlock geoCodeSearchFinishBlock;
@property (nonatomic, copy) BaiduRouteSearchFinishBlock routeSearchFinishBlock;
@property (nonatomic, copy) BaiduRadarNearBySearchFinishBlock nearBySearchFinishBlock;
@property (nonatomic, copy) BaiduSuggestionSearchFinishBlock suggestionSearchFinishBlock;
@property (nonatomic, copy) BaiduPoiSearchFinishBlock poiSearchFinishBlock;
@property (nonatomic, copy) BaiduPoiDetailSearchFinishBlock poiDetailSearchFinishBlock;
@property (nonatomic, copy) BaiduSharedUrlGetFinishBlock sharedUrlGetFinishBlock;

@property (assign, nonatomic) BMKMassTransitIncityPolicy transitPolicy;//城市内公交路线搜索政策
@property (readonly, nonatomic, strong) BMKUserLocation *currentLocation; //标记目前位置

+ (instancetype)sharedManager;

//系统是否允许定位
- (BOOL)canLocation;

/*开始进行定位
自iOS8起，开发者在使用百度地图定位功能之前，需要在info.plist里添加（以下二选一，两个都添加默认使用NSLocationWhenInUseUsageDescription）：NSLocationWhenInUseUsageDescription允许在前台使用时获取GPS的描述、NSLocationAlwaysUsageDescription允许永久使用GPS的描述
  */
- (void)startUpLocationWithReverseGeo:(BOOL)isGeo;

//获取指定位置信息的经纬度
- (BOOL)getLocationWithAddressDetail:(NSString *)addressDetail city:(NSString *)city;
//获取指定经纬度地址的信息
- (BOOL)getAddressDetailWithLocation:(CLLocationCoordinate2D)location;

//获取指定经纬度地址之间的路线，sdk3.1.0新增跨城市公交路线功能，内含原城市内公交路线搜索功能
- (BOOL)getRoutesBetweenFromPlace:(NSString *)fromName fromLocation:(CLLocationCoordinate2D)fromLocation andToPlace:(NSString *)toName toLocation:(CLLocationCoordinate2D)toLocation withRouteSearchType:(BMKRouteSearchType)searchType;

/*打开百度地图app8.8以上进行指定经纬度地址之间的路线搜索，若无者打开webapp
 如果在iOS9中使用了调起百度地图客户端功能，必须在"Info.plist"中进行如下配置，否则不能调起百度地图客户端。 <key>LSApplicationQueriesSchemes</key><array><string>baidumap</string></array>*/
- (BMKOpenErrorCode)openBaiduMapAppToSearchRoutesBetweenFromPlace:(NSString *)fromName fromLocation:(CLLocationCoordinate2D) fromLocation andToPlace:(NSString *)toName toLocation:(CLLocationCoordinate2D)toLocation withRouteSearchType:(BMKRouteSearchType)searchType;

//打开系统自带高德地图进行指定经纬度地址之间的路线搜索
- (BOOL)openSystemMapAppToSearchRoutesBetweenFromPlace:(NSString *)fromName fromLocation:(CLLocationCoordinate2D) fromLocation andToPlace:(NSString *)toName toLocation:(CLLocationCoordinate2D)toLocation withRouteSearchType:(BMKRouteSearchType)searchType;

//上传我的位置信息到LBS（周边雷达）
- (BOOL)uploadMyLocationInfoToLBS:(CLLocationCoordinate2D)myLocation withExtInfo:(NSString *)extInfo andUserId:(NSString *)userId;
//设置定时上传我的位置信息到LBS的时间间隔
- (void)setAutoUploadMyLocationInfoToLBSWithDuration:(NSTimeInterval)time;
//获取我的周边用户信息(米)
- (BOOL)getUserInfosNearByMeFromLBSWithSearchRadius:(CGFloat)radius andSearchCenterPoint:(CLLocationCoordinate2D)centerPoint andSortType:(BMKRadarSortType)sortType;

//计算两个点的距离
- (CGFloat)getDistanceBetweenLocation1:(CLLocationCoordinate2D )coor1 andLocation2:(CLLocationCoordinate2D)coor2;
//转换其他地图坐标系坐标到百度坐标(GPS设备采集的原始GPS坐标、google地图soso地图aliyun地图mapabc地图amap地图所用坐标)
- (CLLocationCoordinate2D)translateLocation:(BMK_COORD_TYPE)type intoBaiduLocation:(CLLocationCoordinate2D)coor;
//判断位置是否在指定区域内
- (BOOL)location:(CLLocationCoordinate2D)location isInCircle:(CLLocationCoordinate2D)circleCenter circleRadius:(CGFloat)radius;

//添加一个位置到收藏夹
- (NSInteger)addFavPoiIntoFavPoiStorageWithFavPoiInfo:(BMKFavPoiInfo*) favPoiInfo;
//从收藏夹获取一个位置信息
- (BMKFavPoiInfo *)getFavPoiInfoFromFavPoiStorage:(NSString *)favId;
//从收藏夹获取所有位置信息
- (NSArray *)getFavPoiInfosFromFavPoiStorage;
//从收藏夹删除一个位置信息
- (BOOL)deleteFavPoiInfoFromFavPoiStorage:(NSString *)favId;
//从收藏夹删除所有位置信息
- (BOOL)deleteFavPoiInfosFromFavPoiStorage;

//地图关键词搜索
- (BOOL)getSuggestResultWithKeyword:(NSString *)keyword;

//地图poi搜索（百度地图SDK提供三种类型的POI检索：周边检索、区域检索和城市内检索）
//周边检索
- (BOOL)getPoiSearchNearbyCityWithKeyword:(NSString *)keyword andSearchRadius:(CGFloat)radius andSearchCenterPoint:(CLLocationCoordinate2D)centerPoint andSortType:(BMKPoiSortType)sortType andPageIndex:(int)pageIndex andPageCapacity:(int)pageCapacity;
//城市内检索
- (BOOL)getPoiSearchInCity:(NSString *)city withKeyword:(NSString *)keyword andPageIndex:(int)pageIndex andPageCapacity:(int)pageCapacity;
//区域内检索
- (BOOL)getPoiSearchInBound:(CLLocationCoordinate2D)leftBottom rightTop:(CLLocationCoordinate2D)rightTop withKeyword:(NSString *)keyword andPageIndex:(int)pageIndex andPageCapacity:(int)pageCapacity;
//地图poi详情检索
- (BOOL)getPoiDetailWithPoiUid:(NSString *)poiUid;

//短串分享（确保先后顺序，过多分享任务必须控制好调用时间，否则可能会有部分分享任务不执行
//目前短串分享功能暂时开放了“POI详情分享”、“驾车/公交/骑行/步行路线规划分享”和“位置信息分享”）
- (BOOL)getPoiDetailSharedUrlWithUid:(NSString *)uid;
- (BOOL)getRoutePlanSharedUrlBetweenFromPlace:(NSString *)fromName fromLocation:(CLLocationCoordinate2D)fromLocation andToPlace:(NSString *)toName toLocation:(CLLocationCoordinate2D)toLocation withRoutePlanType:(BMKRoutePlanShareURLType)type;
- (BOOL)getLocationSharedUrlWithPlace:(NSString *)locationName andLocation:(CLLocationCoordinate2D)location  andSnippet:(NSString *)snippet ;//(名称、通过短URL调起客户端时作为附加信息显示在名称下面的文字)


@end
