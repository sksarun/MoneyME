//
//  SequenceTransViewController.m
//  MoneyMe
//
//  Created by Tong on 9/5/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "SequenceTransViewController.h"
#import "SequenceTransaction.h"
#import "SingletonData.h"
#import "EditSequenceViewController.h"

@implementation SequenceTransViewController
@synthesize tempCell,table ;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Sequence";

}
-(void)viewWillAppear:(BOOL)animated
{
    if(self.table)
    {
        [self.table reloadData];
    }
}
-(void) dealloc
{
    [self.table release];
    [super dealloc];
}
#pragma mark TableView delegate

//return the UITableViewCell for each row of the searchView component
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"seqTransId";
	static NSString *CellNib = @"SeqTransCell";
    
    SeqTransCell* cell = (SeqTransCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
		cell = self.tempCell;
		self.tempCell = nil;
	}
    SequenceTransaction* transaction = (SequenceTransaction*) [[SingletonData object].sequenceTransList  objectAtIndex:indexPath.row];
    [cell setCell:transaction];
    [cell setPosition:UACellBackgroundViewPositionMiddle];
    
    return cell;
}
// return the height of each tableviewCell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 165;
}
//return the section for the Searchview Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//we have 3 section for this view
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[SingletonData object].sequenceTransList count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditSequenceViewController* editView = [[EditSequenceViewController alloc]initWithNibName:@"EditSequenceViewController" withIndex:indexPath.row bundle:nil];
    [self.navigationController pushViewController:editView  animated:YES];
    [editView release];
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
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 1)
    {
        
        if(self->deleteIndex != -1)
        {
            [[SingletonData object].sequenceTransList removeObjectAtIndex:self->deleteIndex];
            [[SingletonData object] saveSeqTransList];
            self->deleteIndex = -1;
            [self.table reloadData];
        }
    }
}
@end
