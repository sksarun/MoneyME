//
//  CreateViewController.h
//  MoneyMe
//
//  Created by Tong on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface CreateViewController : UIViewController {
	IBOutlet BaseTableViewCell* avatarCell;
	IBOutlet BaseTableViewCell* nameCell;
	IBOutlet BaseTableViewCell* nicknameCell;
	IBOutlet BaseTableViewCell* salaryCell;
	IBOutlet BaseTableViewCell* salaryTypeCell;
	IBOutlet BaseTableViewCell* genderCell;
    
    IBOutlet UITextField* nameField;
    IBOutlet UITextField* nicknameField;
    IBOutlet UITextField* salaryField;
    IBOutlet UISegmentedControl* genderSwitch;
}

@property (nonatomic,retain)IBOutlet BaseTableViewCell* avatarCell;
@property (nonatomic,retain)IBOutlet BaseTableViewCell* nameCell;
@property (nonatomic,retain)IBOutlet BaseTableViewCell* nicknameCell;
@property (nonatomic,retain)IBOutlet BaseTableViewCell* salaryCell;
@property (nonatomic,retain)IBOutlet BaseTableViewCell* salaryTypeCell;
@property (nonatomic,retain)IBOutlet BaseTableViewCell* genderCell;
@property (nonatomic,retain) IBOutlet UITextField* salaryField;

@property (nonatomic,retain)   IBOutlet UITextField* nameField;
@property (nonatomic,retain)IBOutlet UITextField* nicknameField;
@property (nonatomic,retain)IBOutlet UISegmentedControl* genderSwitch;

@end
