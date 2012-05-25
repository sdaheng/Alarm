//
//  SQL_Service.m
//  Alarm
//
//  Created by dh s on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SQL_Service.h"

@implementation SQL_Service
@synthesize _database;

- (id)init
{
    return self;
}

- (NSString *)DataFilePath
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir = [path objectAtIndex:0];
    return [dir stringByAppendingPathComponent:KFILENAME];
}

- (BOOL)OpenDB
{
    NSString *path = [self DataFilePath];
    NSLog(@"path = %@",path);
    NSFileManager *filemanager = [NSFileManager defaultManager];
    BOOL Find = [filemanager fileExistsAtPath:path];
    
    if (Find) {
        NSLog(@"Database file have already existed.");
        if (sqlite3_open([path UTF8String], &_database) != SQLITE_OK) {
            sqlite3_close(self._database);
            NSLog(@"Error: Open Database File Failed.");
            return NO;
        }
        [self CreateClockList:self._database];
        return YES;
    }
    if (sqlite3_open([path UTF8String], &_database) == SQLITE_OK) {
        NSLog(@"Open database file success.");
        [self CreateClockList:self._database];
        return YES;
    }
    return NO;
}

- (BOOL)CreateClockList:(sqlite3 *)createclocklist
{
    sqlite3_stmt *statement = NULL;
    static char *sql = "create table if not exists clockTable(ID INTEGER PRIMARY KEY AUTOINCREMENT, clockID int, clockValue text, repeatValue int, labelValue text)";

    NSInteger sqlreturn = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
    if (sqlreturn != SQLITE_OK) {
        NSLog(@"Error: Fail to prepare statement: CreatTable");
        return NO;
    }
    
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        NSLog(@"Error: Fail to create table");
        return NO;
    }
    NSLog(@"Create table success.");
    return YES;
}

- (BOOL)InsertClockList:(ClockList *)insertclocklist
{
    if ([self OpenDB]) {
        
        sqlite3_stmt *statement = NULL;
        static char *sql = "INSERT INTO clockTable(clockID,clockValue,repeatValue,labelValue) VALUES(?,?,?,?)";
        
        int success = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
        
        if (success != SQLITE_OK) {
            NSLog(@"Error: Fail to Insert.");
            sqlite3_close(_database);
            return  NO;
        }
        
        sqlite3_bind_int(statement, 1, insertclocklist.sqlID);
        sqlite3_bind_text(statement, 2, [insertclocklist.sqlText UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 3, insertclocklist.repeatvalue);
        sqlite3_bind_text(statement, 4, [insertclocklist.labelText UTF8String], -1, SQLITE_TRANSIENT);
        
        success = sqlite3_step(statement);
        sqlite3_finalize(statement);
        if (success == SQLITE_ERROR) {
            NSLog(@"Error: Faile to insert with message");
            sqlite3_close(_database);
            return NO;
        }
        NSLog(@"Insert success");
        sqlite3_close(_database);
        return YES;
    }
    return NO;
}

- (NSMutableArray *)getClockList
{
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:10];
    if ([self OpenDB]) 
        {
            sqlite3_stmt *statement = NULL;
            static char *sql = "SELECT clockID,clockValue FROM clockTable";
        
            int success = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
        
            if (success != SQLITE_OK) {
                NSLog(@"Error: Faile to prepare statement:GetClockList");
        }
    else
        {
                while (sqlite3_step(statement) == SQLITE_ROW) 
                {
                    ClockList *clocklist = [[ClockList alloc]init];
                    clocklist.sqlID = sqlite3_column_int(statement, 0);
                    char *strText = (char *)sqlite3_column_text(statement, 1);
                    clocklist.sqlText = [NSString stringWithUTF8String:strText];
                    [array addObject:clocklist];
                }
        }
            sqlite3_finalize(statement);
            sqlite3_close(_database);
    }
    return array;
}

- (BOOL)DeleteClockList:(ClockList *)deleteclocklist 
{
    if ([self OpenDB]) {
        
        sqlite3_stmt *statement = NULL;
        static char *sql = "DELETE FROM clockTable WHERE clockID = ? AND clockValue = ?";
        
        int success = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
        
        if (success != SQLITE_OK) {
            NSLog(@"Error: Fail to prepare statement:Delete ClockVale");
            sqlite3_close(_database);
            return NO;
        }
        
        sqlite3_bind_int(statement, 1, deleteclocklist.sqlID);
        sqlite3_bind_text(statement, 2, [deleteclocklist.sqlText UTF8String], -1, SQLITE_TRANSIENT);
        
        success = sqlite3_step(statement);
        sqlite3_finalize(statement);
        
        if (success == SQLITE_ERROR)
        {
            NSLog(@"Error: Fail to delete value with message");
            sqlite3_close(_database);
            return NO;
        }
        sqlite3_close(_database);
        return YES;
    }
    return  YES;
}
- (BOOL)UpdateCLockList:(ClockList *)updateclocklist
{
    if ([self OpenDB]) {
        
        sqlite3_stmt *statement = NULL;
        static char *sql = "UPDATE clockTable SET labelValue = ? WHERE clockValue = ?";
    
        int success = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
        
        if (success != SQLITE_OK) {
            NSLog(@"Error: Fail to prepare statement:Update clockTable");
            sqlite3_close(_database);
            return NO;
        }
        
        sqlite3_bind_text(statement, 1, [updateclocklist.labelText UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 2, updateclocklist.sqlID);
        
        success = sqlite3_step(statement);
        sqlite3_finalize(statement);
        
        if (success == SQLITE_ERROR) {
            NSLog(@"Error: Fail to Update with message");
            sqlite3_close(_database);
            return NO;
        }
        sqlite3_close(_database);
        return YES;
    }
    return NO;
}

- (NSMutableArray *)searchClockList:(ClockList *)searchclocklist
{
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:10];
    
    return array;
}

@end

@implementation ClockList

@synthesize sqlText;
@synthesize sqlID;
@synthesize repeatvalue;
@synthesize labelText;

- (id)init
{
    sqlID = 0;
    sqlText = @"";
    repeatvalue = 0;
    labelText = @"闹钟";
    return self;
}

@end