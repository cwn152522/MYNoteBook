//
//  RunHorseLampViewController.m
//  MYNoteBook
//
//  Created by chenweinan on 17/4/3.
//  Copyright © 2017年 chenweinan. All rights reserved.
//

#import "RunHorseLampViewController.h"
#import "RunHorseLamp_Normal.h"
#import "RunHorseLamp_Imediately.h"

@interface RunHorseLampViewController ()

@end

@implementation RunHorseLampViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavigationBar];
    // Do any additional setup after loading the view from its nib.
}

- (void)configNavigationBar{
    self.title = @"跑马灯";
    
    id target = self.navigationController.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    self.navigationController.navigationController.interactivePopGestureRecognizer.enabled = NO;
    // Do any additional setup after loading the view.
}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)gesture{};

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 事件处理

- (IBAction)onClickNormalState:(UIButton *)sender {
    RunHorseLamp_Normal *vc = [[RunHorseLamp_Normal alloc] initWithNibName:@"RunHorseLamp_Normal" bundle:nil];
    vc.title = @"跑马灯 - 正常模式";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onClickImediatelyState:(UIButton *)sender {
    RunHorseLamp_Imediately *vc = [[RunHorseLamp_Imediately alloc] initWithNibName:@"RunHorseLamp_Imediately" bundle:nil];
    vc.title = @"跑马灯 - 立即模式";
    [self.navigationController pushViewController:vc animated:YES];;
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
