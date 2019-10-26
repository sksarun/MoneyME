//
//  MainViewController.m
//  MoneyMe
//
//  Created by Tong on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "QuickPaidViewController.h"
#import "TransListViewController.h"
#import "EGODatabase.h"
#import "SingletonData.h"
#import "NSDate+Component.h"
#import "OptionViewController.h"
#import "DisplayBoardViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation MainViewController
@synthesize userLabel,landScapeView,portraitView,dailyGraphView,weeklyGraphView,monthlyGraphView;
@synthesize quickPaidButton,optionButton,statisticButton,transactionButton,displayBoardView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userLabel.text = @"Payment Spotlight";
    self->sqlHandler = [[SQLHandler alloc]initWithDelegate:self];
    self->coreGraphProvider = [[CoreGraphProvider alloc] init];
    self->coreGraphProvider.delegate = self;
    [self createShadow];
    
    [ self->coreGraphProvider createPaymentStatistic];
}
-(void) onPrepareComplete
{
    [self.dailyGraphView updateObject:self->coreGraphProvider.dailyGraph];
    [self.weeklyGraphView updateObject:self->coreGraphProvider.weeklyGraph];
    [self.monthlyGraphView updateObject:self->coreGraphProvider.monthlyGraph];
}
-(void) createShadow
{
    self.quickPaidButton.layer.masksToBounds = NO;
    self.quickPaidButton.layer.shadowOffset = CGSizeMake(5, 5);
    self.quickPaidButton.layer.shadowRadius = 3;
    self.quickPaidButton.layer.shadowOpacity = 0.5;
    self.quickPaidButton.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.quickPaidButton.bounds].CGPath;
    
    self.transactionButton.layer.masksToBounds = NO;
    self.transactionButton.layer.shadowOffset = CGSizeMake(5, 5);
    self.transactionButton.layer.shadowRadius = 3;
    self.transactionButton.layer.shadowOpacity = 0.5;
    self.transactionButton.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.transactionButton.bounds].CGPath;
    
    self.statisticButton.layer.masksToBounds = NO;
    self.statisticButton.layer.shadowOffset = CGSizeMake(5, 5);
    self.statisticButton.layer.shadowRadius = 3;
    self.statisticButton.layer.shadowOpacity = 0.5;
    self.statisticButton.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.statisticButton.bounds].CGPath;
    
    self.optionButton.layer.masksToBounds = NO;
    self.optionButton.layer.shadowOffset = CGSizeMake(5, 5);
    self.optionButton.layer.shadowRadius = 3;
    self.optionButton.layer.shadowOpacity = 0.5;
    self.optionButton.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.optionButton.bounds].CGPath;
}
-(void) viewWillAppear:(BOOL)animated
{
    if(self->sqlHandler != nil)
    {
        [self loadStatisticData];
    }
    
    self->counter = 0;
}
-(void) loadStatisticData
{
    for (UIView *subview in self.displayBoardView.subviews) {
        [subview removeFromSuperview];
    }
    for(DisplayBoard* dpBoard in [SingletonData object].displayBoardList)
    {
        if(dpBoard.isSelected)
        {
            [self->sqlHandler prepareSQL:dpBoard.sqlCommand withDB:@"Trans.DB"]; 
            [self->sqlHandler executeSQL]; 
        }
    }
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return YES;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if(UIInterfaceOrientationPortrait == toInterfaceOrientation || UIInterfaceOrientationPortraitUpsideDown == toInterfaceOrientation)
    {
        self.view = self.portraitView;
    }
    else
    {
        self.view = self.landScapeView;
        [ self->coreGraphProvider createPaymentStatistic];
    }
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(IBAction)quickpaidClicked:(id)sender
{
    QuickPaidViewController* view = [[QuickPaidViewController alloc]initWithNibName:@"QuickPaidViewController" bundle:nil];
    [self.navigationController pushViewController:view animated:YES];
    [view release];
}
-(IBAction)transactionClicked:(id)sender
{
    TransListViewController* view = [[TransListViewController alloc]initWithNibName:@"TransListViewController" bundle:nil];
    [self.navigationController pushViewController:view animated:YES];
    [view release];
}
-(IBAction)statisticClicked:(id)sender
{
    StatisticViewController* view = [[StatisticViewController alloc]initWithNibName:@"StatisticViewController" bundle:nil];
    [self.navigationController pushViewController:view animated:YES];
    [view release];
}
-(IBAction)optionClicked:(id)sender
{
    OptionViewController* view = [[OptionViewController alloc]initWithNibName:@"OptionViewController" bundle:nil];
    [self.navigationController pushViewController:view animated:YES];
    [view release];
}
#pragma mark dealloc
- (void)dealloc {
    [self->sqlHandler release];
    [self.userLabel release];
    
    [self.quickPaidButton release];
    [self.transactionButton release];
    [self.statisticButton release];
    [self.optionButton release];

    [self.dailyGraphView release];
    [self.weeklyGraphView release];
    [self.monthlyGraphView release];
    [self.displayBoardView release];
    [self.portraitView release];
    [self.landScapeView release];

    [super dealloc];
}
-(void)onSQLComplete:(NSDictionary*)info
{
    EGODatabaseResult* result = [info objectForKey:@"resultList"];
    [result retain];
    int Amount ;
    // add place object from result.
    for(EGODatabaseRow* row in result) 
    {   
       Amount =[row intForColumn:@"Amount"];
    }
    [result release];    
    
    for(DisplayBoard* dpBoard in [SingletonData object].displayBoardList)
    {
        if([dpBoard.sqlCommand isEqualToString:[info objectForKey:@"SQL"] ])
        {
            DisplayBoardItemView* item = [[DisplayBoardItemView alloc] initWithFrame:CGRectMake(0, 30+30*counter, 300, 40) withIndex:counter withName:dpBoard.displayName withAmount:Amount];
            item.delegate = self;
            [self.displayBoardView addSubview:item];
            [item release];
            self->counter++;
            break;
        }
    }
    
}
-(void)onSQLUpdateComplete
{
    
}
-(IBAction)pressBoard:(id)sender
{
    DisplayBoardViewController* dpView = [[DisplayBoardViewController alloc] initWithNibName:@"DisplayBoardViewController" bundle:nil];
    [self.navigationController pushViewController:dpView animated:YES];
    [dpView release];
     
}
-(void)onDisplayBoardSelected:(int)index
{   
    int check = 0;
    int runIndex = 0;
    for(DisplayBoard* dpBoard in [SingletonData object].displayBoardList)
    {
        if(dpBoard.isSelected)
        {
            if(check == index)
            {
                DisplayBoard* displayItem = [[[SingletonData object]displayBoardList] objectAtIndex:runIndex];
                //NSLog([NSString stringWithFormat:@"date = %d, %@",index,displayItem.sqlRequestCommand ]);
                       
                TransListViewController* view = [[TransListViewController alloc]initWithNibName:@"TransListViewController"withSQLRequest:displayItem.sqlRequestCommand  bundle:nil];
                [self.navigationController pushViewController:view animated:YES];
                [view release]; 
            }
            check++;
        }
        runIndex++;
        
    }
 
}
@end
