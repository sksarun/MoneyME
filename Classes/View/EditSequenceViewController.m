//
//  EditSequenceViewController.m
//  MoneyMe
//
//  Created by Tong on 9/6/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "EditSequenceViewController.h"
#import "SingletonData.h"
#import "SequenceTransaction.h"

@implementation EditSequenceViewController


#pragma mark - View lifecycle
-(id)initWithNibName:(NSString *)nibNameOrNil withIndex:(int)index bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        self->sequnceIndex   = index;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Sequnce";
    // Do any additional setup after loading the view from its nib.
}

#pragma mark TableView delegate

//return the UITableViewCell for each row of the searchView component
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"sequenceCell"]; 
    if (cell == nil) { 
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sequenceCell"] autorelease];
    } 
    SequenceType* seq = (SequenceType*)[[SingletonData object].sequenceList objectAtIndex:indexPath.row];
    SequenceTransaction* seqTrans = [[SingletonData object].sequenceTransList objectAtIndex:self->sequnceIndex];
	cell.textLabel.text = seq.seqTypename;
    if(seq.seqTypeId == seqTrans.seqType)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
	
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SequenceType* seq = (SequenceType*)[[SingletonData object].sequenceList objectAtIndex:indexPath.row];
    ((SequenceTransaction*)[[SingletonData object].sequenceTransList objectAtIndex:self->sequnceIndex]).seqType = seq.seqTypeId;
    [[SingletonData object]saveSeqTransList];
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
