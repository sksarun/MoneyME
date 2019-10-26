//
//  EditTransactionViewController.h
//  MoneyMe
//
//  Created by Tong on 5/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "SQLHandler.h"
#import "ITransTypeHandler.h"
#import "IPaidNameHandler.h"
#import "Transaction.h"
#import "CustomDatePicker.h"
#import "ITranEditUpdate.h"

@interface EditTransactionViewController : UIViewController <ISQLUpdate,ITransTypeHandler,IPaidNameHandler,IDatePickerUpdate>{
    IBOutlet BaseTableViewCell* nameCell;
    IBOutlet BaseTableViewCell* amountCell;
    IBOutlet BaseTableViewCell* paidTypeCell;
    IBOutlet BaseTableViewCell* descCell;
    IBOutlet BaseTableViewCell* dateCell;
    
    
    IBOutlet UITextView* descTextView;
    IBOutlet UITextField* amountField;
    IBOutlet UITextField* nameField;
    IBOutlet UILabel* transTypeLabel;
    IBOutlet UILabel* dateLabel;
    
    
    SQLHandler* sqlHandler;
    NSString* errorMsg;
    Transaction* trans;
    id<ITranEditUpdate>handler;
    
}
@property(nonatomic,retain) IBOutlet BaseTableViewCell* nameCell;
@property(nonatomic,retain) IBOutlet BaseTableViewCell* amountCell;
@property(nonatomic,retain) IBOutlet BaseTableViewCell* paidTypeCell;
@property(nonatomic,retain) IBOutlet BaseTableViewCell* descCell;
@property(nonatomic,retain) IBOutlet BaseTableViewCell* dateCell;


@property(nonatomic,retain) IBOutlet UITextView* descTextView;
@property(nonatomic,retain) IBOutlet UITextField* amountField;
@property(nonatomic,retain) IBOutlet UITextField* nameField;
@property(nonatomic,retain) IBOutlet UILabel* transTypeLabel;
@property(nonatomic,retain) IBOutlet UILabel* dateLabel;

@property(nonatomic,copy)  NSString* errorMsg;

-(BOOL) IsValid;

-(BOOL)validateName;
-(BOOL)validateAmount;
-(void)updateDatePaid;

-(IBAction) CommonpaidViewClicked;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withTran:(Transaction*)_trans withCallback:(id<ITranEditUpdate>)_handler;


@end
