//
//  ViewController_SearchBar.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/26.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_SearchBar.h"
#import "MYSearchBar.h"

@interface ViewController_SearchBar ()

@property (weak, nonatomic) IBOutlet MYSearchBar *searchBar;

@end

@implementation ViewController_SearchBar

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绘制纯背景色搜索栏";
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_searchBar setSearchBarColor:GLOBAL_COLOR];
    [_searchBar setBackgroundColor:GLOBAL_COLOR];
    [_searchBar.layer setCornerRadius:17];
    [_searchBar.layer setMasksToBounds:YES];
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
