//
//  CurrencyViewController.m
//  MoneyMe
//
//  Created by Tong on 7/26/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "CurrencyViewController.h"
#import "SingletonData.h"

@implementation CurrencyViewController


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Currency";
    // Do any additional setup after loading the view from its nib.
}

#pragma mark TableView delegate

//return the UITableViewCell for each row of the searchView component
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"currencyCell"]; 
    if (cell == nil) { 
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"currencyCell"] autorelease];
    } 
    
	cell.textLabel.text = (NSString*)[[SingletonData object].currencyList objectAtIndex:indexPath.row];
    if([(NSString*)[[SingletonData object].currencyList objectAtIndex:indexPath.row] isEqualToString:[SingletonData object].currencyCode])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
	
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SingletonData object].currencyCode = (NSString*)[[SingletonData object].currencyList objectAtIndex:indexPath.row];  
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
	return [[SingletonData object].currencyList  count];
}


@end
