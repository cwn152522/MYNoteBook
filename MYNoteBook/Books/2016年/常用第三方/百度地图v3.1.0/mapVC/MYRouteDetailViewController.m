//
//  MYRouteDetailViewController.m
//  MayiW
//
//  Created by 陈伟南 on 16/9/17.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "MYRouteDetailViewController.h"
#import "MYBaiduMapManager.h"
#import "JCContext.h"
#import "UIImage+ImageEffects.h"

@interface MYRouteDetailViewController () <UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property (nonatomic, strong) BMKPointAnnotation *currentAnnotation;

@property (nonatomic, assign) CLLocationCoordinate2D destLocation;
@property (nonatomic, strong) NSString *destAddress;
@property (nonatomic, strong) NSString *currentCity;

@property (nonatomic, assign) BOOL isToSearch;

@end

@implementation MYRouteDetailViewController

- (void)dealloc{
    DLog(@"%@页面正常注销", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(onClickBack)];
    
    // Do any additional setup after loading the view.
    self.searchBar = [[UISearchBar alloc] init];
    [self.searchBar setBackgroundImage:[UIImage imageWithColor:GLOBAL_COLOR size:CGSizeMake(WINDOW_WIDTH*0.5, 44.0f)]];
    [self.searchBar setPlaceholder:@"请输入关键词     "];
    [self.searchBar setDelegate:self];
    self.navigationItem.titleView = self.searchBar;
    
    [self.commitButton addTarget:self action:@selector(onClickCommit:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setDelegate:self];
    [self.mapView setZoomLevel:16];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if(!_isToSearch){
    if ([[JCContext shareContext] startAddress] != nil) {
        [self.mapView setCenterCoordinate:[[JCContext shareContext] startLocation]];
        [self.addressLabel setText:[[JCContext shareContext] startAddress]];
        [self.searchBar setText:[[JCContext shareContext] startAddress]];
        [self.mapView removeAnnotation:self.currentAnnotation];
        self.currentAnnotation = [[BMKPointAnnotation alloc] init];
        self.currentAnnotation.coordinate = [[JCContext shareContext] startLocation];
        self.currentAnnotation.title = @"您的位置";
        [self.mapView addAnnotation:self.currentAnnotation];
        [self setLocationBlock];
    }else{
        [[MYBaiduMapManager sharedManager] startUpLocationWithReverseGeo:NO];
        [self setLocationBlock];
      }
    }else{
        if([[[JCContext shareContext] tempAddress] length]){
        [self.mapView setCenterCoordinate:[[JCContext shareContext] tempLocation]];
        [self.addressLabel setText:[[JCContext shareContext] tempAddress]];
        [self.searchBar setText:[[JCContext shareContext] tempAddress]];
        [self.mapView removeAnnotation:self.currentAnnotation];
        self.currentAnnotation = [[BMKPointAnnotation alloc] init];
        self.currentAnnotation.coordinate = [[JCContext shareContext] tempLocation];
        self.currentAnnotation.title = @"您的位置";
        [self.mapView addAnnotation:self.currentAnnotation];
        [self setLocationBlock];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onClickBack{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    _isToSearch = YES;
//    [self performSegueWithIdentifier:@"search" sender:nil];
    return NO;
}

#pragma mark MapViewDelegate 

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {

    CLLocationCoordinate2D startpt = [self.mapView convertPoint:CGPointMake(_mapView.center.x, _mapView.center.y) toCoordinateFromView:self.mapView];
    [[MYBaiduMapManager sharedManager] getAddressDetailWithLocation:startpt];
}

#pragma mark private Method

- (void)setLocationBlock {
    __weak typeof(self) weakSelf = self;
    [[MYBaiduMapManager sharedManager] setLocationFinishBlock:^(CLLocationCoordinate2D location, BMKAddressComponent* addressDetail, NSError *error){
        
        if (addressDetail) {
            weakSelf.destLocation = location;
            NSString *addressString = @"";
            
            if ([addressDetail.province length] != 0) {
                addressString = [addressString stringByAppendingString:addressDetail.province];
            }
            if ([addressDetail.city length] != 0) {
                self.currentCity = addressDetail.city;
                addressString = [addressString stringByAppendingString:addressDetail.city];
            }
            if ([addressDetail.district length] != 0) {
                addressString = [addressString stringByAppendingString:addressDetail.district];
            }
            if ([addressDetail.streetName length] != 0) {
                addressString = [addressString stringByAppendingString:addressDetail.streetName];
            }
            if ([addressDetail.streetNumber length] != 0) {
                addressString = [addressString stringByAppendingString:addressDetail.streetNumber];
            }
            if([addressString length]){
            weakSelf.destAddress = addressString;
            [weakSelf.addressLabel setText:addressString];
            [weakSelf.searchBar setText:addressString];
                [[JCContext shareContext] setTempAddress:addressString];
                [[JCContext shareContext] setTempLocation:location];
            }
            return ;
        }
        
        [weakSelf.mapView setCenterCoordinate:location];
        [weakSelf.mapView setZoomLevel:16];
        
        if (weakSelf.currentAnnotation) {
            [weakSelf.mapView removeAnnotation:weakSelf.currentAnnotation];
        }
        
        weakSelf.currentAnnotation = [[BMKPointAnnotation alloc] init];
        weakSelf.currentAnnotation.coordinate = location;
        weakSelf.currentAnnotation.title = @"您的位置";
        [weakSelf.mapView addAnnotation:weakSelf.currentAnnotation];
        
        [[MYBaiduMapManager sharedManager] getAddressDetailWithLocation:location];
    }];
    
//    [[MYBaiduMapManager sharedManager] startUpLocationWithReverseGeo:NO];
}


#pragma mark event responed

- (IBAction)onClickCurrentLocation:(id)sender {
        [[MYBaiduMapManager sharedManager] startUpLocationWithReverseGeo:NO];
}

- (IBAction)onClickCommit:(id)sender {
    [[JCContext shareContext] setStartAddress:self.destAddress];
    [[JCContext shareContext] setStartLocation:self.destLocation];
    
    [[JCContext shareContext] setTempAddress:nil];
    [[JCContext shareContext] setTempLocation:kCLLocationCoordinate2DInvalid];
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
