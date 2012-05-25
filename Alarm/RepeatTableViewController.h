//
//  RepeatTableViewController.h
//  Alarm
//
//  Created by dh s on 12-2-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Repeat <NSObject>

- (void)RepeatText;

@end

@interface RepeatTableViewController : UITableViewController 
{
    NSMutableArray *RepeatDays;
    id<Repeat>      delegate  ;
}
@property (nonatomic,strong) NSMutableArray *RepeatDays;
@property (nonatomic,strong) id<Repeat>      delegate  ;

@end
