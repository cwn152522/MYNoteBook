//
//  ViewControllerV3.m
//  MYImageViewAnimation
//
//  Created by chenweinan on 16/10/25.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewControllerV3.h"
#import "UIViewController+Base.h"

@interface ViewControllerV3 ()

@end

@implementation ViewControllerV3

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绘制正弦波形";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showProgress:@"正在加载..."];
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
