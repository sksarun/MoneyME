//
//  CustomPeriodViewController.h
//  MoneyMe
//
//  Created by Tong on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomDatePicker.h"

@interface CustomPeriodViewController : UIViewController<IDatePickerUpdate> {
    IBOutlet UIButton* startButton;
    IBOutlet UIButton* endButton;
}

@property (nonatomic,retain) IBOutlet UIButton* startButton;
@property (nonatomic,retain) IBOutlet UIButton* endButton;

-(IBAction) startDateClicked:(id)sender;
-(IBAction) endDateClicked:(id)sender;
-(void) setUpButtonTitle;
@end
