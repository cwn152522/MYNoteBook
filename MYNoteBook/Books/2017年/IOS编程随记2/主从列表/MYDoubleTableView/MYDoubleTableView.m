//
//  MYDoubleTableView.m
//  InterestingDemo
//
//  Created by chenweinan on 17/4/4.
//  Copyright © 2017年 chenweinan. All rights reserved.
//

#import "MYDoubleTableView.h"
#import "MYDoubleTableModel.h"

static NSString *const kMainTableCellIdentifier = @"mainCell";
static NSString *const kSubTableCellIdentifier = @"subCell";

@interface MYDoubleTableView ()<UITableViewDelegate>

@property (weak, nonatomic) Class mainCellClass;
@property (weak, nonatomic) Class subCellClass;

@property (strong, nonatomic) MYDoubleTableModel *mainTableDataSource;
@property (strong, nonatomic) MYDoubleTableModel *subTableDataSource;

@end

@implementation MYDoubleTableView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _mainCellClass = [UITableViewCell class];
        _subCellClass = [UITableViewCell class];
        [self configDoubleTable];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame mainTableCellClass:(Class)mainCell subTableCellClass:(Class)subCell{
    if(self = [super initWithFrame:frame]){
        _mainCellClass = mainCell;
        _subCellClass = subCell;
        [self configDoubleTable];
    }
    return self;
}

- (void)configDoubleTable{
    __weak typeof(self) weakSelf = self;
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, CGRectGetHeight(self.bounds)) style:UITableViewStylePlain];
    [_mainTable registerClass:_mainCellClass forCellReuseIdentifier:kMainTableCellIdentifier];
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTable.tableFooterView = [[UIView alloc] init];
    _mainTable.backgroundColor = [UIColor whiteColor];
    _mainTable.showsVerticalScrollIndicator = NO;
    _mainTable.tag = MYDOUBLETABLEVIEW_Main_Tag;
    [self addSubview:_mainTable];
    _mainTableDataSource = [[MYDoubleTableModel alloc] initWithCellIdentifier:kMainTableCellIdentifier headerIdentifier:nil cellConfigBlock:^(id tableCell, id item, NSIndexPath *indexPath) {
        if(weakSelf.cellConfigBlock){
            weakSelf.cellConfigBlock(weakSelf.mainTable, tableCell, item, indexPath);
        }
    }];
    _mainTable.dataSource = _mainTableDataSource;
    _mainTable.delegate = self;
    
    _subTable = [[UITableView alloc] initWithFrame:CGRectMake(100, 0, CGRectGetWidth(self.bounds) - 100, CGRectGetHeight(self.bounds)) style:UITableViewStylePlain];
    [_subTable registerClass:_subCellClass forCellReuseIdentifier:kSubTableCellIdentifier];
    _subTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _subTable.tableFooterView = [[UIView alloc] init];
    _subTable.backgroundColor = [UIColor whiteColor];
    _subTable.showsVerticalScrollIndicator = NO;
    _subTable.tag = MYDOUBLETABLEVIEW_Sub_Tag;
    [self addSubview:_subTable];
    _subTableDataSource = [[MYDoubleTableModel alloc] initWithCellIdentifier:kSubTableCellIdentifier headerIdentifier:nil cellConfigBlock:^(id tableCell, id item, NSIndexPath *indexPath) {
        [tableCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if(weakSelf.cellConfigBlock){
            weakSelf.cellConfigBlock(weakSelf.subTable, tableCell, item, indexPath);
        }
    }];
    _subTable.dataSource = _subTableDataSource;
    _subTable.delegate = self;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.delegate && [self.delegate respondsToSelector:@selector(doubleTableView:didSelectRowAtIndexPath:)]){
        [self.delegate doubleTableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.delegate && [self.delegate respondsToSelector:@selector(doubleTableView:heightForRowAtIndexPath:)]){
        return [self.delegate doubleTableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return 44;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if(self.delegate && [self.delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]){
        [self.delegate scrollViewWillBeginDragging:scrollView];
    }
}

#pragma mark public methods

- (void)reloadMainTable:(NSMutableArray *)data{
    _mainTableDataSource.data = data;
    [_mainTable reloadData];
}

- (void)reloadSubTable:(NSMutableArray *)data{
    _subTableDataSource.data = data;
    [_subTable reloadData];
}

- (void)clickMainTable:(NSInteger)index{
    [self.mainTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self tableView:_mainTable didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
}

@end
