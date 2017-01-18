//
//  SearchHistory+CoreDataProperties.h
//  MYNoteBook
//
//  Created by chenweinan on 16/12/5.
//  Copyright © 2016年 chenweinan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SearchHistory.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchHistory (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *keyword;
@property (nullable, nonatomic, retain) NSDate *timestamp;

@end

NS_ASSUME_NONNULL_END
