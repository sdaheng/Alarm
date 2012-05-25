//
//  SettingViewController.h
//  Alarm
//
//  Created by dh s on 12-2-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepeatTableViewController.h"

@interface SettingViewController : UITableViewController<Repeat>
{   
    IBOutlet UILabel  *Lab_Repeat;
    IBOutlet UILabel  *Lab_Sounds;
    IBOutlet UILabel  *Lab_Label ;
    RepeatTableViewController *RTVC;
}

@property (nonatomic,strong) IBOutlet UILabel  *Lab_Repeat;
@property (nonatomic,strong) IBOutlet UILabel  *Lab_Sounds;
@property (nonatomic,strong) IBOutlet UILabel  *Lab_Label ;


//- (IBAction)XiaoShui:(id)sender;
@end
