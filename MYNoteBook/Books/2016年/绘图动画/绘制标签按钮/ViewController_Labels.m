//
//  ViewController_Labels.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/26.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_Labels.h"
#import "MYStateArrowView.h"
#import "MYCornerLabel.h"
#import "ProjectStatusLabel.h"
#import "AboutUsVersionLabel.h"

@interface ViewController_Labels ()

@property (weak, nonatomic) IBOutlet MYStateArrowView *arrowLabel;
@property (weak, nonatomic) IBOutlet MYCornerLabel *cornerLabel1;
@property (weak, nonatomic) IBOutlet ProjectStatusLabel *cornerLabel2;
@property (weak, nonatomic) IBOutlet AboutUsVersionLabel *aboutUSLabel;

@end

@implementation ViewController_Labels

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绘制标签";
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_arrowLabel.titleLabel setText:@"分三期"];
    [_cornerLabel1 setFillColor:[UIColor redColor] andCornerRadius:3];
    [_cornerLabel2 setLineColor:[UIColor orangeColor] andCornerRadius:3];
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
