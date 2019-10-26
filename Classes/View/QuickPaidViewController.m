//
//  QuickPaidViewController.m
//  MoneyMe
//
//  Created by Tong on 5/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuickPaidViewController.h"
#import "PaidTypeViewController.h"
#import "NSDate+Component.h"
#import "UIViewController+Extension.h"
#import "SingletonData.h"
#import "SelectPaidNameViewController.h"
#import "PaymentTypeViewController.h"
#import "SequenceTransaction.h"
#import "SelectSeqTypeViewController.h"

@implementation QuickPaidViewController
@synthesize nameCell,amountCell,paidTypeCell,descCell;
@synthesize descTextView,amountField,nameField,errorMsg,transTypeLabel;
@synthesize paymentTypeLabel,paymentTypeCell;
@synthesize dateCell,dateLabel,paidDate;
@synthesize paymentIcon,nameTitleLabel,amountTitleLabel,transTypeTitleLabel,paidTypeTitleLabel,dateTitleLabel,descTitleLabel,currencyLabel;
@synthesize seqCell,seqPeriodCell,seqPeriodTitleLabel,seqTitleLabel,sequenceLabel,sequenceSwitch;
@synthesize table,favoriteScroller;
@synthesize favoriteView,quickPaidView,pageControl,saveButton,favoriteBar,deleteFavButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self->sqlHandler = [[SQLHandler alloc] initWithDelegate:self];
        self->quickPaidObj = [[QuickPaidObject alloc] init];
        self->quickPaidObj.selectedTranTypeID = 0;
        self.paidDate = [NSDate date];
    }
    return self;
}

- (void)dealloc
{
    [self.seqPeriodCell release];
    [self.seqCell release];
    [self.seqPeriodTitleLabel release];
    [self.seqTitleLabel release];
    [self.sequenceLabel release];
    [self.sequenceSwitch release];
    [self.paymentIcon release];
    [self.currencyLabel release];
    [self.nameTitleLabel release];
    [self.amountTitleLabel release];
    [self.transTypeTitleLabel release];
    [self.paidTypeTitleLabel release];
    [self.dateTitleLabel release];
    [self.descTitleLabel release];
    [self.paidDate release];  
    [self.dateLabel release];
    [self.dateCell release];
    [self.paymentTypeCell release];
    [self.paymentTypeLabel release];
    [self.nameCell release];
    [self.amountCell release];
    [self.paidTypeCell release];
    [self.descCell release];
    [self.descTextView release];
    [self.amountField release];
    [self.nameField release];
    [self.transTypeLabel release];
    [self.errorMsg release];
    [self->quickPaidObj release];
    [self.table release];
    [self.favoriteScroller release];
    [self.quickPaidView release];
    [self.favoriteView release];
    [self.pageControl release];
    [self.saveButton release];
    [self.favoriteBar release];
    [self.deleteFavButton release];
    [super dealloc];
}

-(IBAction) onFavoriteChange:(id)sender
{
    self->isFavorite = YES;
    self->isFavoriteDeleteMode = NO;
    self.favoriteBar.hidden = YES;
    [self.deleteFavButton setHighlighted:NO];
    self.view = self.favoriteView;
    [self createFavoritePage];
    
    self.navigationItem.rightBarButtonItem = nil;
}
-(IBAction) onQuickPaidChange:(id)sender
{
    self.saveButton.hidden = YES;
    self->isFavorite = NO;
    self.view = self.quickPaidView;
    self.favoriteBar.hidden = YES;
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                               target:self 
                                               action:@selector(doneButtonClicked)]
                                              autorelease];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setLocalizedTitle];
    [self.favoriteScroller setContentSize:CGSizeMake(320*5,345 )];
    // Do any additional setup after loading the view from its nib.
    TransType* trans =[[SingletonData object].transTypeList objectAtIndex:self->quickPaidObj.selectedTranTypeID];
    self.transTypeLabel.text = trans.transTypename;
    [self updateDatePaid];
    PaymentType* payment =[[SingletonData object].paymentTypeList objectAtIndex:self->quickPaidObj.selectedPaymentTypeID];
    self.paymentTypeLabel.text = payment.paymentTypename;
    
    SequenceType* seqType = (SequenceType*)  [[SingletonData object].sequenceList objectAtIndex:self->quickPaidObj.selectedSeqTypeID];
    self.sequenceLabel.text = seqType.seqTypename; 
    
   if( [[[SingletonData object]favoriteList] count] > 0 )
   {
       [self onFavoriteChange:nil];
   }

    

}
-(void) setLocalizedTitle
{
    self.title = NSLocalizedString(@"MainMenu_QuickPaid",@"title" );
    self.nameTitleLabel.text = NSLocalizedString(@"QuickPaid_CellTitle_Name",@"name" );
    self.amountTitleLabel.text = NSLocalizedString(@"QuickPaid_CellTitle_Amount",@"name" );
    self.transTypeTitleLabel.text = NSLocalizedString(@"QuickPaid_CellTitle_PaymentType",@"name" );
    self.paidTypeTitleLabel.text = NSLocalizedString(@"QuickPaid_CellTitle_PaidType",@"name" );
    self.dateTitleLabel.text = NSLocalizedString(@"QuickPaid_CellTitle_Date",@"name" );
    self.descTitleLabel.text = NSLocalizedString(@"QuickPaid_CellTitle_Desc",@"name" );
    self.currencyLabel.text = [SingletonData object].currencyCode;

}
-(void)doneButtonClicked
{
    //making SQL request
    if([self IsValid ])
    {
        if(self.sequenceSwitch.on == YES)
        {
            Transaction* tran = [[Transaction alloc]initWithName:self.nameField.text withID:999 withAmount:[self.amountField.text intValue] withDate:[NSDate date] withTransTypeID:self->quickPaidObj.selectedTranTypeID withDesc:self.descTextView.text withPaymentType:self->quickPaidObj.selectedPaymentTypeID];
            SequenceTransaction* seq = [[SequenceTransaction alloc]initWithTrans:tran withType:self->quickPaidObj.selectedSeqTypeID];
            [[SingletonData object].sequenceTransList addObject:seq];
            [[SingletonData object] saveSeqTransList];
            [tran release];
            [seq release];
            if([self isMatchSequnce])
            {
                [self execTrans];
            }
            else
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }
        else
        {
             [self execTrans];
        }  
    }
    else
    {
        [self printErrorMessage:self.errorMsg];
    }
}
-(void) onSeqTypeSelected:(int) SeqId
{
    self->quickPaidObj.selectedSeqTypeID = SeqId;
    SequenceType* seqType = (SequenceType*)  [[SingletonData object].sequenceList objectAtIndex:SeqId];
    self.sequenceLabel.text = seqType.seqTypename; 
}
-(void)execTrans
{
    NSString* sql = [NSString stringWithFormat:@"INSERT into Trans(Account_id,Amount,trans_type_id,payment_type_id,trans_time,trans_name,trans_desc) VALUES(1,%@,%d,%d,'%@','%@','%@');",self.amountField.text,self->quickPaidObj.selectedTranTypeID,self->quickPaidObj.selectedPaymentTypeID,[self.paidDate getSqlite3CurrentTime],self.nameField.text,self.descTextView.text];
    [self->sqlHandler prepareSQL:sql withDB:@"Trans.DB"]; 
    [self->sqlHandler updateSQL];
}
-(BOOL) isMatchSequnce
{
    SequenceTypes seqType = self->quickPaidObj.selectedSeqTypeID;
    switch (seqType) {
        case EEveryday:
            return YES;
            break;
        case EWeekday:
            if([[NSDate date] isWeekDay])
            {
                 return YES;
            }
            break;
        case EWeekend:
            if([[NSDate date] isWeekEnd])
            {
                return YES;
            }
            break;
        case EFirstOfMonth :
            if([[NSDate date] isFirstOfMonth])
            {
                return YES;
            }
            break;
        case ELastOfMonth:
            if([[NSDate date] isEndOfMonth])
            {
                return YES;
            }
            break;
        default:
            break;
    }
            return NO;
}
-(IBAction) CommonpaidViewClicked
{
    SelectPaidNameViewController* view = [[SelectPaidNameViewController alloc] initWithNibName:@"SelectPaidNameViewController" bundle:nil withHandler:self];
    [self.navigationController pushViewController:view animated:YES];
    [view release];
}
-(void)onPaidNameUpdate:(NSString*) name
{
    self.nameField.text = name;
}
-(BOOL) IsValid
{
    if([self validateName] )
    {
        if([self validateAmount])
        {
            return YES;
        }
    }
    return NO;
}

-(BOOL)validateName
{
    if([[self.nameField text] length] >0)
    {
        return YES;
    }
    else
    {
        self.errorMsg = @"please fill payment name";
        return NO;
    }
}
-(BOOL)validateAmount
{
    if([self.amountField.text length] >0)
    {
        return YES;
    }
    else
    {
        self.errorMsg = @"please fill payment amount";
        return NO;
    }
}
-(void)onSQLUpdateComplete
{
     [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark TableView delegate

//return the UITableViewCell for each row of the searchView component
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch ([indexPath section]) {
		case 0:
            if([indexPath row]==0)
			{
                [self.nameCell setPosition:UACellBackgroundViewPositionTop];
				return self.nameCell;
			}
            else if([indexPath row]==1)
			{
                [self.amountCell setPosition:UACellBackgroundViewPositionMiddle];
				return	self.amountCell;
			}
			else if([indexPath row]==2)
			{
               
                [self.paidTypeCell setPosition:UACellBackgroundViewPositionMiddle];
				return self.paidTypeCell;
			}
            else if([indexPath row] == 3)
            {
                [self updatePaymentIcon];
                [self.paymentTypeCell setPosition:UACellBackgroundViewPositionMiddle];
                return  self.paymentTypeCell;
            }
            else if([indexPath row] == 4)
            {
                [self.dateCell setPosition:UACellBackgroundViewPositionMiddle];
                return  self.dateCell;
            }
            else if([indexPath row] == 5)
            {
                [self.seqCell setPosition:UACellBackgroundViewPositionMiddle];
                return  self.seqCell;
            }
			else {
                if([indexPath row] == 6)
                {
                    if(self.sequenceSwitch.on)
                    {
                        [self.seqPeriodCell setPosition:UACellBackgroundViewPositionBottom];
                        return self.seqPeriodCell ;
                    }
                    [self.descCell setPosition:UACellBackgroundViewPositionBottom];
                    return self.descCell ;
                }
                else
                {
                    [self.descCell setPosition:UACellBackgroundViewPositionBottom];
                    return self.descCell ;
                }
			}
		default:
			return nil;
	}
}
// return the height of each tableviewCell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if(self.sequenceSwitch.on)
    {
        if(indexPath.row == 7) return 200;
    }
    else
    {
         if(indexPath.row == 6) return 200;
    }
	return 44;
}
//return the section for the Searchview Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//we have 3 section for this view
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.sequenceSwitch.on)return 8;
	return 7;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hideKeyboard];
    if(indexPath.row  == 2)
    {
        PaidTypeViewController* paidView = [[PaidTypeViewController alloc] initWithNibName:@"PaidTypeViewController" bundle:nil withCallBack:self];
        [self.navigationController pushViewController:paidView animated:YES];
        [paidView release];
    }
    else if(indexPath.row  == 3)
    {

        UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Choose Paid type"
                                                  delegate:self cancelButtonTitle:@"Cancel"
                                                  destructiveButtonTitle:nil
                                                       otherButtonTitles:@"Cash",@"Credit Card",nil];
        
        popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [popupQuery showInView:self.view];
        [popupQuery release];
    }
    else if(indexPath.row  == 4)
    {   
        CustomDatePicker* picker = [[CustomDatePicker alloc] initWithDate:self.paidDate withDelegate:self withTitle:@"startDate" withTag:1];
        [picker show];
        [picker release];
    }
    else if(indexPath.row  == 6)
    {   
        if(self.sequenceSwitch.on)
        {
            SelectSeqTypeViewController* view = [[SelectSeqTypeViewController alloc] initWithNibName:@"SelectSeqTypeViewController" bundle:nil withCallBack:self];
            [self.navigationController pushViewController:view animated:YES];
            [view release];
        }
    }
}
-(void) updatePaymentIcon
{
    if( self->quickPaidObj.selectedPaymentTypeID ==0)
    {
        self.paymentIcon.image = [UIImage imageNamed:@"cash_48.png"];
    }
    else
    {
        self.paymentIcon.image = [UIImage imageNamed:@"credit card.png"];
    }

}
-(IBAction) DoneViewClicked:(id)sender
{
    [self hideKeyboard];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
	/*
	 sorting method call to business object
	 the sorting method depend on variable in 'HotelResult' Object
	 the list of sorting is shown here
	 */
    if(buttonIndex != 2)
    {
        self->quickPaidObj.selectedPaymentTypeID = buttonIndex;
        PaymentType* payment =[[SingletonData object].paymentTypeList objectAtIndex:self->quickPaidObj.selectedPaymentTypeID];
        self.paymentTypeLabel.text = payment.paymentTypename;
        [self updatePaymentIcon];
    }
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)onSQLComplete:(NSDictionary*)info
{
    
}
-(void)updateDatePaid
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MMM-yyyy"];
    self.dateLabel.text =  [dateFormatter stringFromDate:self.paidDate];
}
-(void) onTransTypeSelected:(int )transId
{
    self->quickPaidObj.selectedTranTypeID = transId;
    TransType* trans =[[SingletonData object].transTypeList objectAtIndex:self->quickPaidObj.selectedTranTypeID];
    self.transTypeLabel.text = trans.transTypename;
   

}
-(void) onPaymentTypeSelected:(int) paymentId
{
    self->quickPaidObj.selectedPaymentTypeID = paymentId;
    PaymentType* payment =[[SingletonData object].paymentTypeList objectAtIndex:self->quickPaidObj.selectedPaymentTypeID];
    self.paymentTypeLabel.text = payment.paymentTypename;
   
}


#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{	
    if(scrollView == self.favoriteScroller)
    {
        CGFloat pageWidth = favoriteScroller.frame.size.width;
        int page = floor((favoriteScroller.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.pageControl.currentPage = page;
    }
    else
    {
        [self hideKeyboard];
    }
}
-(void) hideKeyboard
{
    //hide searchBar keyboard when user scrolling tableview
	if([self.nameField isFirstResponder])
	{
		[self.nameField resignFirstResponder];
	}
    
    //hide searchBar keyboard when user scrolling tableview
	if([self.amountField isFirstResponder])
	{
		[self.amountField resignFirstResponder];
	}
    
    //hide searchBar keyboard when user scrolling tableview
	if([self.descTextView isFirstResponder])
	{
		[self.descTextView resignFirstResponder];
	}
}

#pragma mark view adjust
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self setViewMovedUp];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self setViewBackUp];
}
-(void)setViewMovedUp
{	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5]; // if you want to slide up the view
	CGRect rect = self.view.frame;
	rect.origin.y -= 150;
	rect.size.height += 150;
	self.view.frame = rect;
	
	[UIView commitAnimations];
	
}
-(void)setViewBackUp
{
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5]; // if you want to slide up the view
	
    CGRect rect = self.view.frame;
	rect.origin.y += 150;
	rect.size.height -= 150;
	
    self.view.frame = rect;
    [UIView commitAnimations];
}
-(void) onDatePickerUpdate:(NSDate*)selectDate withTag:(int) calltag
{
    if(calltag == 1)
    {
        self.paidDate = selectDate;
        [self updateDatePaid];
    }
}
-(IBAction) onSeqSwitchChanged:(id)sender
{
    [self.table reloadData];
}


#pragma mark createFavorite 
-(void) createFavoritePage
{
    for (UIView *subview in favoriteScroller.subviews) {
        [subview removeFromSuperview];
    }
    
    
    for(int i = 0 ; i < [[[SingletonData object]favoriteList] count] ; i ++ )
    {
		FavoriteView* favViewTemplate =  [[FavoriteView alloc] initWithFrame: CGRectMake((i/3)*130+20*(i/3 +1 )+(i/6)*20, (i%3)*100 +(i%3+1)*10 , 130, 100) withTransaction:[[[SingletonData object]favoriteList] objectAtIndex:i]];//[nibObjects objectAtIndex:0];
        //favViewTemplate.backgroundColor = [UIColor blueColor];
        [self.favoriteScroller addSubview:favViewTemplate];

    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [self.nameField resignFirstResponder];
        [self.amountField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}
 
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	
    if(!self->isFavorite) return;
	for (UITouch *myTouch in touches)
	{
		if (myTouch.phase == UITouchPhaseBegan) {
			// new touch handler
		}
		if (myTouch.phase == UITouchPhaseMoved) {
			// touch moved handler
		}
		if (myTouch.phase == UITouchPhaseEnded) {
			// touch end handler
		}
		//[myTouch locationInView]
		CGPoint touchLocation = [myTouch locationInView:self.view];
        
		
        for(int i = 0 ; i <  6; i ++ )
        {
				CGRect rect = CGRectMake((i/3)*130+20*(i/3 +1 ), (i%3)*100 +(i%3+1)*10 , 130, 100) ;
			             
            if(CGRectContainsPoint(rect,touchLocation))
            {
                int index = 6*(pageControl.currentPage ) + i ;
                if(index < [[[SingletonData object]favoriteList] count])
                {
                    self->currentFavIndex = index;
                    if(!self->isFavoriteDeleteMode)
                    {
                        [self onFavoriteSelected:[[[SingletonData object]favoriteList] objectAtIndex:index]];
                    }
                    else
                    {
                        [self onFavoriteDeleted:index];
                    }
                }
            }
        }
    }
}
-(void) onFavoriteDeleted:(int)index
{
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.5];
    [[[SingletonData object]favoriteList] removeObjectAtIndex:index];
    [[SingletonData object] saveFavList];
    
    [self createFavoritePage];
    [UIView commitAnimations];
    
}
-(void) onFavoriteSelected:(Transaction *)selectedTrans
{
    self.nameField.text = selectedTrans.name;
    self.amountField.text = [NSString stringWithFormat:@"%d",selectedTrans.amount];
    self.paidDate = [NSDate date];
    [self updateDatePaid];
   
    self->quickPaidObj.selectedTranTypeID = selectedTrans.transTypeID;
    TransType* trans =[[SingletonData object].transTypeList objectAtIndex:self->quickPaidObj.selectedTranTypeID];
    self.transTypeLabel.text = trans.transTypename;
    
    self->quickPaidObj.selectedPaymentTypeID = selectedTrans.paymentType;
    PaymentType* payment =[[SingletonData object].paymentTypeList objectAtIndex:self->quickPaidObj.selectedPaymentTypeID];
    self.paymentTypeLabel.text = payment.paymentTypename;
    
    self.view = self.quickPaidView;
    self->isFavorite = NO;
    
    self.saveButton.hidden = NO;
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                               target:self 
                                               action:@selector(doneButtonClicked)]
                                              autorelease];
}

#pragma mark Button event
-(void) onSavedFavorite:(id)sender
{
    if([self IsValid])
    {
     Transaction* trans = [[[SingletonData object]favoriteList] objectAtIndex:self->currentFavIndex];
        trans.name = self.nameField.text;
        trans.amount = [self.amountField.text intValue] ;
        trans.transTypeID = self->quickPaidObj.selectedTranTypeID;
        trans.description = self.descTextView.text ;
        trans.paymentType = self->quickPaidObj.selectedPaymentTypeID;
        [[SingletonData object] saveFavList];

        self.saveButton.hidden = YES;
    }
    else
    {
         [self printErrorMessage:@"please complete information before save"];
    }
}
-(IBAction) onDeleteFavActive:(id)sender
{
    if(!self->isFavoriteDeleteMode)
    {
        //active button state
        [self performSelector:@selector(doHighlight:) withObject:sender afterDelay:0];
        //show panel
        self.favoriteBar.hidden = NO;
    }
    else
    {
        //deactive button state
        
        //hide panel
        self.favoriteBar.hidden = YES;
    }
    

    
    self->isFavoriteDeleteMode = !self->isFavoriteDeleteMode;
}
- (void)doHighlight:(UIButton*)b {
    [b setHighlighted:YES];
}
-(void) onAddFavorite:(id)sender
{
    if([self IsValid ])
    {
    
        Transaction* tran = [[Transaction alloc]initWithName:self.nameField.text withID:888 withAmount:[self.amountField.text intValue] withDate:[NSDate date] withTransTypeID:self->quickPaidObj.selectedTranTypeID withDesc:self.descTextView.text withPaymentType:self->quickPaidObj.selectedPaymentTypeID];
        
        [[SingletonData object].favoriteList addObject:tran];
        [[SingletonData object] saveFavList];
        
        [self printErrorMessage:@"favorite is added"];
    }

}
@end

