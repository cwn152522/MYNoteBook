//
//  MYRouteViewControllerViewController.m
//  MayiW
//
//  Created by 陈伟南 on 16/9/17.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "MYRouteViewControllerViewController.h"
#import "MYBaiduMapManager.h"
#import "JCContext.h"
#import <BaiduMapAPI_Map/BMKMapView.h>

@interface MYRouteViewControllerViewController ()

@property (nonatomic, weak) UIButton *tempButton;
@property (nonatomic, weak) UIView *tempLineView;

@property (nonatomic, assign) NSInteger searchType;

@property (nonatomic, assign) BOOL isSwith;
@property (nonatomic, strong) NSArray *lines;

@property (nonatomic, assign) BOOL isToMap;

@end

@implementation MYRouteViewControllerViewController

- (void)dealloc{
    DLog(@"%@页面正常注销", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"行车路线";
    
    [self.tempButton setSelected:NO];
    [self.tempLineView setHidden:YES];
    
    [self.busButton setSelected:YES];
    [self.busLineView setHidden:NO];
    
    self.tempButton = self.busButton;
    self.tempLineView = self.busLineView;
    
    self.searchType = 0;
    self.isSwith = NO;
    self.lines = [NSArray array];
    
    id target = self.navigationController.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    self.navigationController.navigationController.interactivePopGestureRecognizer.enabled = NO;
    // Do any additional setup after loading the view.
}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)gesture{};

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
   //[self beginLoadingAnimation];
    
    if (self.isSwith) {
        [self.formButton setTitle:[[JCContext shareContext] destinationAddress] forState:UIControlStateNormal];
        [self.toButton setTitle:@"我的位置" forState:UIControlStateNormal];
    } else {
        [self.formButton setTitle:@"我的位置" forState:UIControlStateNormal];
        [self.toButton setTitle:[[JCContext shareContext] destinationAddress] forState:UIControlStateNormal];
    }
    
    [self searchRoute];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _isToMap = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if(!_isToMap){
        [[JCContext shareContext] setStartAddress:nil];
        [[JCContext shareContext] setStartLocation:kCLLocationCoordinate2DInvalid];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onClickBack{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"searchAddress"]) {
//        MYMapSearchResultTableViewController *controller = segue.destinationViewController;
//        controller.isFromRouteLine = YES;
    }
}


#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(!_isSwith){
    [[MYBaiduMapManager sharedManager] openSystemMapAppToSearchRoutesBetweenFromPlace:[[JCContext shareContext] startAddress] fromLocation:[[JCContext shareContext] startLocation] andToPlace:[[JCContext shareContext] destinationAddress] toLocation:[[JCContext shareContext] destinationLocation] withRouteSearchType:self.searchType == 0?BMKRouteSearchTypeTransiting:self.searchType == 1? BMKRouteSearchTypeDriving:BMKRouteSearchTypeWalking];
    }else{
        [[MYBaiduMapManager sharedManager] openSystemMapAppToSearchRoutesBetweenFromPlace:[[JCContext shareContext] destinationAddress] fromLocation:[[JCContext shareContext] destinationLocation] andToPlace:[[JCContext shareContext] startAddress] toLocation:[[JCContext shareContext] startLocation] withRouteSearchType:self.searchType == 0?BMKRouteSearchTypeTransiting:self.searchType == 1? BMKRouteSearchTypeDriving:BMKRouteSearchTypeWalking];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
    [footer.backgroundView setBackgroundColor:HexColor(0xe1e1e1)];
    [footer.textLabel setTextColor:HexColor(0x333333)];
    [footer.textLabel setFont:[UIFont systemFontOfSize:16.0f]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.lines count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"routeCell" forIndexPath:indexPath];
    
    BMKRouteLine *lineInfo = [self.lines objectAtIndex:indexPath.row];
    // Configure the cell...
    UILabel *lineLabel = (UILabel *)[cell viewWithTag:201];
    
    NSString *lineNumber = [NSString stringWithFormat:@"%ld", (long)(indexPath.row+1)];
    NSString *result = @"";
    NSInteger i;
    
    for (i = [lineNumber length]; i<=1; i--) {
        if (i==0) {
            break;
        }
        NSString *s = [lineNumber substringWithRange:NSMakeRange(i-1, 1)];
        result = [result stringByAppendingString:[self NumtoCN:s site:(int)i]];
    }
    
    [lineLabel setText:[NSString stringWithFormat:@"路线%@", result]];
    
    UILabel *lineDetail = (UILabel *)[cell viewWithTag:202];
    if (self.searchType == 0) {
        [lineDetail setText:lineInfo.title];
    } else {
        
        if ([lineInfo.starting.title length]!=0 && [lineInfo.terminal.title length]!=0) {
            [lineDetail setText:[NSString stringWithFormat:@"%@ - %@", lineInfo.starting.title, lineInfo.terminal.title]];
        }
    }
    
    UILabel *distanceLabel = (UILabel *)[cell viewWithTag:203];
    [distanceLabel setText:[NSString stringWithFormat:@"%.2f公里", (lineInfo.distance/1000.0f)]];
    
    UILabel *timeLabel = (UILabel *)[cell viewWithTag:204];
    BMKTime *time = lineInfo.duration;
    NSString *timeString = @"";
    if (time.dates != 0) {
        timeString = [timeString stringByAppendingString:[NSString stringWithFormat:@"%d天",time.dates]];
    }
    
    if (time.hours != 0) {
        timeString = [timeString stringByAppendingString:[NSString stringWithFormat:@"%d小时",time.hours]];
    }
    
    if (time.minutes != 0) {
        timeString = [timeString stringByAppendingString:[NSString stringWithFormat:@"%d分钟",time.minutes]];
    }
    [timeLabel setText:[NSString stringWithFormat:@"用时%@", timeString]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if ([self.lines count] == 0) {
        return @"暂时没有路线";
    }
    return @"请选择路线";
}

#pragma mark private Method

- (void)transitRoutePlanOption:(CLLocationCoordinate2D)formLocation withFormCity:(NSString *)formCityName toLcation:(CLLocationCoordinate2D)toLocation withToCity:(NSString *)toCityName {
    CLLocationCoordinate2D isFrom;
    CLLocationCoordinate2D isTo;
    NSString *isFromName;
    NSString *isToName;

    if (self.isSwith) {
        isFrom = toLocation;
        isTo = formLocation;
        isFromName = toCityName;
        isToName = formCityName;
    } else {
        isFrom = formLocation;
        isTo = toLocation;
        isFromName = formCityName;
        isToName = toCityName;
    }

    [[MYBaiduMapManager sharedManager] getRoutesBetweenFromPlace:formCityName fromLocation:isFrom andToPlace:toCityName toLocation:isTo withRouteSearchType:BMKRouteSearchTypeTransiting];
}

- (void)drivingRoutePlanOption:(CLLocationCoordinate2D)formLocation withFormCity:(NSString *)formCityName toLcation:(CLLocationCoordinate2D)toLocation withToCity:(NSString *)toCityName {
    CLLocationCoordinate2D isFrom;
    CLLocationCoordinate2D isTo;
    NSString *isFromName;
    NSString *isToName;
    
    if (self.isSwith) {
        isFrom = toLocation;
        isTo = formLocation;
        isFromName = toCityName;
        isToName = formCityName;
    } else {
        isFrom = formLocation;
        isTo = toLocation;
        isFromName = formCityName;
        isToName = toCityName;
    }
    
    [[MYBaiduMapManager sharedManager] getRoutesBetweenFromPlace:formCityName fromLocation:isFrom andToPlace:toCityName toLocation:isTo withRouteSearchType:BMKRouteSearchTypeDriving];
}

- (void)walkingRoutePlanOption:(CLLocationCoordinate2D)formLocation withFormCity:(NSString *)formCityName toLcation:(CLLocationCoordinate2D)toLocation withToCity:(NSString *)toCityName {
    CLLocationCoordinate2D isFrom;
    CLLocationCoordinate2D isTo;
    NSString *isFromName;
    NSString *isToName;
    
    if (self.isSwith) {
        isFrom = toLocation;
        isTo = formLocation;
        isFromName = toCityName;
        isToName = formCityName;
    } else {
        isFrom = formLocation;
        isTo = toLocation;
        isFromName = formCityName;
        isToName = toCityName;
    }
    
    [[MYBaiduMapManager sharedManager] getRoutesBetweenFromPlace:formCityName fromLocation:isFrom andToPlace:toCityName toLocation:isTo withRouteSearchType:BMKRouteSearchTypeWalking];
}

-(NSString*)NumtoCN:(NSString*)string site:(int)site {//阿拉伯数字转中文大写
    
    if ([string isEqualToString:@"1"]) {
        string=@"一";
    }else if ([string isEqualToString:@"2"]) {
        string=@"二";
    }else if ([string isEqualToString:@"3"]) {
        string=@"三";
    }else if ([string isEqualToString:@"4"]) {
        string=@"四";
    }else if ([string isEqualToString:@"5"]) {
        string=@"五";
    }else if ([string isEqualToString:@"6"]) {
        string=@"六";
    }else if ([string isEqualToString:@"7"]) {
        string=@"七";
    }else if ([string isEqualToString:@"8"]) {
        string=@"八";
    }else if ([string isEqualToString:@"9"]) {
        string=@"九";
    }
    
    switch (site) {
        case 1:
            return [NSString stringWithFormat:@"%@",string];
            break;
        case 2:
            if ([string isEqualToString:@"1"]) {
                return @"十";
            }
            return [NSString stringWithFormat:@"%@十",string];
            break;
        case 3:
            return [NSString stringWithFormat:@"%@百",string];
            break;
        default:
            return string;
            break;
    }
}

- (void)searchRoute {
    __weak typeof(self) weakSelf = self;
    [[MYBaiduMapManager sharedManager] setLocationFinishBlock:^(CLLocationCoordinate2D location, BMKAddressComponent* addressDetail, NSError *error){
        NSString *addressString = @"";
        if ([addressDetail.province length] != 0) {
            addressString = [addressString stringByAppendingString:addressDetail.province];
        }
        if ([addressDetail.city length] != 0) {
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
        [[JCContext shareContext] setStartLocation:location];
        [[JCContext shareContext] setStartAddress:addressString];
        }

        
        switch (weakSelf.searchType) {
            case 0:
                [weakSelf transitRoutePlanOption:location withFormCity:addressDetail.city toLcation:[[JCContext shareContext] destinationLocation] withToCity:nil];
                break;
            case 1:
                [weakSelf drivingRoutePlanOption:location withFormCity:addressDetail.city toLcation:[[JCContext shareContext] destinationLocation] withToCity:nil];
                break;
            case 2:
                [weakSelf walkingRoutePlanOption:location withFormCity:addressDetail.city toLcation:[[JCContext shareContext] destinationLocation] withToCity:nil];
                break;
            default:
                break;
        }
        [[MYBaiduMapManager sharedManager] setRouteSearchFinishBlock:^(NSArray* routes, BMKRouteSearchType searchType, NSError *error ){
            if (error == nil) {
                weakSelf.lines = routes;
            } else {
                weakSelf.lines = nil;
            }
            [weakSelf.tableView reloadData];
//            [weakSelf endLoadingAnimation:1.0f];
        }];
    }];
    if ([[JCContext shareContext] startAddress] != nil) {
        [[MYBaiduMapManager sharedManager] getAddressDetailWithLocation:[[JCContext shareContext] startLocation]];
        return ;
    }
    [[MYBaiduMapManager sharedManager] startUpLocationWithReverseGeo:YES];
}

#pragma mark Event Responed

- (IBAction)onClickTraffic:(id)sender {
    UIButton *trafficButton = (UIButton *)sender;
    
    if (self.tempButton == trafficButton) {
        return ;
    }
    
    [self.tempButton setSelected:NO];
    [self.tempLineView setHidden:YES];
    
    if (trafficButton == self.busButton) {
        self.tempLineView = self.busLineView;
        self.searchType = 0;
    } else if (trafficButton == self.taxiButton) {
        self.tempLineView = self.taxiLineView;
        self.searchType = 1;
    } else {
        self.tempLineView = self.walkLineView;
        self.searchType = 2;
    }
    
    [self searchRoute];
    
    [self.tempLineView setHidden:NO];
    [trafficButton setSelected:YES];
    self.tempButton = trafficButton;
}


- (IBAction)onClickSwitch:(id)sender {
    self.isSwith = !self.isSwith;
    
    if (self.isSwith) {
        [self.formButton setTitle:[[JCContext shareContext] destinationAddress] forState:UIControlStateNormal];
        [self.toButton setTitle:@"我的位置" forState:UIControlStateNormal];
    } else {
        [self.formButton setTitle:@"我的位置" forState:UIControlStateNormal];
        [self.toButton setTitle:[[JCContext shareContext] destinationAddress] forState:UIControlStateNormal];
    }
    
    [self searchRoute];
}

- (IBAction)onClickSearchLocation:(id)sender {
    _isToMap = YES;
    [self performSegueWithIdentifier:@"routeDetail" sender:nil];
}

- (IBAction)onClickLocation:(id)sender {
    _isToMap = YES;
    UIButton *tempButton = (UIButton *)sender;
    if (self.isSwith) {
        if(tempButton == self.toButton) {
            [self performSegueWithIdentifier:@"searchAddress" sender:nil];
        }
    } else {
        if (tempButton == self.formButton) {
            [self performSegueWithIdentifier:@"searchAddress" sender:nil];
        }
    }
}

@end
