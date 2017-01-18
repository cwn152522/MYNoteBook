//
//  MYSignUpTipsViewController.m
//  MayiW
//
//  Created by 陈伟南 on 16/7/19.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "MYSignUpTipsViewController.h"

@interface MYSignUpTipsViewController ()

@property (weak, nonatomic) IBOutlet UIView *myView;

@end

@implementation MYSignUpTipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isBlur = YES;
    _myView.userInteractionEnabled = YES;
    self.blurRadius = 5;
    self.blurColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self showViewWithAnimation:self.myView];
    // Do any additional setup after loading the view.
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
