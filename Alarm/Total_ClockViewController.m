//
//  Total_ClockViewController.m
//  Alarm
//
//  Created by dh s on 12-2-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Total_ClockViewController.h"
#import "SQL_Service.h"

@implementation Total_ClockViewController
@synthesize T_Clocks;

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SQL_Service *sqlser = [[SQL_Service alloc]init];
    T_Clocks = [[NSMutableArray alloc]init];
    T_Clocks = [sqlser getClockList];
    NSLog(@"T_Clocks = %@ ",T_Clocks);
    
}
- (void)viewWillAppear:(BOOL)animated  
{
    SQL_Service *sqlser = [[SQL_Service alloc]init];
    T_Clocks = [sqlser getClockList];
    [self.tableView reloadData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [T_Clocks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TotalClock";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    ClockList *Clock_List = [[ClockList alloc]init];
    Clock_List = [T_Clocks objectAtIndex:indexPath.row];
    cell.textLabel.text = Clock_List.sqlText;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [T_Clocks removeObjectAtIndex:indexPath.row];
        SQL_Service *sqlser = [[SQL_Service alloc]init];
        ClockList *clock_List = [[ClockList alloc]init];
        //clock_List.sqlID;
        [sqlser DeleteClockList:clock_List];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *Label_dic_info = [[NSMutableDictionary alloc]init];
    NSString *row = [[NSString alloc]initWithFormat:@"%d",indexPath.row];
    [Label_dic_info setValue:row forKey:@"row of cell"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Label" object:self userInfo:Label_dic_info];
    NSLog(@"label_dic_info = %@",Label_dic_info);
}

@end
