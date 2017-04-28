//
//  MYDatabase.h
//  FMDB
//
//  Created by 陈伟南 on 16/10/11.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

extern NSString *MYDatabase_T_Person;

@interface MYDatabaseManager : NSObject

@property (strong, nonatomic) FMDatabase *database;

/**
 * 获取管理实例
 *
 */
+ (instancetype)defaultManager;

/**
 * 创建数据表
 *
 * @ param sql 数据库查询语句 eg. [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, PHONE TEXT)", MYDatabase_T_Person];
 */
- (void)createTableUsingSQL:(NSString *)sql;

/**
 * 数据插入
 *
 * @ param sql 数据库查询语句 eg. [NSString stringWithFormat:@"INSERT INTO %@ (NAME) VALUES (?)", MYDatabase_T_Person]
 * @ param arguments 查询语句参数 eg. @[@"哇哈哈哈哈"]
 */
- (BOOL)insertObjectUsingSQL:(NSString *)sql withArgumentsArray:(NSArray *)arguments;

/**
 * 数据删除
 *
 * @ param sql 数据库查询语句 eg. [NSString stringWithFormat:@"DELETE FROM %@ WHERE ID=?", MYDatabase_T_Person)]
 * @ param arguments 查询语句参数 eg. @[@"7"]
 */
- (BOOL)removeObjectUsintSQL:(NSString *)sql withArgumentsArray:(NSArray *)arguments;

/**
 * 数据修改
 *
 * @ param sql 数据库查询语句 eg. [NSString stringWithFormat:@"UPDATE %@ SET NAME=? WHERE ID=?", MYDatabase_T_Person]
 * @ param arguments 查询语句参数 eg. @[@"fawefawegfa", @"5"]
 */
- (BOOL)updateObjectUsingSQL:(NSString *)sql withArgumentsArray:(NSArray *)arguments;

/**
 * 数据查询
 *
 * @ note 记得查询结果FMResultSet操作结束后关闭数据库，提前关闭会导致后续操作出现问题
 * @ param sql 数据库查询语句 eg. [NSString stringWithFormat:@"SELECT *FROM %@", MYDatabase_T_Person]
 * @ param arguments 查询语句参数 eg. @[]
 */
- (FMResultSet *)queryObjectUsingSQL:(NSString *)sql withArgumentsArray:(NSArray *)arguments;

/**
 * 关闭数据库
 * @ note 数据库查询结果FMResultSet操作结束后调用
 */
- (void)closeDatabaseAfterQueryDown;

@end
