//
//  MYDoubleTableModel.m
//  InterestingDemo
//
//  Created by chenweinan on 17/4/4.
//  Copyright © 2017年 chenweinan. All rights reserved.
//

#import "MYDoubleTableModel.h"

@interface MYDoubleTableModel ()

@property (strong, nonatomic) NSString *cellIdentifier;
@property (strong, nonatomic) NSString *headerIdentifier;
@property (copy, nonatomic) MYCellConfigBlock configBlock;

@end

@implementation MYDoubleTableModel

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier headerIdentifier:(NSString *)headerIdentifier cellConfigBlock:(MYCellConfigBlock)configBlock{
    if(self = [super init]){
        self.data = [NSMutableArray array];
        self.cellIdentifier = cellIdentifier;
        self.headerIdentifier = headerIdentifier;
        self.configBlock = [configBlock copy];
    }
    return self;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    if(self.configBlock){
        self.configBlock(cell, [self itemAtIndexPath:indexPath], indexPath);
    }
    return cell;
}

#pragma mark private methods

- (id)itemAtIndexPath:(NSIndexPath *)indexPath{
    return [self.data objectAtIndex:indexPath.row];
}

@end
