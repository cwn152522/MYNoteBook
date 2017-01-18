//
//  MYUtility.h
//  MYNoteBook
//
//  Created by chenweinan on 16/11/29.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYNotesUtility : NSObject

+ (instancetype)defaultUtility;

- (NSArray *)filterArrayWithPredicate:(NSPredicate *)predicate;

+ (NSArray *)array:(NSMutableArray *)array filterWithPredicate:(NSPredicate *)predicate;

+ (NSString *)getDocxFileWithDocxName:(NSString *)fileName;

@end
