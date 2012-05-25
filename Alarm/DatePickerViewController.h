//
//  DatePickerViewController.h
//  Alarm
//
//  Created by dh s on 12-2-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerViewController : UIViewController
{
    NSDate          *Time         ;
    NSDateFormatter *TimeFormatter;
    NSString        *TimeString   ;
    UILocalNotification *AlarmNotifcation;
    UIDatePicker    *DatePicker   ;
}

@property (nonatomic,strong) NSDate          *Time         ;
@property (nonatomic,strong) NSDateFormatter *TimeFormatter;
@property (nonatomic,strong) NSString        *TimeString   ;
@property (nonatomic,strong) UILocalNotification *AlarmNotification;
@property (nonatomic,strong) IBOutlet UIDatePicker    *DatePicker   ;

- (IBAction)DatePicker:(UIDatePicker *)sender;
- (IBAction)Save:(id)sender;
- (void)AddNotification;

@end
