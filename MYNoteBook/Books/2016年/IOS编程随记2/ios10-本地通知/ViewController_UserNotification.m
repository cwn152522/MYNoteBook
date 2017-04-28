//
//  ViewController_UserNotification.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/27.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_UserNotification.h"
//#import <UserNotifications/UserNotifications.h>

@interface ViewController_UserNotification ()//<UNUserNotificationCenterDelegate>

@end

@implementation ViewController_UserNotification

- (void)viewDidLoad {
    [super viewDidLoad];
    [self oldNotificationSetting];
    [self newNotificationSetting];
    // Do any additional setup after loading the view.
}

- (void)oldNotificationSetting{
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}
- (IBAction)onClickSendOldLocalNotification:(id)sender {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertTitle = @"本地通知demo";
    notification.alertBody = @"你好，吃饭了没";
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];
    notification.repeatInterval=kCFCalendarUnitWeekday;//循环通知的周期
    notification.timeZone=[NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
}


- (void)newNotificationSetting{
//    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
//        if(granted){
//            [[UNUserNotificationCenter currentNotificationCenter] setDelegate: self];
//        }
//    }];
}
- (IBAction)onClickSendNewLocalNotification:(id)sender {
    /*
     identifier: 通知标识符，用来区分不同的本地通知
     content:相当于原来的notification设置属性
     trigger:设置触发时间和重复的类
     */
//    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
//    content.title = @"ios10本地通知demo";
//    content.badge = @1;
//    content.sound = [UNNotificationSound defaultSound];
//    content.body = @" 你好，吃了没?";
//    content.subtitle = @"子标题";
    
    //TimeInterval：触发时间
    //repeats: 设置重复
//    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3 repeats:NO];
    
//    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"es" content:content trigger:trigger];
    //通知中心
//    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
}

#pragma mark UNUserNotificationCenterDelegate

//- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
//    NSLog(@"在前台情况下收到了通知");
//    completionHandler(UNNotificationPresentationOptionAlert);
//}
//
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
//    NSLog(@"用户点击完通知启动了app");
//    completionHandler();
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
