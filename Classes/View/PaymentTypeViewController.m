//
//  PaymentTypeViewController.m
//  MoneyMe
//
//  Created by Tong on 6/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PaymentTypeViewController.h"
#import "SingletonData.h"


@implementation PaymentTypeViewController
@synthesize table;

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCallBack:(id<IPaymentTypeHandler>)_handler;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self->handler = _handler;
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [self.table release];
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
    self.navigationController.title = NSLocalizedString(@"QuickPaid_CellTitle_PaymentType", @"title");
    // Do any additional setup after loading the view from its nib.
}

#pragma mark TableView delegate

//return the UITableViewCell for each row of the searchView component
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"paidCell"]; 
    if (cell == nil) { 
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"paidCell"] autorelease];
    } 
    
    PaymentType* payment =   [[SingletonData object].paymentTypeList objectAtIndex:indexPath.row];
	cell.textLabel.text = payment.paymentTypename;
    return cell;
	
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self->handler onPaymentTypeSelected:indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
}
//return the section for the Searchview Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//we have 3 section for this view
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[SingletonData object].paymentTypeList  count];
}

@end
