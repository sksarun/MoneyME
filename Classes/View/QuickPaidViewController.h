//
//  QuickPaidViewController.h
//  MoneyMe
//
//  Created by Tong on 5/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "ISQLUpdate.h"
#import "SQLHandler.h"
#import "QuickPaidObject.h"
#import "ITransTypeHandler.h"
#import "IPaidNameHandler.h"
#import "IPaymentTypeHandler.h"
#import "CustomDatePicker.h"
#import "ISeqTypeHandler.h"
#import "MyScrollView.h"
#import "FavoriteView.h"

@class Transaction;

@interface QuickPaidViewController : UIViewController <UIScrollViewDelegate,ISQLUpdate,ITransTypeHandler,IPaidNameHandler,IPaymentTypeHandler,IDatePickerUpdate,UIActionSheetDelegate,ISeqTypeHandler>{
    IBOutlet BaseTableViewCell* nameCell;
    IBOutlet BaseTableViewCell* amountCell;
    IBOutlet BaseTableViewCell* paidTypeCell;
    IBOutlet BaseTableViewCell* paymentTypeCell;
    IBOutlet BaseTableViewCell* descCell;
    IBOutlet BaseTableViewCell* dateCell;
    IBOutlet BaseTableViewCell* seqCell;
    IBOutlet BaseTableViewCell* seqPeriodCell;
    
    ////// Title //////
    IBOutlet UILabel* nameTitleLabel;
    IBOutlet UILabel* amountTitleLabel;
    IBOutlet UILabel* transTypeTitleLabel;
    IBOutlet UILabel* paidTypeTitleLabel;
    IBOutlet UILabel* dateTitleLabel;
    IBOutlet UILabel* descTitleLabel;
    IBOutlet UILabel* seqTitleLabel;
    IBOutlet UILabel* seqPeriodTitleLabel;
    
    
    IBOutlet UITextView* descTextView;
    IBOutlet UITextField* amountField;
    IBOutlet UITextField* nameField;
    IBOutlet UILabel* transTypeLabel;
    IBOutlet UILabel* paymentTypeLabel;
    IBOutlet UILabel* dateLabel;
    IBOutlet UILabel* currencyLabel;
    IBOutlet UISwitch* sequenceSwitch;
    IBOutlet UILabel* sequenceLabel;
    
    IBOutlet UIImageView* paymentIcon;
    
    IBOutlet UIView* quickPaidView;
    IBOutlet UIView* favoriteView;
    IBOutlet UITableView* table;
    
    IBOutlet MyScrollView* favoriteScroller;
    
    
    SQLHandler* sqlHandler;
    NSString* errorMsg;
    
    QuickPaidObject* quickPaidObj;
    NSDate* paidDate;
    
    BOOL isFavorite;
    
    IBOutlet UIPageControl * pageControl;
    IBOutlet UIButton* saveButton;
    IBOutlet UIView* favoriteBar;
    IBOutlet UIButton* deleteFavButton;
    int currentFavIndex;
    BOOL isFavoriteDeleteMode;
}
@property(nonatomic,retain)IBOutlet UIPageControl * pageControl;    
@property(nonatomic,retain)IBOutlet UIView* quickPaidView;
@property (nonatomic,retain)IBOutlet UIView* favoriteView;
@property (nonatomic,retain)IBOutlet  UIButton* saveButton;
@property (nonatomic,retain) IBOutlet UIView* favoriteBar;
@property (nonatomic,retain) IBOutlet UIButton* deleteFavButton;

@property (nonatomic,retain)IBOutlet MyScrollView* favoriteScroller;

@property (nonatomic,retain)IBOutlet UITableView* table;
@property(nonatomic,retain) IBOutlet BaseTableViewCell* nameCell;
@property(nonatomic,retain) IBOutlet BaseTableViewCell* amountCell;
@property(nonatomic,retain) IBOutlet BaseTableViewCell* paidTypeCell;
@property(nonatomic,retain) IBOutlet BaseTableViewCell* descCell;
@property(nonatomic,retain) IBOutlet BaseTableViewCell* paymentTypeCell;
@property(nonatomic,retain) IBOutlet BaseTableViewCell* dateCell;
@property(nonatomic,retain) IBOutlet BaseTableViewCell* seqCell;
@property(nonatomic,retain) IBOutlet BaseTableViewCell* seqPeriodCell;

@property(nonatomic,retain) IBOutlet UILabel* nameTitleLabel;
@property(nonatomic,retain) IBOutlet UILabel* amountTitleLabel;
@property(nonatomic,retain) IBOutlet UILabel* transTypeTitleLabel;
@property(nonatomic,retain) IBOutlet UILabel* paidTypeTitleLabel;
@property(nonatomic,retain) IBOutlet UILabel* dateTitleLabel;
@property(nonatomic,retain) IBOutlet UILabel* descTitleLabel;
@property(nonatomic,retain) IBOutlet UILabel* seqTitleLabel;
@property(nonatomic,retain) IBOutlet UILabel* seqPeriodTitleLabel;

@property (nonatomic,retain) IBOutlet UILabel* sequenceLabel;
@property (nonatomic,retain) IBOutlet UISwitch* sequenceSwitch;
@property(nonatomic,retain) IBOutlet UITextView* descTextView;
@property(nonatomic,retain) IBOutlet UITextField* amountField;
@property(nonatomic,retain) IBOutlet UITextField* nameField;
@property(nonatomic,retain) IBOutlet UILabel* transTypeLabel;
@property(nonatomic,retain) IBOutlet UILabel* paymentTypeLabel;
@property (nonatomic,retain) IBOutlet UILabel* dateLabel;
@property (nonatomic,retain) IBOutlet UILabel* currencyLabel;

@property (nonatomic,retain) IBOutlet UIImageView* paymentIcon;

@property(nonatomic,copy)  NSString* errorMsg;
@property(nonatomic,retain) NSDate* paidDate;


-(BOOL) IsValid;
-(void) setLocalizedTitle;

-(BOOL)validateName;
-(BOOL)validateAmount;

-(BOOL) isMatchSequnce;

-(IBAction) CommonpaidViewClicked;

-(IBAction) DoneViewClicked:(id)sender;

-(IBAction) onFavoriteChange:(id)sender;
-(IBAction) onQuickPaidChange:(id)sender;

-(void) hideKeyboard;
-(void)updateDatePaid;
-(void) updatePaymentIcon;

-(void) setViewMovedUp;
-(void) setViewBackUp;

-(void)execTrans;
 
-(IBAction) onSeqSwitchChanged:(id)sender;
-(IBAction) onAddFavorite:(id)sender;
-(IBAction) onSavedFavorite:(id)sender;
-(IBAction) onDeleteFavActive:(id)sender;

-(void) onFavoriteDeleted:(int)index;

-(void) createFavoritePage; 
-(void) onFavoriteSelected:(Transaction*)selectedTrans;
- (void)doHighlight:(UIButton*)b ;
@end
