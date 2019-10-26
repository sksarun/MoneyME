//
//  FilterNameViewController.m
//  MoneyMe
//
//  Created by Tong on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FilterNameViewController.h"
#import "SingletonData.h"

@implementation FilterNameViewController
@synthesize nameText;
-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCallBack:(id<IPaidNameHandler>)_handler
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self->handler = _handler;
    }
    return self;
}

- (void)dealloc
{
    [self.nameText release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                               target:self 
                                               action:@selector(doneButtonClicked)]
                                              autorelease];
}

-(void) doneButtonClicked
{
    [self->handler onPaidNameUpdate:self.nameText.text];
    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark TableView delegate

//return the UITableViewCell for each row of the searchView component
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"paidNameCell"]; 
    if (cell == nil) { 
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"paidNameCell"] autorelease];
    } 
    
    cell.textLabel.text =   [[SingletonData object].commonPaidName objectAtIndex:indexPath.row];
    return cell;
	
}
// return the height of each tableviewCell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 44;
}
//return the section for the Searchview Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[SingletonData object].commonPaidName count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.nameText.text = [[SingletonData object].commonPaidName objectAtIndex:indexPath.row]; 
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [self.nameText resignFirstResponder];
    }
}
#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{	
	[self hideKeyboard];
}
-(void) hideKeyboard
{
    //hide searchBar keyboard when user scrolling tableview
	if([self.nameText isFirstResponder])
	{
		[self.nameText resignFirstResponder];
	}
}
@end
