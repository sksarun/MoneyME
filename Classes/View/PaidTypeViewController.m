//
//  PaidTypeViewController.m
//  MoneyMe
//
//  Created by Tong on 5/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PaidTypeViewController.h"
#import "SingletonData.h"
#import "TransType.h"
#import "CreatePaidTypeViewController.h"

@implementation PaidTypeViewController
@synthesize table;

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCallBack:(id<ITransTypeHandler>)_handler
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self->handler = _handler;
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
    self.navigationItem.title = NSLocalizedString(@"QuickPaid_CellTitle_PaymentType", @"title");
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                               target:self 
                                               action:@selector(doneButtonClicked)]
                                              autorelease];
    // Do any additional setup after loading the view from its nib.
}
-(void) viewWillAppear:(BOOL)animated
{
    if(self.table !=nil)
    {
        [self.table reloadData];
    }
}
-(void)doneButtonClicked
{
    CreatePaidTypeViewController* createview = [[CreatePaidTypeViewController alloc] initWithNibName:@"CreatePaidTypeViewController" bundle:nil];
    [self presentModalViewController:createview animated:YES];
    [createview release];
}

#pragma mark TableView delegate

//return the UITableViewCell for each row of the searchView component
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"paidCell"]; 
    if (cell == nil) { 
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"paidCell"] autorelease];
    } 

    TransType* tran =   [[SingletonData object].transTypeList objectAtIndex:indexPath.row];
	cell.textLabel.text = tran.transTypename;
    return cell;
	
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self->handler onTransTypeSelected:indexPath.row];
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
	return [[SingletonData object].transTypeList  count];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
