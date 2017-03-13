//
//  ViewController_DefaultMapLeading.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/27.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_DefaultMapLeading.h"
#import <MapKit/MapKit.h>

@interface ViewController_DefaultMapLeading ()

@property (weak, nonatomic) IBOutlet UITextField *placeTextField;

@end

@implementation ViewController_DefaultMapLeading

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onClickGo:(id)sender {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    if([_placeTextField.text length])
        [geocoder geocodeAddressString:_placeTextField.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//            MKMapItem *destinationItem = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithPlacemark:[placemarks lastObject]]];
//            MKMapItem *sourceItem = [MKMapItem mapItemForCurrentLocation];
//            NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDefault};//新增option，进入系统系统，自动推荐最优路线，计算出相关路线
//            [MKMapItem openMapsWithItems:@[sourceItem, destinationItem] launchOptions:launchOptions];
        }];
}

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
