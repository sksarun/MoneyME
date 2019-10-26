//
//  TransactionList.m
//  MoneyMe
//
//  Created by Tong on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TransactionList.h"
#import "Filter.h"
#import "SingletonData.h"
#import "Transaction.h"


@implementation TransactionList
@synthesize transactionList,filterList,displayList;

-(id) init
{
    self= [super init];
    if(self)
    {
        
        self.transactionList = [[NSMutableArray alloc] init];
        self.displayList = [[NSMutableArray alloc] init];
        [self createFilterList];
    }
    return self;
}
-(void)dealloc
{
    [self.transactionList release];
    [self.displayList release];
    [self.filterList release];
    [super dealloc];
}
#pragma mark Sorting method
-(void) sortByKey:(NSString*)key isAscending:(BOOL)ascending
{
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:key
                                                      ascending:ascending] autorelease];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        NSArray *sortList = nil;
        

        sortList = [[self->displayList sortedArrayUsingDescriptors:sortDescriptors] retain];
        
        
        [self->displayList release];
        self->displayList = [NSMutableArray arrayWithArray:sortList];
        [self->displayList retain];
        
        [sortList release];
        
    

}
-(void) doSort
{
    switch ([SingletonData object].sortType) {
        case EDate:
            [self sortByKey:@"date" isAscending:NO];
            break;
        case EPriceAscending:
            [self sortByKey:@"amount" isAscending:YES];
            break;
        case EPriceDescending:
            [self sortByKey:@"amount" isAscending:NO];
            break;
        case EName:
            [self sortByKey:@"name" isAscending:YES];
            break;
        default:
            break;
    }
}
/// create function
-(void) createFilterList
{
    //Singleton object
    SingletonData* singleton = [SingletonData object];
    
    self.filterList = [[NSMutableArray alloc]init];
    
    //Create Filter data
    Filter* transTypeFilter =  [[Filter alloc] initFilter:0 withFilterTypeName:@"paid type" withFilterObject:[singleton.transTypeList objectAtIndex:0]];
    
    //Period* period = [[Period alloc] initPeriod:0 withPeriodName:@"Today"]; 
    Filter* periodFilter =  [[Filter alloc] initFilter:1 withFilterTypeName:@"period" withFilterObject:[singleton.periodTypeList objectAtIndex:0]];
    
    Filter* paymentTypeFilter =  [[Filter alloc] initFilter:2 withFilterTypeName:@"payment type" withFilterObject:[singleton.paymentTypeList objectAtIndex:0]];
    Filter* transNameFilter =  [[Filter alloc] initFilter:3 withFilterTypeName:@"transaction name" withFilterObject:@""];
    
    [ self.filterList addObject:transTypeFilter];
    [ self.filterList addObject:periodFilter];
    [ self.filterList addObject:paymentTypeFilter];
    [ self.filterList addObject:transNameFilter];
    [transTypeFilter release];
    [periodFilter release];
    [paymentTypeFilter release];
    [transNameFilter release];
    
}

-(void) applyFilter
{
    self.displayList = self.transactionList;
    for(Filter* filter in self.filterList)
    {
        if(filter.IsSelected)
        {
           self.displayList = [filter performFilter:self.displayList];
        }
    }
}
@end
