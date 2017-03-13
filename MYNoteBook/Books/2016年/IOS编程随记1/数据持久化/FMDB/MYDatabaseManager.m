//
//  MYDatabase.m
//  FMDB
//
//  Created by 陈伟南 on 16/10/11.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "MYDatabaseManager.h"

static MYDatabaseManager *instance;

//数据库
static const NSString *kDatabaseName = @"MYDATABASE";

//数据表
const  NSString *MYDatabase_T_Person = @"T_PERSON";

@interface MYDatabaseManager ()

@end

@implementation MYDatabaseManager

+ (instancetype)defaultManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MYDatabaseManager alloc] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone: zone];
    });
    return instance;
}

- (FMDatabase *)database{
    if(!_database){
        NSString *databasePath = [self getDatabasePath];
            _database = [FMDatabase databaseWithPath:databasePath];
            if(!_database){
                NSLog(@"数据库初始化失败，原因：%@", _database.lastErrorMessage);
            }
    }
    return _database;
}

#pragma mark Public Methods

- (void)createTableUsingSQL:(NSString *)sql{
    if(!self.database)
        return;
    
    [_database open];
    BOOL isDown= [_database executeStatements:sql];
    [_database close];
    if(!isDown){
       NSLog(@"数据表创建失败，原因：%@", _database.lastErrorMessage);
    }else{
        //            NSLog(@"数据表创建成功");
    }
}

- (BOOL)insertObjectUsingSQL:(NSString *)sql withArgumentsArray:(NSArray *)arguments{
    if(!self.database)
        return NO;
    
    [_database open];
    BOOL isDown = [_database executeUpdate:sql withArgumentsInArray:arguments];
    [_database close];
    if(!isDown){
        NSLog(@"数据插入失败，原因：%@", _database.lastErrorMessage);
        return NO;
    }
    //            NSLog(@"数据插入成功");
    return YES;
}

- (BOOL)removeObjectUsintSQL:(NSString *)sql withArgumentsArray:(NSArray *)arguments{
    if(!self.database)
        return NO;
    
    [_database open];
    BOOL isDown = [_database executeUpdate:sql withArgumentsInArray:arguments];
    [_database close];
    if(!isDown){
        NSLog(@"数据删除失败，原因：%@", _database.lastErrorMessage);
        return NO;
    }
    //            NSLog(@"数据删除成功");
    return YES;
}

- (BOOL)updateObjectUsingSQL:(NSString *)sql withArgumentsArray:(NSArray *)arguments{
    if(!self.database)
        return NO;
    
    [_database open];
    BOOL isDown = [_database executeUpdate:sql withArgumentsInArray:arguments];
    [_database close];
    if(!isDown){
        NSLog(@"数据更新失败，原因：%@", _database.lastErrorMessage);
        return NO;
    }
    //            NSLog(@"数据更新成功");
    return YES;
}

- (FMResultSet *)queryObjectUsingSQL:(NSString *)sql withArgumentsArray:(NSArray *)arguments{
    if(!self.database)
        return nil;
    
    [_database open];
    FMResultSet *resultSet = [_database executeQuery:sql withArgumentsInArray:arguments];
    return resultSet;
}

- (void)closeDatabaseAfterQueryDown{
    if(!self.database)
        return;
    
    [_database close];
}

#pragma mark Private Methods

- (NSString *)getDatabasePath{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return  [path stringByAppendingPathComponent: [NSString stringWithFormat:@"%@.sqlite", kDatabaseName]];
}

@end
