//
//  ViewController_Swift_OC.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/26.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_Swift_OC.h"
#import "OC_Swift-Swift.h"

@interface ViewController_Swift_OC ()

@property (strong, nonatomic) MyDatabase *database;

@end

@implementation ViewController_Swift_OC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Swift_OC混编";
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"swift_oc混合编程环境搭建完毕" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
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
