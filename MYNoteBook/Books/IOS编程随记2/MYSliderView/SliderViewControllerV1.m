//
//  SliderViewControllerV1.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/27.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "SliderViewControllerV1.h"
#import "DetaileViewController.h"
#import "ViewController_SliderView.h"

@interface SliderViewControllerV1 ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SliderViewControllerV1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [(ViewController_SliderView *)self.parentViewController showLog:[NSString stringWithFormat:@"%@ viewDidLoad", NSStringFromClass([self class])]];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [(ViewController_SliderView *)self.parentViewController showLog:[NSString stringWithFormat:@"%@ viewWillAppear", NSStringFromClass([self class])]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
    [(ViewController_SliderView *)self.parentViewController showLog:[NSString stringWithFormat:@"%@ viewWillDisppaAppear", NSStringFromClass([self class])]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaa"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aaa"];
    }
    [cell.textLabel setText:[NSString stringWithFormat:@"这是第一个视图控制器的第%ld个cell", indexPath.row + 1]];
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetaileViewController *controller = [[DetaileViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
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
