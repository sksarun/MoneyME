//
//  FilterViewController.m
//  MoneyMe
//
//  Created by Tong on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FilterViewController.h"
#import "PaidTypeViewController.h"
#import "PaymentTypeViewController.h"
#import "SingletonData.h"
#import "PeriodViewController.h"
#import "FilterNameViewController.h"


@implementation FilterViewController
@synthesize tempCell,table;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withFilterList:(NSMutableArray*)_filterList withCallback:(id<IFilterHandler>)_handler;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self->filterList = _filterList;
        [self->filterList retain];
        self->handler = _handler;
    }
    return self;
}

- (void)dealloc
{
    [table release];
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
    self.title = @"Filter";
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                               target:self 
                                               action:@selector(onCancelFilter:)]
                                              autorelease];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                               target:self 
                                               action:@selector(onDoneFilter:)]
                                              autorelease];
}

-(void)onDoneFilter:(id)sender
{
    for(int i = 0 ; i <  self->filterList.count; i++)
    {
        NSIndexPath* indxPath = [NSIndexPath indexPathForRow:i inSection:0];
        FilterCell* cell = (FilterCell*) [self.table cellForRowAtIndexPath:indxPath];
        Filter* filter = [self->filterList objectAtIndex:indxPath.row];
        filter.IsSelected = cell.filterSwitch.on;
        
    }
    [self->handler onFilterUpdate:self->filterList];
    [self dismissModalViewControllerAnimated:YES];
}
-(IBAction) onSwitchFilter:(id)sender
{
    /*
    FilterCell* cell = (FilterCell*)[[sender superview] superview];
     NSIndexPath* path =[self.table indexPathForCell:cell];
    
    Filter* filter = [self->filterList objectAtIndex:path.row];
    filter.IsSelected = cell.filterSwitch.on;
     */
    
}
-(void) onCancelFilter:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
#pragma mark TableView delegate

//return the UITableViewCell for each row of the searchView component
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"filterCellId";
	static NSString *CellNib = @"FilterCell";
    
    FilterCell* cell = (FilterCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
		cell = self.tempCell;
		self.tempCell = nil;
	}
    Filter* filter = [self->filterList objectAtIndex:indexPath.row];
    [cell setupFilterCell:filter];
    
    return cell;
}
// return the height of each tableviewCell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 90;
}
//return the section for the Searchview Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//we have 3 section for this view
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self->filterList count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    switch (indexPath.row) {
        case 0:
        {
            PaidTypeViewController* paidView = [[PaidTypeViewController alloc] initWithNibName:@"PaidTypeViewController" bundle:nil withCallBack:self];
            [self.navigationController pushViewController:paidView animated:YES];
            [paidView release];
        
            break;
        }
        case 1:
        {
            PeriodViewController* periodView = [[PeriodViewController alloc]initWithNibName:@"PeriodViewController" bundle:nil withCallBack:self];
            [self.navigationController pushViewController:periodView animated:YES];
            break;
        }
        case 2:
        {
            PaymentTypeViewController* paidView = [[PaymentTypeViewController alloc] initWithNibName:@"PaymentTypeViewController" bundle:nil withCallBack:self];
            [self.navigationController pushViewController:paidView animated:YES];
            [paidView release];
            break;
        }
        case 3:
        {
            FilterNameViewController* filterNameView = [[FilterNameViewController alloc] initWithNibName:@"FilterNameViewController" bundle:nil withCallBack:self];
            [self.navigationController pushViewController:filterNameView animated:YES];
            [filterNameView release];
            break;
        }
        default:
            break;
    }
}

-(void) onTransTypeSelected:(int )transId
{
    TransType* trans =[[SingletonData object].transTypeList objectAtIndex:transId];
    Filter* filter = [self->filterList objectAtIndex:0];
    [filter updateFiterValue:trans];
    [table reloadData];
}
-(void) onPaymentTypeSelected:(int) paymentId
{
    PaymentType* payment =[[SingletonData object].paymentTypeList objectAtIndex:paymentId];
    Filter* filter = [self->filterList objectAtIndex:2];
    [filter updateFiterValue:payment];
    [table reloadData];
}
-(void)onPaidNameUpdate:(NSString*) name
{
    Filter* filter = [self->filterList objectAtIndex:3];
    [filter updateFiterValue:name];
    [table reloadData];
}
-(void) onPeriodTypeSelect:(int)periodIndex{
    Period* period = [[SingletonData object].periodTypeList objectAtIndex:periodIndex];
    Filter* filter = [self->filterList objectAtIndex:1];
    [filter updateFiterValue:period];
    [table reloadData];
}
@end
