//
//  CreateViewController.m
//  MoneyMe
//
//  Created by Tong on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CreateViewController.h"
#import "MoneyMeAppDelegate.h"
#import "User.h"
#import "SingletonData.h"

@implementation CreateViewController
@synthesize avatarCell,nameCell,nicknameCell,salaryCell,salaryTypeCell,genderCell;
@synthesize nameField,nicknameField,genderSwitch,salaryField;

#pragma mark  viewLoad
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Edit Button
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                               target:self 
                                               action:@selector(doneButtonClicked)]
                                              autorelease];
}

-(void)doneButtonClicked
{
    // create username
    SingletonData* single = [SingletonData object];
    single.user = [[[User alloc] initWithName:self.nameField.text withNickName:self.nicknameField.text withSalary:[self.salaryField.text intValue] withSalaryType:EMonthly withGender:genderSwitch.selectedSegmentIndex]autorelease];
    [single saveUser];
    
    MoneyMeAppDelegate* app = (MoneyMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [app switchToMainView];
    
}
#pragma mark TableView delegate

//return the UITableViewCell for each row of the searchView component
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch ([indexPath section]) {
		case 0:
            if([indexPath row]==0)
			{
                [self.nameCell setPosition:UACellBackgroundViewPositionTop];
				return self.nameCell;
			}
			else if([indexPath row]==1)
			{
                [self.nicknameCell setPosition:UACellBackgroundViewPositionMiddle];
				return	self.nicknameCell;
			}
			else if([indexPath row]==2)
			{
                [self.salaryCell setPosition:UACellBackgroundViewPositionMiddle];
				return self.salaryCell;
			}
			else {
                [self.genderCell setPosition:UACellBackgroundViewPositionBottom];
				return self.genderCell ;
			}
		default:
			return nil;
	}
}
// return the height of each tableviewCell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 44;
}
//return the section for the Searchview Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//we have 3 section for this view
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 4;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
#pragma mark memory management

- (void)dealloc {
	[self.avatarCell release];
	[self.nameCell release];
	[self.nicknameCell release];
	[self.salaryCell release];
	[self.salaryTypeCell release];
	[self.genderCell release];
    
    [self.nameField release];
    [self.salaryField release];
    [self.nicknameField release];
    [self.genderSwitch release];
    [super dealloc];
}


@end
