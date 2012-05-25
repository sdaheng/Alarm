//
//  AlarmViewController.m
//  Alarm
//
//  Created by dh s on 12-2-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AlarmViewController.h"
#import <UIKit/UIKit.h>

@implementation AlarmViewController
@synthesize TimeLabel;
@synthesize dateformatter;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"HH:mm:ss"];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    
}
- (void)updateTime
{
    TimeLabel.textColor = [UIColor colorWithRed:233.0 green:241.0 blue:246.0 alpha:0.7];
    TimeLabel.text = [dateformatter stringFromDate:[NSDate date]];
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
