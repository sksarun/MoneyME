//
//  SortViewController.m
//  MoneyMe
//
//  Created by Tong on 7/24/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "SortViewController.h"
#import "SingletonData.h"

@implementation SortViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Sort";
    
    self->sortArray = [[NSArray alloc] initWithObjects:@"Date",@"Price (Low - High)",@"Price (Hight - Low)",@"Name", nil];
}

-(IBAction)cancelClicked:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
-(void) dealloc
{
    [self->sortArray release];
    [super dealloc];
}
#pragma mark TableView delegate

//return the UITableViewCell for each row of the searchView component
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"paidCell"]; 
    if (cell == nil) { 
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"paidCell"] autorelease];
    } 
    
    if([SingletonData object].sortType == indexPath.row)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text  = [self->sortArray objectAtIndex:indexPath.row];
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
	return [self->sortArray count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SingletonData object].sortType = indexPath.row;
     [self dismissModalViewControllerAnimated:YES];
}

@end
