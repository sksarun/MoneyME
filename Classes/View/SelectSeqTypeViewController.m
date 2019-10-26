//
//  SelectSeqTypeViewController.m
//  MoneyMe
//
//  Created by Tong on 9/3/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "SelectSeqTypeViewController.h"
#import "SingletonData.h"

@implementation SelectSeqTypeViewController
@synthesize table;

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCallBack:(id<ISeqTypeHandler>)_handler;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self->handler = _handler;
    }
    return self;
}
-(void) dealloc
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
    [super viewDidLoad];
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
    SequenceType * type = (SequenceType *) [[SingletonData object].sequenceList objectAtIndex:indexPath.row];
	cell.textLabel.text = type.seqTypename;
    return cell;
	
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self->handler onSeqTypeSelected:indexPath.row];
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
	return [[SingletonData object].sequenceList  count];
}


@end
