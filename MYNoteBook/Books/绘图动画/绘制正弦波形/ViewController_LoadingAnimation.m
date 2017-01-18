//
//  ViewController_LoadingAnimation.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/26.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_LoadingAnimation.h"
#import "ViewControllerV2.h"
#import "ViewControllerV3.h"

@interface ViewController_LoadingAnimation ()

@end

@implementation ViewController_LoadingAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"loading动画";
    // Do any additional setup after loading the view.
}

- (IBAction)onClickPush:(id)sender{
    ViewControllerV2 *controller = [[ViewControllerV2  alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)onClickPush1:(id)sender{
    ViewControllerV3 *controller = [[ViewControllerV3  alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
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
