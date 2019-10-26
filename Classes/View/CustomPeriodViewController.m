//
//  CustomPeriodViewController.m
//  MoneyMe
//
//  Created by Tong on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomPeriodViewController.h"
#import "SingletonData.h"


@implementation CustomPeriodViewController
@synthesize startButton,endButton;
- (void)dealloc
{
    [self.startButton release];
    [self.endButton release];
    [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
     [self setUpButtonTitle];
}

-(void) setUpButtonTitle
{
    SingletonData* data = [SingletonData object];
    Period* period = (Period*) [data.periodTypeList objectAtIndex:3];
    
    NSDateFormatter* dateFormat = [[[NSDateFormatter alloc]init]autorelease];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    [self.startButton setTitle:[dateFormat stringFromDate:period.startDate] forState:UIControlStateNormal];
     [self.endButton setTitle:[dateFormat stringFromDate:period.endDate] forState:UIControlStateNormal];
}

-(IBAction) startDateClicked:(id)sender
{
    SingletonData* data = [SingletonData object];
    Period* period = (Period*) [data.periodTypeList objectAtIndex:3];
    CustomDatePicker* picker = [[CustomDatePicker alloc] initWithDate:period.startDate withDelegate:self withTitle:@"startDate" withTag:1];
    [picker show];
    [picker release];
}
-(IBAction) endDateClicked:(id)sender
{
    SingletonData* data = [SingletonData object];
    Period* period = (Period*) [data.periodTypeList objectAtIndex:3];
    CustomDatePicker* picker = [[CustomDatePicker alloc] initWithDate:period.endDate withDelegate:self withTitle:@"startDate" withTag:2];
    [picker show];
    [picker release];
}
-(void) onDatePickerUpdate:(NSDate*)selectDate withTag:(int) calltag
{
    if(calltag == 1)
    {
        SingletonData* data = [SingletonData object];
        Period* period = (Period*) [data.periodTypeList objectAtIndex:3];
        period.startDate = selectDate;
    }
    else
    {
        SingletonData* data = [SingletonData object];
        Period* period = (Period*) [data.periodTypeList objectAtIndex:3];
        period.endDate = selectDate;
    }
    [self setUpButtonTitle];
}

@end
