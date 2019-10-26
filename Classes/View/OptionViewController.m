//
//  OptionViewController.m
//  MoneyMe
//
//  Created by Tong on 7/27/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "OptionViewController.h"
#import "CurrencyViewController.h"
#import "SingletonData.h"
#import "SequenceTransViewController.h"
#import "EditAccountViewController.h"
#import "DisplayBoardViewController.h"

@implementation OptionViewController
@synthesize currencyCell,displayBoardCell,aboutCell,accountCell;

@synthesize currencyLabel;
@synthesize currencyTitle,displayBoardTitle,aboutTitle,accountTitle;
@synthesize table;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Option";
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillAppear:(BOOL)animated
{
    
    if(self.table  != nil)
    {
        [self.table  reloadData];  
    }
}

-(void) dealloc
{
    [self.currencyLabel release];
    [self.currencyTitle release];
    [self.displayBoardTitle release];
    [self.aboutCell release];
    [self.aboutTitle release];
    [self.accountTitle release];
    [self.displayBoardCell release];
    [self.accountCell release];
    [self.currencyCell release];
    [self.table release];
    [super dealloc];
}
#pragma mark TableView


//return the UITableViewCell for each row of the searchView component
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    switch (indexPath.row) {
        case 0:
            self.currencyLabel.text = [SingletonData object].currencyCode;
            self.currencyCell.textLabel.text = @"Currency";
            self.currencyCell.textLabel.backgroundColor = [UIColor clearColor];
             [self.currencyCell setPosition:UACellBackgroundViewPositionTop];
            return self.currencyCell;
        case 1:
            self.displayBoardCell.textLabel.text = @"DisplayBoard";
             [self.displayBoardCell setPosition:UACellBackgroundViewPositionMiddle];
            self.displayBoardCell.textLabel.backgroundColor = [UIColor clearColor];
            return self.displayBoardCell;
        case 2:
            self.aboutCell.textLabel.text = @"Sequence Transaction";
             [self.aboutCell setPosition:UACellBackgroundViewPositionMiddle];
            self.aboutCell.textLabel.backgroundColor = [UIColor clearColor];
            return self.aboutCell;
        case 3:
            self.accountCell.textLabel.text = @"User account";
             [self.accountCell setPosition:UACellBackgroundViewPositionBottom];
            self.accountCell.textLabel.backgroundColor = [UIColor clearColor];
            return self.accountCell;
        default:
            return nil;
    }
	
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            CurrencyViewController* currency = [[CurrencyViewController alloc]initWithNibName:@"CurrencyViewController" bundle:nil];
            [self.navigationController pushViewController:currency animated:YES];
            [currency release];
            break;
        }
        case 1:
        {
            DisplayBoardViewController* boardView = [[DisplayBoardViewController alloc]initWithNibName:@"DisplayBoardViewController" bundle:nil];
            [self.navigationController pushViewController:boardView animated:YES];
            [boardView release];
            break;
        }
        case 2:
        {
            SequenceTransViewController* seqView = [[SequenceTransViewController alloc]initWithNibName:@"SequenceTransViewController" bundle:nil];
            [self.navigationController pushViewController:seqView animated:YES];
            [seqView release];
            break;
        }
        case 3:
        {
            EditAccountViewController  * accView = [[EditAccountViewController alloc]initWithNibName:@"EditAccountViewController" bundle:nil];
            [self.navigationController pushViewController:accView animated:YES];
            [accView release];
            break;
        }
        default:
            break;
    }
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
@end
