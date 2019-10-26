//
//  PeriodViewController.m
//  MoneyMe
//
//  Created by Tong on 6/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PeriodViewController.h"
#import "SingletonData.h"
#import "CustomPeriodViewController.h"

@implementation PeriodViewController
@synthesize table;

- (void)dealloc
{
    [self.table release];
    [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
											   initWithTitle:@"Custom"
											   style:UIBarButtonItemStyleBordered	
											   target:self 
											   action:@selector(customClicked)] autorelease];

}

-(void) customClicked
{
    CustomPeriodViewController* customPeriod = [[CustomPeriodViewController alloc] initWithNibName:@"CustomPeriodViewController" bundle:nil];
    [self.navigationController pushViewController:customPeriod animated:YES];
    [customPeriod release];
}
-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCallBack:(id<IPeriodTypeHandler>)_handler
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        self->handler = _handler ;
    
    }
    return self;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[SingletonData object].periodTypeList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    Period* periodSelect = [[SingletonData object].periodTypeList objectAtIndex:indexPath.row];
    cell.textLabel.text = periodSelect.periodName;
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self->handler onPeriodTypeSelect:indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
