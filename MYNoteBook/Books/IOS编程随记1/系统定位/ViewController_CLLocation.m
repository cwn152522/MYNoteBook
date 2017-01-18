//
//  ViewController_CLLocation.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/25.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_CLLocation.h"
#import "MYLocationManager.h"

@interface ViewController_CLLocation ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *logLabel;

@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) CFAbsoluteTime originalTime;

@end

@implementation ViewController_CLLocation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统定位";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate) name:UIApplicationWillTerminateNotification object:nil];
    
    _timer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:10] interval:10 target:self selector:@selector(onTimeFired) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [_timer setFireDate:[NSDate distantFuture]];
    [[MYLocationManager defaultManager] startUpdatingLocationWithReverseGeo:YES];
    [[MYLocationManager defaultManager] setLocationFinishBlock:^(CLLocationCoordinate2D location, CLPlacemark *addressDetail, NSError *error){
        [[MYLocationManager defaultManager] stopUpdatingLocation];
        if(!addressDetail){//仅定位
        }else{//获取了地址详情
            if(!error){
                [self.logLabel setAlpha:0];
                [_logLabel setText:[NSString stringWithFormat:@"当前定位城市:%@", addressDetail.locality]];
                [UIView animateWithDuration:0.33 animations:^{
                    [self.logLabel setAlpha:1];
                }];
            }
        }
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark private methods

- (void)onTimeFired{
    if(_originalTime != 0){
         [_logLabel setText:[NSString stringWithFormat:@"已经后台运行了%.1lf分钟", (CFAbsoluteTimeGetCurrent() - _originalTime)/60]];
    }
    [[MYLocationManager defaultManager] startUpdatingLocationWithReverseGeo:YES];
}

- (IBAction)startUpadatingLocation:(UIButton *)sender {
    [[MYLocationManager defaultManager] startUpdatingLocationWithReverseGeo:YES]; // 开始更新位置
    if([[MYLocationManager defaultManager] authorizationStatus] == kCLAuthorizationStatusDenied){
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"定位未开启，进入系统设置开启相应定位服务？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
    }
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        [[MYLocationManager defaultManager] turnToSettingLocationServicePage];
    }
}

#pragma mark UIApplicationDelegates

- (void)applicationDidBecomeActive{
    _originalTime = 0;
    [[MYLocationManager defaultManager] applicationDidBecomeActive];
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)applicationDidEnterBackground{
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    _originalTime = CFAbsoluteTimeGetCurrent();
    [[MYLocationManager defaultManager] applicationDidEnterBackground];
}

- (void)applicationWillTerminate{
    [[MYLocationManager defaultManager] applicationWillTerminate];
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
