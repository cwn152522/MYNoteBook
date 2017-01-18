//
//  MYSearchHisttoryModel.m
//  MYNoteBook
//
//  Created by chenweinan on 16/12/5.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "MYSearchHisttoryModel.h"
#import "MYCoreDataManager.h"

static NSString * const kKeywordSearchEntity = @"SearchHistory";

@implementation MYSearchHisttoryModel

- (void)loadHistoryData{
    NSSortDescriptor *sort = [NSSortDescriptor  sortDescriptorWithKey:@"timestamp" ascending:NO];
    self.data = [[MYCoreDataManager defaultManager] fetchObjectsWithEntity:kKeywordSearchEntity predicate:nil sort:@[sort]];
}

- (void)addHistory:(NSString *)keyword{
    [self loadHistoryData];
    __block BOOL isOld;
    [_data enumerateObjectsUsingBlock:^(SearchHistory *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj.keyword isEqualToString: keyword]){
            isOld = YES;
            obj.timestamp = [NSDate date];
            *stop = YES;
        }
    }];
    
    if(!isOld){
      SearchHistory *history =  (SearchHistory *)[[MYCoreDataManager defaultManager] createObjectWithEntity:kKeywordSearchEntity];
        history.keyword = keyword;
        history.timestamp = [NSDate date];
    }
    
    [[MYCoreDataManager defaultManager] saveContext];
    [self loadHistoryData];
}

- (void)clearHistory{
    [self loadHistoryData];
    [_data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[MYCoreDataManager defaultManager] deleteObject:obj];
    }];
    [[MYCoreDataManager defaultManager] saveContext];
    [self loadHistoryData];
}

@end
