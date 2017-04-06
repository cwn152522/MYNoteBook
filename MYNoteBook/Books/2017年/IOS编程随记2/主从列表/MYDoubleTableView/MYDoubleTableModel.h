//
//  MYDoubleTableModel.h
//  InterestingDemo
//
//  Created by chenweinan on 17/4/4.
//  Copyright © 2017年 chenweinan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^MYCellConfigBlock)(id tableCell, id item, NSIndexPath *indexPath);

@interface MYDoubleTableModel : NSObject<UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *data;

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier headerIdentifier:(NSString *)headerIdentifier cellConfigBlock:(MYCellConfigBlock)configBlock;

@end
