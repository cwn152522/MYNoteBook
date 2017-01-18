//
//  MYSearchHisttoryModel.h
//  MYNoteBook
//
//  Created by chenweinan on 16/12/5.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchHistory.h"

@interface MYSearchHisttoryModel : NSObject

@property (strong, nonatomic) NSArray *data;

- (void)loadHistoryData;

- (void)addHistory:(NSString *)keyword;

- (void)clearHistory;

@end
