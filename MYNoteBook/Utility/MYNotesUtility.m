//
//  MYUtility.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/29.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "MYNotesUtility.h"

static MYNotesUtility *instance;

@interface MYNotesUtility ()

@property (strong, nonatomic) NSArray *dataArr;

@end

@implementation MYNotesUtility

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

+ (instancetype)defaultUtility{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MYNotesUtility alloc] init];
    });
    return instance;
}

- (NSArray *)filterArrayWithPredicate:(NSPredicate *)predicate{
   return [self.dataArr filteredArrayUsingPredicate:predicate];
}

- (NSArray *)dataArr{
    if(!_dataArr){
        NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"myNotesArr" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
        _dataArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    }
    return _dataArr;
}

+ (NSArray *)array:(NSMutableArray *)array filterWithPredicate:(NSPredicate *)predicate{
    return [array filteredArrayUsingPredicate:predicate];
}

+(NSString *)getFileWithFileName:(NSString *)fileName{
    NSString *filPath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    return filPath;
}

@end
