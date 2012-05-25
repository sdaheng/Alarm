//
//  LabelViewController.h
//  Alarm
//
//  Created by dh s on 12-2-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelViewController : UIViewController
{
    IBOutlet UITextField *textfield;
    NSString *String;
    NSString *Selected_Row_Num;
    
}

@property (nonatomic,strong) IBOutlet UITextField *textfield;
@property (nonatomic,strong)          NSString    *String   ;
@property (nonatomic,strong)          NSString    *Selected_Row_Num;

@end
