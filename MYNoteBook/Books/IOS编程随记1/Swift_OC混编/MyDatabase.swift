//
//  MyDatabase.swift
//  FMDB
//
//  Created by 陈伟南 on 16/5/20.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

import Foundation

let MYDatabaseName = "MYDATABASE1"
let T_Person = "T_PERSON"
var database :FMDatabase!

class MyDatabase: NSObject {
    //MARK: 数据库创建
    class func getDatabase()->FMDatabase{
        let fileManager = NSFileManager.defaultManager()
        let databasePath = self.getDatabasePath()
        
        if !fileManager.fileExistsAtPath(databasePath) {
            let db = FMDatabase(path: databasePath)//创建数据库
            if db == nil {
                NSLog("数据库创建失败")
            }
            if db.open() {
                let sql = "CREATE TABLE IF NOT EXISTS \(T_Person) (ID INTEGER PRIMARY KEY, NAME TEXT, PHONE TEXT)"
                if !db.executeStatements(sql) {
                     NSLog("Person表创建失败")
                }
                db.close()
            } else {
                NSLog("Error: \(db.lastErrorMessage())")
            }
        }
        if (database != nil){
            return database;
        }else{
          let db = FMDatabase(path: databasePath)
          database = db
          return db
        }
    }
    
    //MARK: 数据库插入
    func insertObjectUsingSQL(sql:String, withArgumentsInArray arguments:[AnyObject])->Bool{
        let db = MyDatabase.getDatabase()
        db.open()
        let isdown = db.executeUpdate(sql, withArgumentsInArray: arguments)
        db.close()
        if isdown == false{
             NSLog("\(db.lastErrorMessage())",[]);
            return false
        }
        return true
    }
    
    //MARK: 数据库更新
    func updateObjectUsingSQL(sql:String, withArgumentsInArray arguments:[AnyObject])->Bool{
        let db = MyDatabase.getDatabase()
        db.open()
        let isdown = db.executeUpdate(sql, withArgumentsInArray: arguments)
        db.close()
        if isdown == false{
             NSLog("\(db.lastErrorMessage())",[]);
            return false
        }
        return true
    }
    
    //MARK: 数据库删除
    func removeObjectUsintSQL(sql:String, withArgumentsInArray arguments:[AnyObject])->Bool{
        let db = MyDatabase.getDatabase()
        db.open()
        let isdown = db.executeUpdate(sql, withArgumentsInArray: arguments)
        db.close()
        if isdown == false{
            NSLog("\(db.lastErrorMessage())",[]);
            return false
        }
        return true
    }
    
    //MARK: 数据库查询
    func selectObjectUsingSQL(sql:String, withArgumentsInArray arguments:[AnyObject])->FMResultSet{
        let db = MyDatabase.getDatabase()
        db.open()
        let resultSet = db.executeQuery(sql, withArgumentsInArray: arguments)
        return resultSet
    }
    
    func closeDatabaseAfterQueryDown(){
        let db = MyDatabase.getDatabase()
        db.close()
    }
    
    //MARK: 私有方法
    private class func getDatabasePath() -> String{
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentPath = path[0] as NSString
        let databasePath = documentPath.stringByAppendingPathComponent("\(MYDatabaseName).db")
        return databasePath
    }
    
}
