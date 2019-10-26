//
//  StatisticViewController.m
//  MoneyMe
//
//  Created by Tong on 7/31/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "StatisticViewController.h"
#import "EGODatabase.h"
#import "Transaction.h"
#import <QuartzCore/QuartzCore.h>

@implementation StatisticViewController
@synthesize tempCell,headerCell,periodBar;
@synthesize titleLabel,periodLabel,column1Label,column2Label,column3Label,statisticTable;
@synthesize prevButton,nextButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self->statisticList = [[StatisticList alloc] init]; 
    }
    return self;
}

-(void)dealloc
{
    [self.prevButton release];
    [self.nextButton release];
    [self.headerCell release];
    [self->statisticList release];
    [self->titleLabel release];
    [self->periodLabel release];
    [self->column1Label release];
    [self->column2Label release];
    [self->column3Label release];
    [self->statisticTable release];
    [super dealloc];
}

//return the UITableViewCell for each row of the searchView component
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if(indexPath.row == 0 ) 
    {
        [headerCell setPosition:UACellBackgroundViewPositionSingle];
        return self.headerCell;    
    }
    */
    static NSString *CellIdentifier = @"StatisticCellId";
	static NSString *CellNib = @"StatisticCell";
    
    StatisticCell* cell = (StatisticCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
		cell = self.tempCell;
		self.tempCell = nil;
	}
    
    [cell setCell:[self->statisticList.displayList objectAtIndex:indexPath.row]];
    return cell;
}
// return the height of each tableviewCell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if(indexPath.row == 0) return  75;
	return 55;
}
//return the section for the Searchview Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//we have 3 section for this view
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self->statisticList.displayList count];
}

#pragma mark - View lifecycle
-(IBAction)hasChangedContent:(id)sender
{
    UISegmentedControl* control = (UISegmentedControl*)sender;
    self->statisticList.statisticType = control.selectedSegmentIndex;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.statisticTable cache:YES];
    [UIView commitAnimations];
    [self reConstructStatistic];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set Shadow for sort button and filter button
    self.nextButton.layer.shadowOffset = CGSizeMake(2, 2);
    self.nextButton.layer.shadowRadius = 3;
    self.nextButton.layer.shadowOpacity = 0.5;
    
    self.prevButton.layer.shadowOffset = CGSizeMake(2, 2);
    self.prevButton.layer.shadowRadius = 3;
    self.prevButton.layer.shadowOpacity = 0.5;
    
    self.title = @"Statistic";
    self.periodBar.selectedItem =  [self.periodBar.items objectAtIndex:self->statisticList.period];
    self.periodLabel.text = [self->statisticList getPeriodString];
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    self->statisticList.period = item.tag;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.statisticTable cache:YES];
    [UIView commitAnimations];
    [self reConstructStatistic];
}
-(IBAction)nextClicked:(id)sender
{
    [self->statisticList nextPeriod];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.statisticTable cache:YES];
    [UIView commitAnimations];
    [self reConstructStatistic];
}
-(IBAction)prevClicked:(id)sender
{
     [self->statisticList prevPeriod];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.statisticTable cache:YES];
    [UIView commitAnimations];
    [self reConstructStatistic];
}

-(void) reConstructStatistic
{
    [self->statisticList createPaymentStatistic];
    self.periodLabel.text = [self->statisticList getPeriodString];
    [self.statisticTable reloadData];
}


@end
