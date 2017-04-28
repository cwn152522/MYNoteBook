//
//  ViewController_FMDB.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/25.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_FMDB.h"
#import "MYDatabaseManager.h"
#import "MYObjet.h"

@interface ViewController_FMDB ()

@end

@implementation ViewController_FMDB

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FMDB";
    //建表操作
    [[MYDatabaseManager defaultManager] createTableUsingSQL:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, PHONE TEXT)", MYDatabase_T_Person]];
    
    //删除操作
    //        [[MYDatabaseManager defaultManager] removeObjectUsintSQL:[NSString stringWithFormat:@"DELETE FROM %@ WHERE ID=?", MYDatabase_T_Person] withArgumentsArray:@[@"2"]];
    [[MYDatabaseManager defaultManager] removeObjectUsintSQL:[NSString stringWithFormat:@"DELETE FROM %@ ", MYDatabase_T_Person] withArgumentsArray:@[]];
    
    //插入操作
        [[MYDatabaseManager defaultManager] insertObjectUsingSQL:[NSString stringWithFormat:@"INSERT INTO %@ (NAME, PHONE) VALUES (?,?)", MYDatabase_T_Person] withArgumentsArray:@[@"忘忧草止水", @"13123323395"]];
    
    //更新操作
    //    [[MYDatabaseManager defaultManager] updateObjectUsingSQL:[NSString stringWithFormat:@"UPDATE %@ SET NAME=? WHERE ID=?", MYDatabase_T_Person] withArgumentsArray:@[@"哦买噶", @"1"]];
    
    //查询操作
    FMResultSet *resultSet = [[MYDatabaseManager defaultManager]  queryObjectUsingSQL:[NSString stringWithFormat:@"SELECT *FROM %@", MYDatabase_T_Person] withArgumentsArray:@[]];
    while ( [resultSet next]) {
        MYObjet *person = [[MYObjet alloc] init];
        person.name = [resultSet stringForColumn:@"NAME"];
        person.phoneNumber = [resultSet stringForColumn:@"PHONE"];
        [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"来自数据库：%@，电话：%@", person.name, person.phoneNumber] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }
    [[MYDatabaseManager defaultManager] closeDatabaseAfterQueryDown];
    
    NSLog(@"%@", [[MYDatabaseManager defaultManager] database].databasePath) ;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
