//
//  MYDoubleTableView.h
//  InterestingDemo
//
//  Created by chenweinan on 17/4/4.
//  Copyright © 2017年 chenweinan. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSInteger const MYDOUBLETABLEVIEW_Main_Tag = 1000;//mainTable的tastaticg
static NSInteger const MYDOUBLETABLEVIEW_Sub_Tag = 1001;//subTable的tag

typedef void (^MYDoubleTableCellConfigBlock)(UITableView *tableView, id tableCell, id item, NSIndexPath *indexPath);


@protocol  MYDoubleTableViewDelegate<NSObject>

@optional;
- (void)doubleTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)doubleTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;

@end


@interface MYDoubleTableView : UIView

@property (strong, nonatomic, readonly) UITableView *mainTable;
@property (strong, nonatomic, readonly) UITableView *subTable;

@property (copy, nonatomic) MYDoubleTableCellConfigBlock cellConfigBlock;
@property (assign, nonatomic) id <MYDoubleTableViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame mainTableCellClass:(Class)mainCell subTableCellClass:(Class)subCell;

- (void)reloadMainTable:(NSMutableArray *)data;
- (void)reloadSubTable:(NSMutableArray *)data;

- (void)clickMainTable:(NSInteger)index; //此方法调用后会调用代理方法doubleTableView:didSelectRowAtIndexPath:

@end
