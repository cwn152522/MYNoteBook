//
//  ViewController_MJRefresh.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/26.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_MJRefresh.h"
#import "MYRefreshHeader.h"
#import "MYRefreshFooter.h"

@interface ViewController_MJRefresh ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController_MJRefresh

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MJRefresh";
    
    __weak typeof(self) weakSelf = self;
    MYRefreshHeader *header = [MYRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    self.tableView.mj_header = header;
    
    MYRefreshFooter *footer = [MYRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    self.tableView.mj_footer = footer;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadNewData{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    });
}

#pragma mark UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"fdas"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fdas"];
    }
    [cell.textLabel setText:[NSString stringWithFormat:@"第%ld行数据", indexPath.row + 1]];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
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
