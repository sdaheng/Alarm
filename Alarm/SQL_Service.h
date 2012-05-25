//
//  SQL_Service.h
//  Alarm
//
//  Created by dh s on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#define KFILENAME @"Clock.db"

@class ClockList;

@interface SQL_Service : NSObject
{
    sqlite3 *_database;
}
@property (nonatomic) sqlite3 *_database;

- (BOOL)OpenDB;
- (BOOL)CreateClockList:(sqlite3 *)createclocklist;
- (BOOL)InsertClockList:(ClockList *)insertclocklist;
- (BOOL)DeleteClockList:(ClockList *)deleteclocklist;
- (BOOL)UpdateCLockList:(ClockList *)updateclocklist;
- (NSMutableArray *)getClockList;
- (NSMutableArray *)searchClockList:(ClockList *)searchclocklist;

@end

@interface ClockList : NSObject {
    
    int sqlID;
    NSString *sqlText;
    int repeatvalue;
    NSString *labelText;
    
}

@property (nonatomic) int sqlID;
@property (nonatomic) int repeatvalue;
@property (nonatomic,strong) NSString *sqlText;
@property (nonatomic,strong) NSString *labelText;

@end