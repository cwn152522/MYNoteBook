//
//  DoubleTable_ViewController.m
//  MYNoteBook
//
//  Created by 伟南 陈 on 2017/4/6.
//  Copyright © 2017年 chenweinan. All rights reserved.
//

#import "DoubleTable_ViewController.h"
#import "MYSearchBar.h"
#import "MYDoubleTableView.h"

#define ShiPei(x) [UIScreen mainScreen].bounds.size.width / 320.0 * x

@interface DoubleTable_ViewController ()<MYDoubleTableViewDelegate>

@property (strong, nonatomic) MYSearchBar *searchBar;
@property (strong, nonatomic) MYDoubleTableView *tableView;

@property (strong, nonatomic) NSMutableArray *mainData;
@property (strong, nonatomic) NSMutableArray *subDatas;

@property (assign, nonatomic) NSInteger selectMainRow;

@end

@implementation DoubleTable_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavigationBar];
    [self configTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _mainData = [NSMutableArray arrayWithObjects:@"兴趣1", @"兴趣2", @"兴趣3", @"兴趣4", @"兴趣5", @"兴趣6", @"兴趣7", nil];
    _subDatas = [NSMutableArray arrayWithObjects:@[@"兴趣1详情1", @"兴趣1详情2", @"兴趣1详情3"],@[@"兴趣2详情1", @"兴趣2详情2", @"兴趣2详情3"], @[@"兴趣3详情1"] , @[@"兴趣4详情1", @"兴趣4详情2", @"兴趣4详情3", @"兴趣4详情4"], @[@"兴趣5详情1"], @[@"兴趣6详情1", @"兴趣6详情2", @"兴趣6详情3"], @[@"兴趣7详情1", @"兴趣7详情2"],nil];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshTableView];
}

- (void)configNavigationBar{
    if(_searchBar == nil){
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        
        UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth([UIScreen mainScreen].bounds), 20)];
        statusView.backgroundColor = [UIColor colorWithRed:119.0/255 green:189.0/255 blue:182.0/255 alpha:1];
        [self.navigationController.navigationBar addSubview:statusView];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.navigationController.navigationBar.bounds) - 60, 28)];
        view.backgroundColor = [UIColor clearColor];
        _searchBar = [[MYSearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.bounds) - ShiPei(30), 28)];
        [_searchBar searchTextFiled].placeholder = @"搜索兴趣班等";
        [_searchBar setSearchBarColor:[UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1]];
        [view addSubview:_searchBar];
        self.navigationItem.titleView = view;
    }
}

- (void)configTableView{
    self.tableView = [[MYDoubleTableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - 64) mainTableCellClass:[UITableViewCell class] subTableCellClass:[UITableViewCell class]];
    [self.view addSubview:self.tableView];
    
    self.tableView.cellConfigBlock = ^(UITableView *tableView, id tableCell, id item, NSIndexPath *indexPath){
        //        NSLog(@"table:%@的第%ld个cell的cellforrow", tableView, indexPath.row);
        switch (tableView.tag) {
            case MYDOUBLETABLEVIEW_Main_Tag:{
            }
                break;
            case MYDOUBLETABLEVIEW_Sub_Tag:{
                NSInteger random = arc4random() % 7;
                NSArray *colors = @[[UIColor redColor], [UIColor orangeColor], [UIColor grayColor], [UIColor yellowColor], [UIColor purpleColor], [UIColor blueColor], [UIColor greenColor]];
                [tableCell setBackgroundColor:colors[random]];
            }
                break;
            default:
                break;
        }
        
        UITableViewCell *cell = (UITableViewCell *)tableCell;
        [cell.textLabel setText:item];
    };
    self.tableView.delegate = self;
}

#pragma mark 数据请求

- (void)refreshTableView{
    [self.tableView reloadMainTable:_mainData];
    [self.tableView clickMainTable:0];
}

#pragma mark MYDoubleTableViewDelegate

- (void)doubleTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (tableView.tag) {
        case MYDOUBLETABLEVIEW_Main_Tag:
            self.selectMainRow = indexPath.row;
            [self.tableView reloadSubTable:[_subDatas objectAtIndex:indexPath.row]];
            break;
        case MYDOUBLETABLEVIEW_Sub_Tag:
            [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"点击了兴趣%ld栏目的第%ld个兴趣详情", self.selectMainRow + 1 , indexPath.row + 1] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        default:
            break;
    }
}

- (CGFloat)doubleTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (tableView.tag) {
        case MYDOUBLETABLEVIEW_Main_Tag:
            return (CGRectGetHeight(tableView.frame))/self.mainData.count;
            break;
        case MYDOUBLETABLEVIEW_Sub_Tag:
            return 200;
            break;
        default:
            break;
    }
    return 44;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.searchBar endEditing:YES];
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
