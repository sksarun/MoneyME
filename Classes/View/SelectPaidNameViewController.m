//
//  SelectPaidNameViewController.m
//  MoneyMe
//
//  Created by Tong on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SelectPaidNameViewController.h"
#import "SingletonData.h"
#import "UIViewController+Extension.h"

@implementation SelectPaidNameViewController
@synthesize table,nameText,addButton,textLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withHandler:(id<IPaidNameHandler>)_handler;
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
    [self.nameText release];
    [self.addButton release];
    [self.textLabel release];
    [self.table release];
    [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setLocalizedText];
    // Do any additional setup after loading the view from its nib.
}
-(void) setLocalizedText;
{
    self.title = NSLocalizedString(@"QuickName_Title", @"common name");
    self.textLabel.text = NSLocalizedString(@"QuickName_CreateTitle", @"create common name title");
    [self.addButton setTitle:NSLocalizedString(@"QuickName_ButtonAdd", @"Add common") forState:UIControlStateNormal];

}
-(IBAction) addPaidName
{
    if([self.nameText.text length] >0)
    {
        [[SingletonData object].commonPaidName addObject:self.nameText.text];
        self.nameText.text = @"";
        [[SingletonData object] savePaidNameList];
        [self.table reloadData];
    }
    else
    {
         [self printErrorMessage:@"Please fill payment name"];
    }
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
    [self->handler onPaidNameUpdate:[[SingletonData object].commonPaidName objectAtIndex:indexPath.row]]; 
    [self.navigationController popViewControllerAnimated:YES];
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
