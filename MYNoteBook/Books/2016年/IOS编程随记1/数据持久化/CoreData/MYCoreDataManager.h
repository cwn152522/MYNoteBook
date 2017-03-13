//
//  MYCoreDataManager.h
//  Core Data
//
//  Created by 陈伟南 on 16/5/24.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define STORE_NAME @"MYDatabase.sqlite"//数据库名

NS_ASSUME_NONNULL_BEGIN

@interface MYCoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/* 获取单例对象 */
+ (MYCoreDataManager *)defaultManager;

/* 添加操作 */
- (NSManagedObject *)createObjectWithEntity:(NSString *)entityName;

/* 删除操作 */
- (void)deleteObject:(NSManagedObject *)object;
- (void)deleteAllObjects:(NSString *)entityName;

/*
 查询操作
 支持谓词predicate和排序描述器sortDescriptor
*/
- (NSArray *)fetchObjectsWithEntity:(NSString *)entityName
                          predicate:(nullable NSPredicate *)predicate
                               sort:(nullable NSArray<NSSortDescriptor*> *)sortDescriptors;

/* 保存修改 */
- (void)saveContext;

@end

NS_ASSUME_NONNULL_END
