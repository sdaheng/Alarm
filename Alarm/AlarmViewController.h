//
//  AlarmViewController.h
//  Alarm
//
//  Created by dh s on 12-2-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmViewController : UIViewController
{
    UILabel *TimeLabel;
    NSDateFormatter *dateformatter;
}
@property (nonatomic,strong) IBOutlet UILabel *TimeLabel;
@property (nonatomic,strong) NSDateFormatter  *dateformatter;

- (void)updateTime;

@end
