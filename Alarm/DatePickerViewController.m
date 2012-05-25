//
//  DatePickerViewController.m
//  Alarm
//
//  Created by dh s on 12-2-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DatePickerViewController.h"
#import <CoreData/CoreData.h>
#import "SQL_Service.h"

int ClockID;

@implementation DatePickerViewController

@synthesize Time         ;
@synthesize TimeFormatter;
@synthesize TimeString   ;
@synthesize AlarmNotification;

- (IBAction)DatePicker:(UIDatePicker *)sender
{
    __autoreleasing NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    __autoreleasing NSDateComponents *comp = [[NSDateComponents alloc]init];
    [calendar setTimeZone:[NSTimeZone defaultTimeZone]];
    
    NSUInteger unitflag = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit | NSQuarterCalendarUnit;
    
    comp = [calendar components:unitflag fromDate:sender.date];
    
    NSLog(@"Time = %@",Time);
    
    if ([comp minute]<10) {
        TimeString = [NSString stringWithFormat:@"%d:0%d",[comp hour],[comp minute]];
    }
    else {
        TimeString = [NSString stringWithFormat:@"%d:%d",[comp hour],[comp minute]];
    }
    
    NSLog(@"TimeString = %@",TimeString);
    
    Time = [calendar dateFromComponents:comp];
    
    NSLog(@"Time = %@",Time);
    
}

- (IBAction)Save:(id)sender
{   
    SQL_Service *sqlser = [[SQL_Service alloc]init];
    ClockList *Clock_List_Insert = [[ClockList alloc]init];
    
    Clock_List_Insert.sqlID = ClockID;
    Clock_List_Insert.sqlText = TimeString;
    ClockID++;
    
    if ([sqlser InsertClockList:Clock_List_Insert]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好", nil];
        [alert show];
        [self AddNotification];
        
    }
    else 
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"错误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好", nil];
        [alert show];
    }
}

- (void)AddNotification
{
    //NSString *soundname = @"sansun";
    AlarmNotification = [[UILocalNotification alloc]init];
    AlarmNotification.fireDate  = Time;
    AlarmNotification.alertBody = @"起床！！！";
    AlarmNotification.timeZone  = [NSTimeZone defaultTimeZone];
    AlarmNotification.soundName = UILocalNotificationDefaultSoundName;
    NSLog(@"soundname = %@",AlarmNotifcation.soundName);
    
    [[UIApplication sharedApplication]scheduleLocalNotification:AlarmNotification];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    ClockID = 0;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
