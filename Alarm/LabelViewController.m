//
//  LabelViewController.m
//  Alarm
//
//  Created by dh s on 12-2-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LabelViewController.h"
#import "SQL_Service.h"

@implementation LabelViewController
@synthesize textfield;
@synthesize String;
@synthesize Selected_Row_Num;

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
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/
-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    SQL_Service *sqler = [[SQL_Service alloc]init];
    ClockList *Clock_Label_List = [[ClockList alloc]init];
    
    Clock_Label_List.labelText = textfield.text;
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receivelabel) name:@"Label" object:nil];
    NSString *sqlid = [NSString stringWithFormat:@"%d",Clock_Label_List.sqlID-1];
    if ([self.Selected_Row_Num isEqualToString:sqlid]) {
        [sqler  InsertClockList:Clock_Label_List];
    }
    
}
- (void)receivelabel:(NSNotification *)notification
{
    NSDictionary *dic = [notification userInfo];
    self.Selected_Row_Num = [dic valueForKey:@"cell of row"];
    NSLog(@"receivelable`s Selected_Row_Num = %@",self.Selected_Row_Num);
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
