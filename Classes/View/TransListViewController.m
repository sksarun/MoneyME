//
//  TransListViewController.m
//  MoneyMe
//
//  Created by Tong on 5/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TransListViewController.h"
#import "EGODatabase.h"
#import "NSString+Component.h"
#import "EditTransactionViewController.h"
#import "Filter.h"
#import "FilterViewController.h"
#import "SingletonData.h"
#import "Period.h"
#import "PaymentType.h"
#import "SortViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation TransListViewController
@synthesize tempCell,table;
@synthesize sortButton,filterButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self->sqlHandler = [[SQLHandler alloc]initWithDelegate:self];
        self->trans = [[TransactionList alloc] init];
        self->deleteIndex = -1;
    }
    return self;
}

-(id)initWithNibName:(NSString *)nibNameOrNil withSQLRequest:(NSString*)sql bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self->sqlHandler = [[SQLHandler alloc]initWithDelegate:self];
        self->trans = [[TransactionList alloc] init];
        self->deleteIndex = -1;
        
        self->sqlRequest = [sql retain] ;
        
    }
    return self;
}

- (void)dealloc
{
    [self->sqlHandler release];
    if(self->sqlRequest) [self->sqlRequest release];
    [self.table release];
    [self.sortButton release];
    [self.filterButton release];
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
    self.title = @"Transaction";
    
    //set Shadow for sort button and filter button
    self.filterButton.layer.shadowOffset = CGSizeMake(2, 2);
    self.filterButton.layer.shadowRadius = 3;
    self.filterButton.layer.shadowOpacity = 0.5;
    
    self.sortButton.layer.shadowOffset = CGSizeMake(2, 2);
    self.sortButton.layer.shadowRadius = 3;
    self.sortButton.layer.shadowOpacity = 0.5;
    [self loadTransSQL];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    if(self.table != nil)
    {
        [self->trans doSort];
        [self.table reloadData];
    }
}
#pragma mark TableView delegate

//return the UITableViewCell for each row of the searchView component
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TransCellId";
	static NSString *CellNib = @"TransCell";
    
    TransCell* cell = (TransCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
		cell = self.tempCell;
		self.tempCell = nil;
	}
    Transaction* transaction = [self->trans.displayList objectAtIndex:indexPath.row];
    [cell setCell:transaction];
    [cell setPosition:UACellBackgroundViewPositionMiddle];
    
    return cell;
}
// return the height of each tableviewCell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 135;
}
//return the section for the Searchview Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//we have 3 section for this view
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self->trans.displayList count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditTransactionViewController * edView =[[EditTransactionViewController alloc] initWithNibName:@"EditTransactionViewController" bundle:nil withTran:[self->trans.displayList objectAtIndex:indexPath.row] withCallback:self];
    [self.navigationController pushViewController:edView animated:YES];
    [edView release];
}
-(void) onTranEdit
{
    [self loadTransSQL];
}
-(void) loadTransSQL
{
    NSString* sql = self->sqlRequest?self->sqlRequest:[NSString stringWithFormat:@"SELECT * from Trans order by trans_time desc"];

    [self->sqlHandler prepareSQL:sql withDB:@"Trans.DB"]; 
    [self->sqlHandler executeSQL];
    
}
-(void)onSQLComplete:(NSDictionary*)info
{
    EGODatabaseResult* result = [info objectForKey:@"resultList"];
    [result retain];
    [self->trans.transactionList removeAllObjects];
    // add place object from result.
    for(EGODatabaseRow* row in result) 
    {   
        if([result.rows count] == 1 && [row intForColumn:@"Amount"] == 0)
        {
            
        
        }
        else
        {
            Transaction* transaction = [[Transaction alloc] initWithName:[row stringForColumn:@"trans_name"] withID:[row intForColumn:@"Trans_id"] withAmount:[row intForColumn:@"Amount"] withDate:[[row stringForColumn:@"trans_time"]sqlite3Date] withTransTypeID:[row intForColumn:@"trans_type_id"] withDesc:[row stringForColumn:@"trans_desc"] withPaymentType:[row intForColumn:@"payment_type_id"]];
            [self->trans.transactionList addObject:transaction];
            [transaction release];
        }
        
        
    }
    [result release];
    self->trans.displayList = self->trans.transactionList ;
    [self->trans doSort];
    [self->trans applyFilter];
    [self.table reloadData];
}
-(void)onSQLUpdateComplete
{
  

}
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 1)
    {
        
        if(self->deleteIndex != -1)
        {
            NSString* sql = [NSString stringWithFormat:@"DELETE from Trans WHERE Trans_id = %d",[[self->trans.displayList objectAtIndex:self->deleteIndex]transID]];
            [self->sqlHandler prepareSQL:sql withDB:@"Trans.DB"]; 
            [self->sqlHandler updateSQL];
        
            [self loadTransSQL];
            self->deleteIndex = -1;
        }
    }
}

-(IBAction) onDeleteTransClicked:(id)sender
{
    BaseTableViewCell* cell = (BaseTableViewCell*)[[sender superview] superview] ;
    NSIndexPath* path =[self.table indexPathForCell:cell];
    self->deleteIndex = path.row;
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Are you sure to delete this item (cannot undo)" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
    [alert release];
  
}
-(IBAction) onFilterClicked:(id)sender
{
    
    FilterViewController* filterView = [[FilterViewController alloc] initWithNibName:@"FilterViewController" bundle:nil withFilterList:self->trans.filterList withCallback:self];
    UINavigationController *navController = [[UINavigationController alloc ]initWithRootViewController:filterView];
     [navController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentModalViewController:navController  animated:YES];
    [filterView release];
    [navController release];
}
-(IBAction) onSortClicked:(id)sender
{
    SortViewController* sortView = [[SortViewController alloc]initWithNibName:@"SortViewController" bundle:nil];
    [sortView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentModalViewController:sortView  animated:YES];
    [sortView release];
}
-(void) onFilterUpdate:(NSMutableArray*)_filters
{
    self->trans.filterList = _filters;
    [self->trans applyFilter];

}
@end
