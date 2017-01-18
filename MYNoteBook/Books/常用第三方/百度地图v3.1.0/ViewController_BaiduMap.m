//
//  ViewController_BaiduMap.m
//  MYNoteBook
//
//  Created by chenweinan on 16/12/13.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_BaiduMap.h"
#import "MYBaiduMapManager.h"
#import "JCContext.h"

static NSString *const kTableViewCell = @"tableViewCell";

@interface ViewController_BaiduMap ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, BMKBusLineSearchDelegate>

@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) BMKBusLineSearch *busLineSearch;

@end

@implementation ViewController_BaiduMap

- (void)dealloc{
    DLog(@"%@页面正常注销", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView];
    // Do any additional setup after loading the view.
}

- (void)configTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    
    self.data = @[
                  @"定位功能、反向地理编码",
                  @"正向地理编码",
                  @"打开百度地图进行路径检索",
                  @"打开系统地图进行路径检索",
                  @"周边雷达检索",
                  @"关键词检索",
                  @"路径检索",
                  @"poi之周边检索",
                  @"公交详情信息检索",
                  @"行政区边界数据检索",
                  @"短串分享之定位地址分享",
                  @"空间计算",
                  @"坐标转换",
                  @"空间关系判断",
                  @"收藏夹功能",
                  @"地图自定义泡泡视图"
                  ];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCell];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTableViewCell];
    }
    [cell.textLabel setText:[NSString stringWithFormat:@"%ld.%@", indexPath.row + 1, [self.data objectAtIndex:indexPath.row]]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{//定位功能、反向地理编码
            [self testBMKLocationServiceAndBMKReverseGeoCoder];
        }
            break;
        case 1:{//正向地理编码
            [self testBMKGeoCoderSearch];
        }
            break;
        case 2:{//打开百度地图进行路径检索
            [self testOpenBaiduMapToSearchRoute];
        }
            break;
        case 3:{//打开系统地图进行路径检索
            [self testOpenSystemMapToSearchRoute];
        }
            break;
        case 4:{//周边雷达检索
            [self testGetNearbyUserInfosFromRadar];
        }
            break;
        case 5:{//关键词检索
            [self testBMKSuggestionSearch:@"理发"];
        }
            break;
        case 6:{//路径检索
            [self testBMKRouteSearch];
        }
            break;
        case 7:{//poi之周边检索
            [self testBMKPoiSearch];
        }
            break;
        case 8:{//公交详情信息检索
            [self testBMKBusLineSearch];
        }
            break;
        case 10:{//短串分享之定位地址分享
            [self testBMKShareURLSearch];
        }
            break;
        case 11:{//空间计算
            [self testDistancesBetweenTwoPoints];
        }
            break;
        case 12:{//坐标转换
            [self testBMKConvertBaiduCoorFromCore];
        }
            break;
        case 13:{//空间关系判断
            [self testPtInCircle];
        }
            break;
        case 15:{//地图自定义泡泡视图
            [self testCustomAnnotationView];
        }
            break;
        default:
            break;
    }
}

#pragma mark private methods

- (void)testBMKLocationServiceAndBMKReverseGeoCoder{
    [[MYBaiduMapManager sharedManager] setLocationFinishBlock:^(CLLocationCoordinate2D location, BMKAddressComponent* addressDetail, NSError *error){//addressDetail是nil时为获取当前定位地址结果，非nil时为获取指定地址详情结果]
        if(addressDetail){
            [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"定位成功，当前定位城市：%@",addressDetail.city] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }
    }];
    [[MYBaiduMapManager sharedManager] startUpLocationWithReverseGeo:YES];
}

- (void)testBMKGeoCoderSearch{
    [[MYBaiduMapManager sharedManager] setGeoCodeSearchFinishBlock:^(CLLocationCoordinate2D location, NSString *addressDetail, NSError *error){
        if(addressDetail){
            [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"正向地理编码结果:磁灶镇，经度:%.2lf 纬度:%.2lf",location.longitude,location.latitude] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }
    }];
    [[MYBaiduMapManager sharedManager] getLocationWithAddressDetail:@"磁灶镇" city:@"泉州市"];
}

- (void)testOpenBaiduMapToSearchRoute{
    [[MYBaiduMapManager sharedManager] setLocationFinishBlock:^(CLLocationCoordinate2D location, BMKAddressComponent* addressDetail, NSError *error){//addressDetail是nil时为获取当前定位地址结果，非nil时为获取指定地址详情结果]
        if(addressDetail){
            NSString *from = addressDetail.streetName;
            CLLocationCoordinate2D fromLocation = location;
            NSString *to = @"磁灶医院";
            [[MYBaiduMapManager sharedManager] setGeoCodeSearchFinishBlock:^(CLLocationCoordinate2D location, NSString *addressDetail, NSError *error){
                if(!error){
                    [[MYBaiduMapManager sharedManager] openBaiduMapAppToSearchRoutesBetweenFromPlace:from fromLocation:fromLocation andToPlace:to toLocation:location withRouteSearchType:BMKRouteSearchTypeDriving];
                }
            }];
            [[MYBaiduMapManager sharedManager] getLocationWithAddressDetail:to city:@"泉州市"];
        }
    }];
    [[MYBaiduMapManager sharedManager] startUpLocationWithReverseGeo:YES];
}

- (void)testOpenSystemMapToSearchRoute{
    [[MYBaiduMapManager sharedManager] setLocationFinishBlock:^(CLLocationCoordinate2D location, BMKAddressComponent* addressDetail, NSError *error){//addressDetail是nil时为获取当前定位地址结果，非nil时为获取指定地址详情结果]
        if(addressDetail){
            NSString *from = addressDetail.streetName;
            CLLocationCoordinate2D fromLocation = location;
            NSString *to = @"磁灶医院";
            [[MYBaiduMapManager sharedManager] setGeoCodeSearchFinishBlock:^(CLLocationCoordinate2D location, NSString *addressDetail, NSError *error){
                if(!error){
                    [[MYBaiduMapManager sharedManager] openSystemMapAppToSearchRoutesBetweenFromPlace:from fromLocation:fromLocation andToPlace:to toLocation:location withRouteSearchType:BMKRouteSearchTypeDriving];
                }
            }];
            [[MYBaiduMapManager sharedManager] getLocationWithAddressDetail:to city:@"泉州市"];
        }
    }];
    [[MYBaiduMapManager sharedManager] startUpLocationWithReverseGeo:YES];
}

- (void)testGetNearbyUserInfosFromRadar{
    [[MYBaiduMapManager sharedManager] setLocationFinishBlock:^(CLLocationCoordinate2D location, BMKAddressComponent* addressDetail, NSError *error){//addressDetail是nil时为获取当前定位地址结果，非nil时为获取指定地址详情结果]
        if(!addressDetail){
            [[MYBaiduMapManager sharedManager] setNearBySearchFinishBlock:^(NSArray* usersNearby, NSError *error ){
                NSLog(@"%@", usersNearby);
                [usersNearby enumerateObjectsUsingBlock:^(BMKRadarNearbyInfo *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"距离%ldkm，有个叫%@的用户", obj.distance/1000 , obj.extInfo] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                }];
            }];
            [[MYBaiduMapManager sharedManager] getUserInfosNearByMeFromLBSWithSearchRadius:900000 andSearchCenterPoint:location andSortType:BMK_RADAR_SORT_TYPE_DISTANCE_FROM_NEAR_TO_FAR];
        }
    }];
    [[MYBaiduMapManager sharedManager] startUpLocationWithReverseGeo:nil];
}

- (void)testBMKSuggestionSearch:(NSString *)keyword{
    [[MYBaiduMapManager sharedManager] setSuggestionSearchFinishBlock:^(BMKSuggestionResult *suggestionResult, NSError *error){
        if(!error){
            __block NSMutableString *str = [@"" mutableCopy];
            [suggestionResult.keyList enumerateObjectsUsingBlock:^(NSString  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if(idx == suggestionResult.keyList.count - 1)
                    [str appendString:obj];
                else
                    if(idx != 0)
                        [str appendFormat:@"%@,", obj];
            }];
            [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat: @"用户已输'理发'，可能搜索以下poi：%@", str] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }
    }];
    [[MYBaiduMapManager sharedManager] getSuggestResultWithKeyword:keyword];
}

- (void)testBMKRouteSearch{
    NSString *to = @"集美大学";
    [[MYBaiduMapManager sharedManager] setGeoCodeSearchFinishBlock:^(CLLocationCoordinate2D location, NSString *addressDetail, NSError *error){
        if(!error){
            if(addressDetail){
                [[JCContext shareContext] setDestinationAddress:to];
                [[JCContext shareContext] setDestinationLocation:location];
                [self performSegueWithIdentifier:@"routSearch" sender:nil];
            }
        }
    }];
    [[MYBaiduMapManager sharedManager] getLocationWithAddressDetail:to city:@"厦门市"];
}

- (void)testBMKPoiSearch{
    [[MYBaiduMapManager sharedManager] setLocationFinishBlock:^(CLLocationCoordinate2D location, BMKAddressComponent* addressDetail, NSError *error){//addressDetail是nil时为获取当前定位地址结果，非nil时为获取指定地址详情结果]
        if(addressDetail){
            [[MYBaiduMapManager sharedManager] setPoiSearchFinishBlock:^(BMKPoiResult *poiResult, NSError *error){
                if(!error){
                    NSMutableString *str = [@"" mutableCopy];
                    [poiResult.poiInfoList enumerateObjectsUsingBlock:^(BMKPoiInfo *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if(idx == [poiResult.poiInfoList count]){
                            [str appendString:obj.name];
                        }else
                            [str appendFormat:@"%@, ", obj.name];
                    }];
                    [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat: @"周边一万米内有%d个琴行，如：%@", poiResult.totalPoiNum, str] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                }
            }];
            [[MYBaiduMapManager sharedManager] getPoiSearchNearbyCityWithKeyword:@"琴行" andSearchRadius:10000 andSearchCenterPoint:location andSortType:BMK_POI_SORT_BY_DISTANCE andPageIndex:0 andPageCapacity:10];
        }
    }];
    
    [[MYBaiduMapManager sharedManager] startUpLocationWithReverseGeo:YES];
}

- (void)testBMKBusLineSearch{
    [[MYBaiduMapManager sharedManager] setPoiSearchFinishBlock:^(BMKPoiResult *poiResult, NSError *error){
        if(!error){
            BMKPoiInfo *info = [[poiResult poiInfoList] firstObject];
            if(info.epoitype == 2){
                _busLineSearch = [[BMKBusLineSearch alloc] init];
                _busLineSearch.delegate = self;
                BMKBusLineSearchOption *busLineSearchOption = [[BMKBusLineSearchOption alloc] init];
                busLineSearchOption.city = @"苏州";
                busLineSearchOption.busLineUid = info.uid;
                BOOL flag = [_busLineSearch busLineSearch:busLineSearchOption];
                if(flag){
                    NSLog(@"busline检索成功");
                }
            }
        }
    }];
    [[MYBaiduMapManager sharedManager] getPoiSearchInCity:@"苏州" withKeyword:@"56路公交" andPageIndex:0 andPageCapacity:10];
}

- (void)testBMKShareURLSearch{
    [[MYBaiduMapManager sharedManager] setLocationFinishBlock:^(CLLocationCoordinate2D location, BMKAddressComponent* addressDetail, NSError *error){//addressDetail是nil时为获取当前定位地址结果，非nil时为获取指定地址详情结果]
        if(addressDetail){
            [[MYBaiduMapManager sharedManager] setSharedUrlGetFinishBlock:^(NSString *url, NSError *error){
                if(!error){
                    [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat: @"短串之位置信息分享成功，  url: %@", url] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                }
            }];
            
            [[MYBaiduMapManager sharedManager] getLocationSharedUrlWithPlace:addressDetail.streetName andLocation:location andSnippet:@"这是我的当前位置！！！"];
        }
    }];
    
    [[MYBaiduMapManager sharedManager] startUpLocationWithReverseGeo:YES];
}

- (void)testDistancesBetweenTwoPoints{
    CLLocationDistance distance = [[MYBaiduMapManager sharedManager] getDistanceBetweenLocation1:CLLocationCoordinate2DMake(39.915, 116.4) andLocation2:CLLocationCoordinate2DMake(38.915, 115.4)];
    [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat: @"(39.915,116.4)和(38.915,115.4)之间的距离为%.2lf千米", distance/1000] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}

- (void)testBMKConvertBaiduCoorFromCore{
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(39.90868, 116.3956);
    CLLocationCoordinate2D baiduCoor = [[MYBaiduMapManager sharedManager] translateLocation:BMK_COORDTYPE_COMMON intoBaiduLocation:coor];
    [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat: @"高德地图坐标:(39.90868, 116.3956), 转换为百度坐标是:(%.4f, %.4f)", baiduCoor.latitude, baiduCoor.longitude] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}

- (void)testPtInCircle{
    BOOL ptInCircle = [[MYBaiduMapManager sharedManager] location:CLLocationCoordinate2DMake(39.918, 116.408) isInCircle:CLLocationCoordinate2DMake(39.915, 116.404) circleRadius:1000];
    if(ptInCircle){
        [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat: @"(39.918, 116.408)在(39.915, 116.404)的1000米范围内"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }
}

- (void)testCustomAnnotationView{
    [self performSegueWithIdentifier:@"customAnnotation" sender:nil];
}

#pragma mark BMKBusLineSearchDelegate

- (void)onGetBusDetailResult:(BMKBusLineSearch *)searcher result:(BMKBusLineResult *)busLineResult errorCode:(BMKSearchErrorCode)error{
    if(error == BMK_SEARCH_NO_ERROR){
        [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat: @"苏州市56路公交，线路名:%@，首班:%@，末班:%@", busLineResult.busLineName, busLineResult.startTime, busLineResult.endTime] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }else{
        NSLog(@"抱歉，未找到结果");
    }
}

@end
