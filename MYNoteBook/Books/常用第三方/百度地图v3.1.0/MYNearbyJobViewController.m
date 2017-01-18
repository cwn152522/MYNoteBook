//
//  MYNearbyJobViewController.m
//  MayiW
//
//  Created by Jam on 16/7/14.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "MYNearbyJobViewController.h"
#import "UITabBarItem+Universal.h"
#import "MYBaiduMapManager.h"

#import "MYCompanyPointAnnotation.h"
#import "MYCompanyPaopaoView.h"

#import "SVProgressHUD.h"

@interface MYNearbyJobViewController ()<BMKMapViewDelegate, MYCompanyPaopaoViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *positionlabel;
@property (weak, nonatomic) IBOutlet BMKMapView *mapview;

@end

@implementation MYNearbyJobViewController

- (void)dealloc{
    DLog(@"%@页面正常注销", NSStringFromClass([self class]));
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavigationBarUI];
    [self configMapUI];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_mapview viewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_mapview viewWillDisappear];
    _mapview.delegate = nil;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark configUI

- (void)configNavigationBarUI{
    self.title = @"附近职位";
 }

- (void)configMapUI{
    //设置地图类型（普通矢量地图、卫星图和空白地图）
    _mapview.mapType = BMKMapTypeStandard;
    
    //打开实时路况图层
    [_mapview setTrafficEnabled:YES];
    
    //地图logo不可移除、不允许遮挡
    [_mapview setLogoPosition:BMKLogoPositionRightBottom];
    
    //显示比例尺
    _mapview.showMapScaleBar = YES;
    
    //设置隐藏地图标注
//    [_mapview setShowMapPoi:NO];
    
    [_mapview setZoomLevel:13];
    
    _mapview.showsUserLocation = YES;//显示定位图层
    
     [_mapview setDelegate:self];
    __weak typeof(self) selfWeak = self;
    [[MYBaiduMapManager sharedManager] setLocationFinishBlock:^(CLLocationCoordinate2D location, BMKAddressComponent* addressDetail, NSError *error){
        if(addressDetail){
            [selfWeak updateLocationSuccessedWithAddressDetail:addressDetail andLocation:location];
        }else{
            NSLog(@"dfa");
        }
    }];
        [[MYBaiduMapManager sharedManager] startUpLocationWithReverseGeo:YES];
}

#pragma mark private method

- (void)drawPointAnnotationsOnMapViewWithCurrentLocation:(CLLocationCoordinate2D)location{
    NSArray *objects = @ [
                          @{
                            @"ID": @827,
                            @"LibOrgID": @255,
                            @"OrgName": @"qy12111",
                            @"BaiduLat": @(location.latitude + arc4random()%10 * 0.005 ),
                            @"BaiduLng": @(location.longitude + arc4random()%10 * 0.005 ),
                            @"JobCount": @1
                            },
                          @{
                            @"ID": @828,
                            @"LibOrgID": @255,
                            @"OrgName": @"qy12113",
                            @"BaiduLat": @(location.latitude + arc4random()%10 * 0.005 ),
                            @"BaiduLng": @(location.longitude + arc4random()%10 * 0.005 ),
                            @"JobCount": @2
                            },
                          @{
                            @"ID": @839,
                            @"LibOrgID": @255,
                            @"OrgName": @"qy12117",
                            @"BaiduLat": @(location.latitude + arc4random()%10 * 0.005 ),
                            @"BaiduLng": @(location.longitude + arc4random()%10 * 0.005 ),
                            @"JobCount": @7
                            }];
    NSEnumerator *enumerator = [objects objectEnumerator];
    NSDictionary *obj = nil;
    while (obj = [enumerator nextObject]) {
        MYCompanyPointAnnotation *anomation = [[MYCompanyPointAnnotation alloc] init];
        CLLocationCoordinate2D coor = CLLocationCoordinate2DMake([obj[@"BaiduLat"] floatValue], [obj[@"BaiduLng"] floatValue]);
        anomation.coordinate = coor;
//        anomation.title = obj[@"OrgName"];
        anomation.orgName = obj[@"OrgName"];
        anomation.jobCount = [obj[@"JobCount"] stringValue];
        [_mapview addAnnotation:anomation];
    }
}

- (void)updateLocationSuccessedWithAddressDetail:(BMKAddressComponent *)addressDetail andLocation:(CLLocationCoordinate2D)location{
    if([[_positionlabel text] length])
        return;
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@", addressDetail.city, addressDetail.district, addressDetail.streetName, addressDetail.streetNumber];
    if([address length])
        [self.positionlabel setText:address];
    self.mapview.centerCoordinate = location;
    [self drawPointAnnotationsOnMapViewWithCurrentLocation:location];
}

//标注点视图
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    if([annotation isMemberOfClass:[MYCompanyPointAnnotation class]]){
        MYCompanyPointAnnotation *companyAnnotation  = (MYCompanyPointAnnotation *)annotation;
        
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
//        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        
        MYCompanyPaopaoView * myPaopaoView = [[MYCompanyPaopaoView alloc] initWithFrame:CGRectMake(0, 0, 100, 70) delegate:self];
        BMKActionPaopaoView *actionView = [[BMKActionPaopaoView alloc] initWithCustomView:myPaopaoView];
        [newAnnotationView setPaopaoView:actionView];
        
        [myPaopaoView loadCompanyInfoWithOrgName:companyAnnotation.orgName andJobNumber:companyAnnotation.jobCount];
        return newAnnotationView;
}
    return nil;
}

#pragma mark MYCompanyPaopaoViewDelegate

- (void)didClickView:(MYCompanyPaopaoView *)paopaoView{
    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"进入%@评价详情页", paopaoView.orgNameLabel.text] duration:1];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
