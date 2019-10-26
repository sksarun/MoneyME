//
//  EditAccountViewController.h
//  MoneyMe
//
//  Created by Tong on 9/7/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditAccountViewController : UIViewController

@property (nonatomic,retain) IBOutlet UITextField* nameTextField;
-(void)doneClicked;
@end
