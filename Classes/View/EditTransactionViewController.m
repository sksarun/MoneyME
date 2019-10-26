//
//  QuickPaidViewController.m
//  MoneyMe
//
//  Created by Tong on 5/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EditTransactionViewController.h"
#import "PaidTypeViewController.h"
#import "NSDate+Component.h"
#import "UIViewController+Extension.h"
#import "SingletonData.h"
#import "SelectPaidNameViewController.h"
#import "NSDate+Calculate.h"

@implementation EditTransactionViewController
@synthesize nameCell,amountCell,paidTypeCell,descCell;
@synthesize descTextView,amountField,nameField,errorMsg,transTypeLabel;
@synthesize dateLabel,dateCell;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withTran:(Transaction*)_trans withCallback:(id<ITranEditUpdate>)_handler;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self->sqlHandler = [[SQLHandler alloc] initWithDelegate:self];
        self->trans = [[Transaction alloc] initWithName:_trans.name withID:_trans.transID  withAmount:_trans.amount withDate:_trans.date withTransTypeID:_trans.transTypeID withDesc:_trans.description withPaymentType:_trans.paymentType];
        self->handler = _handler;
    }
    return self;
}

- (void)dealloc
{
    [self.dateLabel release];
    [self.dateCell release];
    [self.nameCell release];
    [self.amountCell release];
    [self.paidTypeCell release];
    [self.descCell release];
    [self.descTextView release];
    [self.amountField release];
    [self.nameField release];
    [self.transTypeLabel release];
    [self.errorMsg release];
    [self->trans release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Edit Transaction";
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                               target:self 
                                               action:@selector(doneButtonClicked)]
                                              autorelease];
    
    
    // Do any additional setup after loading the view from its nib.
    TransType* tran =[[SingletonData object].transTypeList objectAtIndex:self->trans.transTypeID];
    self.transTypeLabel.text = tran.transTypename;
    self.nameField.text = self->trans.name;
    self.amountField.text = [NSString stringWithFormat:@"%d",self->trans.amount];
    self.descTextView.text = self->trans.description;
    [self updateDatePaid];
}

-(void)doneButtonClicked
{
    //making SQL request
    if([self IsValid ])
    {

        
        NSString* sql = [NSString stringWithFormat:@"UPDATE Trans SET Amount = %@, trans_type_id= %d,trans_name = '%@',trans_desc = '%@', trans_time = '%@' WHERE trans_id = %d"
                         ,self.amountField.text,self->trans.transTypeID,self.nameField.text,self.descTextView.text,[self->trans.date getSqlite3CurrentTime],self->trans.transID];
        [self->sqlHandler prepareSQL:sql withDB:@"Trans.DB"]; 
        [self->sqlHandler updateSQL];
         
        [self->handler onTranEdit];
    }
    else
    {
        [self printErrorMessage:self.errorMsg];
    }
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
            else if([indexPath row]==3)
            {
                [self.dateCell setPosition:UACellBackgroundViewPositionMiddle];
                return  self.dateCell;
            }
			else {
                [self.descCell setPosition:UACellBackgroundViewPositionBottom];
				return self.descCell ;
			}
		default:
			return nil;
	}
}
// return the height of each tableviewCell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.row == 4) return 200;
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
	return 5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row  == 2)
    {
        PaidTypeViewController* paidView = [[PaidTypeViewController alloc] initWithNibName:@"PaidTypeViewController" bundle:nil withCallBack:self];
        [self.navigationController pushViewController:paidView animated:YES];
        [paidView release];
    }
    else if(indexPath.row == 3)
    {
        CustomDatePicker* picker = [[CustomDatePicker alloc] initWithDate:self->trans.date withDelegate:self withTitle:@"startDate" withTag:1];
        [picker show];
        [picker release];
        
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


-(void) onDatePickerUpdate:(NSDate*)selectDate withTag:(int) calltag
{
    if(calltag == 1)
    {
        self->trans.date = selectDate;
        [self updateDatePaid];
    }
}
-(void)updateDatePaid
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MMM-yyyy"];
    self.dateLabel.text =  [dateFormatter stringFromDate:self->trans.date];
}
-(void) onTransTypeSelected:(int )transId
{
    self->trans.transTypeID = transId;
    TransType* tran =[[SingletonData object].transTypeList objectAtIndex: self->trans.transTypeID];
    self.transTypeLabel.text = tran.transTypename;
    
}
@end
