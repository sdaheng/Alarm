//
//  SettingViewController.m
//  Alarm
//
//  Created by dh s on 12-2-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"
#import "LabelViewController.h"
#import "RepeatTableViewController.h"
#import "DatePickerViewController.h"

extern int RepeatCount;

@implementation SettingViewController

@synthesize Lab_Repeat;
@synthesize Lab_Sounds;
@synthesize Lab_Label ;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
-(void) doSomething :(NSNotification *)notification
{
        NSDictionary *dic=[notification userInfo];
        NSLog(@"S_Dic=%@",dic);
        self.Lab_Label.text=[dic valueForKey:@"Label"];
}
- (void) RepeatText
{
    RTVC.RepeatDays;
}
/*
- (IBAction)XiaoShui:(id)sender
{
    if ([sender isOn]) {
        id timer;
        timer = [NSTimer scheduledTimerWithTimeInterval:300.0 target:self selector:@selector(XiaoShuiNotification) userInfo:nil repeats:YES];
        
    }
}

- (void)XiaoShuiNotification
{
    NSDate *now = [NSDate date];
    UILocalNotification *XS_Notification = [[UILocalNotification alloc]init];
    XS_Notification.fireDate  = now;
    XS_Notification.timeZone  = [NSTimeZone defaultTimeZone];
    XS_Notification.alertBody = @"快起床！！！";
    [[UIApplication sharedApplication]scheduleLocalNotification:XS_Notification];
}
*/
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doSomething:) name:@"Label1" object:nil];
}
- (void)viewWillAppear:(BOOL)animated  
{
    [super viewWillAppear:animated];
     RTVC.delegate = self; 
}
- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
