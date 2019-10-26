//
//  CreatePaidTypeViewController.h
//  MoneyMe
//
//  Created by Tong on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CreatePaidTypeViewController : UIViewController {
    
    IBOutlet UINavigationItem* navBar;
    IBOutlet UIBarButtonItem* doneItem;
    IBOutlet UIBarButtonItem* cancelItem;
    IBOutlet UILabel* titleLabel;
    IBOutlet UITextField* textField;
}

@property (nonatomic,retain) IBOutlet UINavigationItem* navBar;
@property (nonatomic,retain) IBOutlet UIBarButtonItem* doneItem;
@property (nonatomic,retain) IBOutlet UIBarButtonItem* cancelItem;
@property (nonatomic,retain) IBOutlet UILabel* titleLabel;
@property (nonatomic,retain) IBOutlet UITextField* textField;

-(IBAction) onDoneClicked;
-(IBAction) onCancelClicked;

-(void) setLocalizedText;

@end
