//
//  MYBaiduMapManager.m
//  MYBaiduMapDemo
//
//  Created by chenweinan on 16/7/2.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "MYBaiduMapManager.h"
#import <MapKit/MapKit.h>

static MYBaiduMapManager *sharedInstancce;

@interface  MYBaiduMapManager()<NSCopying, BMKLocationServiceDelegate,  BMKGeoCodeSearchDelegate, BMKRouteSearchDelegate, BMKRadarManagerDelegate, BMKSuggestionSearchDelegate, BMKPoiSearchDelegate, BMKShareURLSearchDelegate>

@property (strong, nonatomic) BMKLocationService *locationService;
@property (nonatomic, strong) BMKGeoCodeSearch *geoCodeSearch;
@property (strong, nonatomic) BMKRouteSearch *routeSearch;
@property (strong, nonatomic) BMKRadarManager *radarManager;
@property (strong, nonatomic) BMKFavPoiManager *favManager;
@property (strong, nonatomic) BMKSuggestionSearch *suggestionSearch;
@property (strong, nonatomic) BMKPoiSearch *poiSearch;
@property (strong, nonatomic) BMKShareURLSearch *shareUrlSearch;

@property (nonatomic, assign) BOOL isGeo;

@end

@implementation MYBaiduMapManager

#pragma mark －－－－－－－－－－－－－初始化－－－－－－－－－－－－－

- (void)dealloc{
    _locationService.delegate = nil;
    _geoCodeSearch.delegate = nil;
    _routeSearch.delegate = nil;
    [_radarManager removeRadarManagerDelegate:self];
    _suggestionSearch.delegate = nil;
    _poiSearch.delegate = nil;
    _shareUrlSearch.delegate = nil;
}

+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstancce = [[MYBaiduMapManager alloc] init];
    });
    return sharedInstancce;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstancce = [super allocWithZone:zone];
    });
    return sharedInstancce;
}

- (id)copyWithZone:(NSZone *)zone{
    return self;
}

- (instancetype)init{
    if(self = [super init]){
    
    }
    return self;
}

#pragma mark －－－－－－－－－－－－－地图功能－－－－－－－－－－－－－
#pragma mark 系统是否允许定位
- (BOOL)canLocation
{
    BOOL serviceEnable = [CLLocationManager locationServicesEnabled];
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    
    if ((authorizationStatus==kCLAuthorizationStatusAuthorizedAlways || authorizationStatus==kCLAuthorizationStatusAuthorizedWhenInUse) && serviceEnable) {
        return YES;
    } else if (authorizationStatus == kCLAuthorizationStatusNotDetermined) {
        return YES;
    }
    return NO;
}

#pragma mark 开始进行定位
- (void)startUpLocationWithReverseGeo:(BOOL)isGeo{
    NSAssert(_didGetPermission, @"MYBaiduMapManager尚未获得正确授权(didGetPermission不能为NO)");

    if(!_locationService){
        _locationService = [[BMKLocationService alloc] init];
        _locationService.distanceFilter = kCLLocationAccuracyHundredMeters;
    }
    [_locationService setDelegate:self];
    self.isGeo = isGeo;
    if([self canLocation])
    [_locationService startUserLocationService];
}

#pragma mark 获取指定位置信息的经纬度

- (BOOL)getLocationWithAddressDetail:(NSString *)addressDetail city:(NSString *)city{
     NSAssert(_didGetPermission, @"MYBaiduMapManager尚未获得正确授权(didGetPermission不能为NO)");
    
    if(!_geoCodeSearch){
        _geoCodeSearch = [[BMKGeoCodeSearch alloc] init];
    }
    [_geoCodeSearch setDelegate:self];
    BMKGeoCodeSearchOption *geoCodeOption = [[BMKGeoCodeSearchOption alloc] init];
    geoCodeOption.address = addressDetail;
    geoCodeOption.city = city;
   return [_geoCodeSearch geoCode:geoCodeOption];
}

#pragma mark 获取指定经纬度地址的信息
- (BOOL)getAddressDetailWithLocation:(CLLocationCoordinate2D)location {
   NSAssert(_didGetPermission, @"MYBaiduMapManager尚未获得正确授权(didGetPermission不能为NO)");
    
    if(!_geoCodeSearch){
        _geoCodeSearch = [[BMKGeoCodeSearch alloc] init];
    }
    [_geoCodeSearch setDelegate:self];
    BMKReverseGeoCodeOption *reverseGeoCodeOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeoCodeOption.reverseGeoPoint = location;
    return  [_geoCodeSearch reverseGeoCode:reverseGeoCodeOption];
}

#pragma mark 获取指定经纬度地址之间的路线
- (BOOL)getRoutesBetweenFromPlace:(NSString *)fromName fromLocation:(CLLocationCoordinate2D)fromLocation andToPlace:(NSString *)toName toLocation:(CLLocationCoordinate2D)toLocation withRouteSearchType:(BMKRouteSearchType)searchType{
    NSAssert(_didGetPermission, @"MYBaiduMapManager尚未获得正确授权(didGetPermission不能为NO)");
    
    if(!_routeSearch){
        _routeSearch = [[BMKRouteSearch alloc] init];
    }
    _routeSearch.delegate = self;
    
    BMKPlanNode *from = [[BMKPlanNode alloc] init];
    BMKPlanNode *to = [[BMKPlanNode alloc] init];
    from.name = fromName;
    from.pt = fromLocation;
    to.name = toName;
    to.pt = toLocation;
    
    switch (searchType) {
        case BMKRouteSearchTypeTransiting:{
            BMKMassTransitRoutePlanOption *option = [[BMKMassTransitRoutePlanOption alloc] init];
            if(_transitPolicy)
            option.incityPolicy = _transitPolicy;
            else
            option.incityPolicy =  BMK_MASS_TRANSIT_INCITY_RECOMMEND;
            option.from = from;
            option.to = to;
            return [_routeSearch massTransitSearch:option];
        }
            break;
        case BMKRouteSearchTypeDriving:{
            BMKDrivingRoutePlanOption *option = [[BMKDrivingRoutePlanOption alloc] init];
            option.from = from;
            option.to = to;
           return  [_routeSearch drivingSearch:option];
        }
            break;
        case BMKRouteSearchTypeWalking:{
            BMKWalkingRoutePlanOption *option = [[BMKWalkingRoutePlanOption alloc] init];
            option.from = from;
            option.to = to;
            return  [_routeSearch walkingSearch:option];
        }
            break;
        default:
            break;
    }
    return NO;
}

#pragma mark 打开百度地图app8.8以上进行指定经纬度地址之间的路线搜索
- (BMKOpenErrorCode)openBaiduMapAppToSearchRoutesBetweenFromPlace:(NSString *)fromName fromLocation:(CLLocationCoordinate2D) fromLocation andToPlace:(NSString *)toName toLocation:(CLLocationCoordinate2D)toLocation withRouteSearchType:(BMKRouteSearchType)searchType{
    BMKPlanNode* from= [[BMKPlanNode alloc]init];
    BMKPlanNode* to = [[BMKPlanNode alloc]init];
    from.name = fromName;
    from.pt = fromLocation;
    to.name = toName;
    to.pt = toLocation;
    
    switch (searchType) {
        case BMKRouteSearchTypeTransiting:{
            BMKOpenTransitRouteOption *option = [[BMKOpenTransitRouteOption alloc] init];
            option.appScheme = @"baidumapsdk://mapsdk.baidu.com";//用于调起成功后，返回原应用
            option.startPoint = from;
            option.endPoint = to;
            return  [BMKOpenRoute openBaiduMapTransitRoute:option];
        }
            break;
        case BMKRouteSearchTypeDriving:{
            BMKOpenDrivingRouteOption *option = [[BMKOpenDrivingRouteOption alloc] init];
            option.appScheme = @"baidumapsdk://mapsdk.baidu.com";//用于调起成功后，返回原应用
            option.startPoint = from;
            option.endPoint = to;
            return  [BMKOpenRoute openBaiduMapDrivingRoute:option];
        }
            break;
        case BMKRouteSearchTypeWalking:{
            BMKOpenWalkingRouteOption *option = [[BMKOpenWalkingRouteOption alloc] init];
            option.appScheme = @"baidumapsdk://mapsdk.baidu.com";//用于调起成功后，返回原应用
            option.startPoint = from;
            option.endPoint = to;
            return  [BMKOpenRoute openBaiduMapWalkingRoute:option];
        }
            break;
            
        default:
            break;
    }
    return 200;
}

#pragma mark 打开系统自带高德地图进行指定经纬度地址之间的路线搜索
- (BOOL)openSystemMapAppToSearchRoutesBetweenFromPlace:(NSString *)fromName fromLocation:(CLLocationCoordinate2D) fromLocation andToPlace:(NSString *)toName toLocation:(CLLocationCoordinate2D)toLocation withRouteSearchType:(BMKRouteSearchType)searchType{
    MKMapItem *from = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:fromLocation addressDictionary:nil]];
    from.name = fromName;
    MKMapItem *to = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:toLocation addressDictionary:nil]];
    to.name = toName;
    switch (searchType) {
        case BMKRouteSearchTypeTransiting:
         return  [MKMapItem openMapsWithItems:@[from, to]
                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeTransit,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
            break;
        case BMKRouteSearchTypeDriving:
           return [MKMapItem openMapsWithItems:@[from, to]
                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
            break;
        case BMKRouteSearchTypeWalking:
            return [MKMapItem openMapsWithItems:@[from, to]
                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
            break;
            
        default:
            break;
    }
    /*
     MKLaunchOptionsMapCenterKey:地图中心的坐标(NSValue)、MKLaunchOptionsMapSpanKey:地图显示的范围(NSValue)、MKLaunchOptionsShowsTrafficKey:是否显示交通信息(boolean NSNumber)、MKLaunchOptionsDirectionsModeKey: 导航类型(NSString)、MKLaunchOptionsMapTypeKey:地图类型(NSNumber)
     */
    return NO;
}

#pragma mark 上传我的位置信息到LBS（周边雷达）
- (BOOL)uploadMyLocationInfoToLBS:(CLLocationCoordinate2D)myLocation withExtInfo:(NSString *)extInfo andUserId:(NSString *)userId{
    NSAssert(_didGetPermission, @"MYBaiduMapManager尚未获得正确授权(didGetPermission不能为NO)");
    
    if(!_radarManager){
        _radarManager = [[BMKRadarManager alloc] init];
    }
    [_radarManager addRadarManagerDelegate:self];
    
     _radarManager.userId = userId;
    BMKRadarUploadInfo *myinfo = [[BMKRadarUploadInfo alloc] init];
    myinfo.extInfo = extInfo;
    myinfo.pt = myLocation;
    return [_radarManager uploadInfoRequest:myinfo];
}
#pragma mark 设置定时上传我的位置信息到LBS的时间间隔
- (void)setAutoUploadMyLocationInfoToLBSWithDuration:(NSTimeInterval)time{
    NSAssert(_didGetPermission, @"MYBaiduMapManager尚未获得正确授权(didGetPermission不能为NO)");
    
    if(!_radarManager){
        _radarManager = [[BMKRadarManager alloc] init];
    }
    [_radarManager addRadarManagerDelegate:self];
    
    [_radarManager startAutoUpload:time];
}
#pragma mark 获取我的周边用户信息
- (BOOL)getUserInfosNearByMeFromLBSWithSearchRadius:(CGFloat)radius andSearchCenterPoint:(CLLocationCoordinate2D)centerPoint andSortType:(BMKRadarSortType)sortType{
    NSAssert(_didGetPermission, @"MYBaiduMapManager尚未获得正确授权(didGetPermission不能为NO)");
    if(!_radarManager){
        _radarManager = [[BMKRadarManager alloc] init];
    }
    [_radarManager addRadarManagerDelegate:self];
    
    [_radarManager stopAutoUpload];
    BMKRadarNearbySearchOption *option = [[BMKRadarNearbySearchOption alloc] init]
    ;
    option.radius = radius;
    option.sortType = sortType;
    option.centerPt =centerPoint;
    return [_radarManager getRadarNearbySearchRequest:option];
}

#pragma mark 计算两个点的距离
- (CGFloat)getDistanceBetweenLocation1:(CLLocationCoordinate2D )coor1 andLocation2:(CLLocationCoordinate2D)coor2{
    BMKMapPoint point1 = BMKMapPointForCoordinate(coor1);
    BMKMapPoint point2 = BMKMapPointForCoordinate(coor2);
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
    return distance;
}
#pragma mark 转换其他地图坐标系坐标到百度坐标
- (CLLocationCoordinate2D)translateLocation:(BMK_COORD_TYPE)type intoBaiduLocation:(CLLocationCoordinate2D)coor{
    //转换 google地图、soso地图、aliyun地图、mapabc地图和amap地图所用坐标至百度坐标
    NSDictionary* testdic = BMKConvertBaiduCoorFrom(coor, type);
    //解密加密后的坐标字典
    CLLocationCoordinate2D baiduCoor = BMKCoorDictionaryDecode(testdic);//转换后的百度坐标
    return baiduCoor;
}
#pragma mark 判断位置是否在指定区域内
- (BOOL)location:(CLLocationCoordinate2D)location isInCircle:(CLLocationCoordinate2D)circleCenter circleRadius:(CGFloat)radius{
    BOOL ptInCircle = BMKCircleContainsCoordinate(location, circleCenter, radius);
    return ptInCircle;
}

#pragma mark 添加一个位置到收藏夹
- (NSInteger)addFavPoiIntoFavPoiStorageWithFavPoiInfo:(BMKFavPoiInfo*) favPoiInfo{
    if(!_favManager){
        _favManager = [[BMKFavPoiManager alloc] init];
    }

    __block BOOL isOld;
    [[self getFavPoiInfosFromFavPoiStorage] enumerateObjectsUsingBlock:^(BMKFavPoiInfo *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj.poiName isEqualToString:favPoiInfo.poiName]){
            isOld = YES;
            *stop = YES;
        }
    }];
    if(isOld)
        return NO;
    //添加收藏点(收藏点功后会得到favId)
    return [_favManager addFavPoi:favPoiInfo];
}
#pragma mark 从收藏夹获取一个位置信息
- (BMKFavPoiInfo *)getFavPoiInfoFromFavPoiStorage:(NSString *)favId{
    if(!_favManager){
        _favManager = [[BMKFavPoiManager alloc] init];
    }
    //获取某个收藏点(收藏点成功后会得到favId)
    BMKFavPoiInfo *favPoi = [_favManager getFavPoi:favId];
    return favPoi;
}
#pragma mark 从收藏夹获取所有位置信息
- (NSArray *)getFavPoiInfosFromFavPoiStorage{
    if(!_favManager){
        _favManager = [[BMKFavPoiManager alloc] init];
    }
    //获取所有收藏点
    NSArray *allFavPois = [_favManager getAllFavPois];
    return allFavPois;
}
#pragma mark 从收藏夹删除一个位置信息
- (BOOL)deleteFavPoiInfoFromFavPoiStorage:(NSString *)favId{
    if(!_favManager){
        _favManager = [[BMKFavPoiManager alloc] init];
    }
    BOOL rese = [_favManager deleteFavPoi:favId];
    return rese;
}
#pragma mark 从收藏夹删除所有位置信息
- (BOOL)deleteFavPoiInfosFromFavPoiStorage{
    if(!_favManager){
        _favManager = [[BMKFavPoiManager alloc] init];
    }
    BOOL rese = [_favManager clearAllFavPois];
    return rese;
}

#pragma mark 地图关键词搜索
- (BOOL)getSuggestResultWithKeyword:(NSString *)keyword{
    NSAssert(_didGetPermission, @"MYBaiduMapManager尚未获得正确授权(didGetPermission不能为NO)");
    
    if(!_suggestionSearch){
        _suggestionSearch = [[BMKSuggestionSearch alloc] init];
    }
    _suggestionSearch.delegate = self;
    BMKSuggestionSearchOption *option = [[BMKSuggestionSearchOption alloc] init];
    option.keyword = keyword;
    return [_suggestionSearch suggestionSearch:option];
}

#pragma mark 地图poi搜索
#pragma mark 周边检索
- (BOOL)getPoiSearchNearbyCityWithKeyword:(NSString *)keyword andSearchRadius:(CGFloat)radius andSearchCenterPoint:(CLLocationCoordinate2D)centerPoint andSortType:(BMKPoiSortType)sortType andPageIndex:(int)pageIndex andPageCapacity:(int)pageCapacity{
   NSAssert(_didGetPermission, @"MYBaiduMapManager尚未获得正确授权(didGetPermission不能为NO)");
    
    if(!_poiSearch){
        _poiSearch = [[BMKPoiSearch alloc] init];
    }
    _poiSearch.delegate = self;
    //发起检索
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.radius = radius;
    option.location = centerPoint;
    option.pageIndex = pageIndex;//当前分页
    option.pageCapacity = pageCapacity;
    option.keyword = keyword;
    option.sortType = sortType;
    BOOL flag = [_poiSearch poiSearchNearBy:option];
    return flag;
}
#pragma mark 城市内检索
- (BOOL)getPoiSearchInCity:(NSString *)city withKeyword:(NSString *)keyword andPageIndex:(int)pageIndex andPageCapacity:(int)pageCapacity{
    NSAssert(_didGetPermission, @"MYBaiduMapManager尚未获得正确授权(didGetPermission不能为NO)");
    
    if(!_poiSearch){
        _poiSearch = [[BMKPoiSearch alloc] init];
    }
    _poiSearch.delegate = self;
    BMKCitySearchOption *option = [[BMKCitySearchOption alloc] init];
    option.city = city;
    option.keyword = keyword;
    option.pageIndex = pageIndex;
    option.pageCapacity = pageCapacity;
    BOOL flag = [_poiSearch poiSearchInCity:option];
    return flag;
}
#pragma mark 区域内检索
- (BOOL)getPoiSearchInBound:(CLLocationCoordinate2D)leftBottom rightTop:(CLLocationCoordinate2D)rightTop withKeyword:(NSString *)keyword andPageIndex:(int)pageIndex andPageCapacity:(int)pageCapacity{
    NSAssert(_didGetPermission, @"MYBaiduMapManager尚未获得正确授权(didGetPermission不能为NO)");
    
    if(!_poiSearch){
        _poiSearch = [[BMKPoiSearch alloc] init];
    }
    _poiSearch.delegate = self;
    BMKBoundSearchOption *option = [[BMKBoundSearchOption alloc] init];
    option.leftBottom = leftBottom;
    option.rightTop = rightTop;
    option.keyword = keyword;
    option.pageIndex = pageIndex;
    option.pageCapacity = pageCapacity;
    BOOL flag = [_poiSearch poiSearchInbounds:option];
    return flag;
}
#pragma mark poi详情检索
- (BOOL)getPoiDetailWithPoiUid:(NSString *)poiUid{
    NSAssert(_didGetPermission, @"MYBaiduMapManager尚未获得正确授权(didGetPermission不能为NO)");
    
    if(!_poiSearch){
        _poiSearch = [[BMKPoiSearch alloc] init];
    }
     _poiSearch.delegate = self;
    BMKPoiDetailSearchOption* option = [[BMKPoiDetailSearchOption alloc] init];
    option.poiUid = poiUid;
    BOOL flag = [_poiSearch poiDetailSearch:option];
    return flag;
}

#pragma mark 短串分享
#pragma mark poi详情分享
- (BOOL)getPoiDetailSharedUrlWithUid:(NSString *)uid{
    NSAssert(_didGetPermission, @"MYBaiduMapManager尚未获得正确授权(didGetPermission不能为NO)");
    
    if(!_shareUrlSearch){
        _shareUrlSearch = [[BMKShareURLSearch alloc] init];
    }
     _shareUrlSearch.delegate = self;
    BMKPoiDetailShareURLOption *option = [[BMKPoiDetailShareURLOption alloc]init];
    option.uid = uid;
    BOOL flag = [_shareUrlSearch requestPoiDetailShareURL:option];
    return flag;
}
#pragma mark 路线规划分享
- (BOOL)getRoutePlanSharedUrlBetweenFromPlace:(NSString *)fromName fromLocation:(CLLocationCoordinate2D)fromLocation andToPlace:(NSString *)toName toLocation:(CLLocationCoordinate2D)toLocation withRoutePlanType:(BMKRoutePlanShareURLType)type{
    NSAssert(_didGetPermission, @"MYBaiduMapManager尚未获得正确授权(didGetPermission不能为NO)");
    
    if(!_shareUrlSearch){
        _shareUrlSearch = [[BMKShareURLSearch alloc] init];
    }
    _shareUrlSearch.delegate = self;
      BMKRoutePlanShareURLOption *option = [[BMKRoutePlanShareURLOption alloc] init];
    //起点
    BMKPlanNode *from = [[BMKPlanNode alloc] init];
    from.name = fromName;
//    from.cityID = 131;
    from.pt = fromLocation;
    option.from = from;
    //终点
    BMKPlanNode *to = [[BMKPlanNode alloc] init];
    to.name = toName;
//    to.cityID = 131;
    to.pt = toLocation;
    option.to = to;
    option.routePlanType = type;
//    option.cityID = 131;//当进行公交路线规划短串分享且起终点通过关键字指定时，必须指定
    option.routeIndex = 0;//公交路线规划短串分享时使用，分享的是第几条线路
    BOOL flag = [_shareUrlSearch requestRoutePlanShareURL:option];
    return flag;
}
#pragma mark 位置信息分享
- (BOOL)getLocationSharedUrlWithPlace:(NSString *)locationName andLocation:(CLLocationCoordinate2D)location  andSnippet:(NSString *)snippet {
    NSAssert(_didGetPermission, @"MYBaiduMapManager尚未获得正确授权(didGetPermission不能为NO)");
    
    if(!_shareUrlSearch){
        _shareUrlSearch = [[BMKShareURLSearch alloc] init];
    }
    _shareUrlSearch.delegate = self;
    //发起位置信息分享URL检索
    BMKLocationShareURLOption *option = [[BMKLocationShareURLOption alloc]init];
    option.snippet = snippet;
    option.name =locationName;
    option.location = location;
    BOOL flag = [_shareUrlSearch requestLocationShareURL:option];
    return flag;
}


#pragma mark －－－－－－－－－－－－－私有方法－－－－－－－－－－－－－
- (void)updateCurrentLocation:(BMKUserLocation *)location error:(NSError *)error
{
    if (!error) {
        _currentLocation = location;
    }
    
    [_locationService stopUserLocationService];
    
    if (self.isGeo) {
        [self getAddressDetailWithLocation:location.location.coordinate];
    } else {
        if (self.locationFinishBlock) {
            self.locationFinishBlock(location.location.coordinate, nil, error);
        }
    }
}

#pragma mark －－－－－－－－－－－－－代理方法－－－－－－－－－－－－－
#pragma mark BMKLocationServiceDelegate
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [self updateCurrentLocation:userLocation error:nil];
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    [self updateCurrentLocation:nil error:error];
}

#pragma mark BMKGeoCodeSearchDelegate
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        if (self.locationFinishBlock) {
            self.geoCodeSearchFinishBlock(result.location, result.address, nil);
        }
    } else {
        if (self.locationFinishBlock) {
            NSError *errorInfo= [NSError errorWithDomain:@"地址逆向解析失败" code:(int)error  userInfo:nil];
            self.geoCodeSearchFinishBlock(result.location, result.address, errorInfo);
        }
    }
}

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    self.isGeo = NO;
    if (error == BMK_SEARCH_NO_ERROR) {
        if (self.locationFinishBlock) {
            self.locationFinishBlock(result.location, result.addressDetail, nil);
        }
    } else {
        if (self.locationFinishBlock) {
            NSError *errorInfo= [NSError errorWithDomain:@"地址逆向解析失败" code:(int)error  userInfo:nil];
            self.locationFinishBlock(result.location, result.addressDetail, errorInfo);
        }
    }
}

#pragma BMKRouteSearchDelegate
- (void)onGetMassTransitRouteResult:(BMKRouteSearch *)searcher result:(BMKMassTransitRouteResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        if(_routeSearchFinishBlock){
            _routeSearchFinishBlock(result.routes, BMKRouteSearchTypeTransiting, nil);
        }
    } else {
        NSError *errorInfo = [NSError errorWithDomain:@"获取公交路线失败" code:(int)error userInfo:nil];
        if(_routeSearchFinishBlock){
            _routeSearchFinishBlock(nil, BMKRouteSearchTypeTransiting, errorInfo);
        }
    }
}

- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error {
    if (error == BMK_SEARCH_NO_ERROR) {
        if(_routeSearchFinishBlock){
            _routeSearchFinishBlock(result.routes, BMKRouteSearchTypeDriving, nil);
        }
    } else {
        NSError *errorInfo = [NSError errorWithDomain:@"获取驾车路线失败" code:(int)error userInfo:nil];
        if(_routeSearchFinishBlock){
            _routeSearchFinishBlock(nil, BMKRouteSearchTypeDriving, errorInfo);
        }
    }
}
- (void)onGetWalkingRouteResult:(BMKRouteSearch*)searcher result:(BMKWalkingRouteResult*)result errorCode:(BMKSearchErrorCode)error {
    if (error == BMK_SEARCH_NO_ERROR) {
        if(_routeSearchFinishBlock){
            _routeSearchFinishBlock(result.routes, BMKRouteSearchTypeWalking, nil);
        }
    } else {
        NSError *errorInfo = [NSError errorWithDomain:@"获取步行路线失败" code:(int)error userInfo:nil];
        if(_routeSearchFinishBlock){
            _routeSearchFinishBlock(nil, BMKRouteSearchTypeDriving, errorInfo);
        }
    }
}

#pragma mark BMKRadarManagerDelegate
- (BMKRadarUploadInfo *)getRadarAutoUploadInfo{
    BMKRadarUploadInfo *myinfo = [[BMKRadarUploadInfo alloc] init];
    myinfo.pt = _currentLocation.location.coordinate;
    return myinfo;
}
- (void)onGetRadarNearbySearchResult:(BMKRadarNearbyResult *)result error:(BMKRadarErrorCode)error{
    if (error == BMK_RADAR_NO_ERROR) {
        if(_nearBySearchFinishBlock){
            _nearBySearchFinishBlock(result.infoList, nil);
        }
        }else{
            NSError *errorInfo = [NSError errorWithDomain:@"获取周边用户信息失败" code:(int)error userInfo:nil];
            if(_nearBySearchFinishBlock){
                _nearBySearchFinishBlock(nil, errorInfo);
            }
    }
}

#pragma mark BMKSuggestionSearchDelegate
- (void)onGetSuggestionResult:(BMKSuggestionSearch *)searcher result:(BMKSuggestionResult *)result errorCode:(BMKSearchErrorCode)error{
    if(error == BMK_SEARCH_NO_ERROR){
        if(_suggestionSearchFinishBlock){
            _suggestionSearchFinishBlock(result, nil);
        }
    }else{
        NSError *errorInfo = [NSError errorWithDomain:@"获取建议检索结果失败" code:(int)error userInfo:nil];
        if(_suggestionSearchFinishBlock){
            _suggestionSearchFinishBlock(nil, errorInfo);
        }
    }
}

#pragma mark BMKPoiSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode{
    if(errorCode == BMK_SEARCH_NO_ERROR){
        if(_poiSearchFinishBlock){
            _poiSearchFinishBlock(poiResult, nil);
        }
    }else{
        NSError *errorInfo = [NSError errorWithDomain:@"poi检索失败" code:(int)errorCode userInfo:nil];
        if(_poiSearchFinishBlock){
            _poiSearchFinishBlock(nil, errorInfo);
        }
    }
}
- (void)onGetPoiDetailResult:(BMKPoiSearch *)searcher result:(BMKPoiDetailResult *)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode{
    if(errorCode == BMK_SEARCH_NO_ERROR){
        if(_poiDetailSearchFinishBlock){
            _poiDetailSearchFinishBlock(poiDetailResult, nil);
        }
    }else{
        NSError *errorInfo = [NSError errorWithDomain:@"poi详情检索失败" code:(int)errorCode userInfo:nil];
        if(_poiDetailSearchFinishBlock){
            _poiDetailSearchFinishBlock(nil, errorInfo);
        }
    }
}

#pragma mark BMKShareURLSearchDelegate
- (void)onGetPoiDetailShareURLResult:(BMKShareURLSearch *)searcher result:(BMKShareURLResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        if(_sharedUrlGetFinishBlock){
            _sharedUrlGetFinishBlock(result.url, nil);
        }
    }
    else {
        NSError *errorInfo = [NSError errorWithDomain:@"poi分享url获取失败" code:(int)error userInfo:nil];
        if(_sharedUrlGetFinishBlock){
            _sharedUrlGetFinishBlock(nil, errorInfo);
        }
    }
}
- (void)onGetLocationShareURLResult:(BMKShareURLSearch *)searcher result:(BMKShareURLResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        if(_sharedUrlGetFinishBlock){
            _sharedUrlGetFinishBlock(result.url, nil);
        }
    }
    else {
        NSError *errorInfo = [NSError errorWithDomain:@"位置分享url获取失败" code:(int)error userInfo:nil];
        if(_sharedUrlGetFinishBlock){
            _sharedUrlGetFinishBlock(nil, errorInfo);
        }
    }
}
- (void)onGetRoutePlanShareURLResult:(BMKShareURLSearch *)searcher result:(BMKShareURLResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        if(_sharedUrlGetFinishBlock){
            _sharedUrlGetFinishBlock(result.url, nil);
        }
    }
    else {
        NSError *errorInfo = [NSError errorWithDomain:@"路线分享url获取失败" code:(int)error userInfo:nil];
        if(_sharedUrlGetFinishBlock){
            _sharedUrlGetFinishBlock(nil, errorInfo);
        }
    }
}

@end
