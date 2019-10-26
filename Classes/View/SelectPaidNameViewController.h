//
//  SelectPaidNameViewController.h
//  MoneyMe
//
//  Created by Tong on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IPaidNameHandler.h"

@interface SelectPaidNameViewController : UIViewController<UIScrollViewDelegate> {
    IBOutlet UITableView* table;
    IBOutlet UITextField* nameText;
    IBOutlet UIButton* addButton;
    IBOutlet UILabel* textLabel;
    
    id<IPaidNameHandler> handler;
}
@property (nonatomic,retain) IBOutlet UITableView* table;
@property (nonatomic,retain) IBOutlet UITextField* nameText;
@property (nonatomic,retain) IBOutlet UIButton* addButton;
@property (nonatomic,retain) IBOutlet UILabel* textLabel;
-(IBAction) addPaidName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withHandler:(id<IPaidNameHandler>)_handler;
-(void) setLocalizedText;
-(void) hideKeyboard;
@end
