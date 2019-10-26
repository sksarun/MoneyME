//
//  CoreGraphProvider.m
//  MoneyMe
//
//  Created by ศรัณย์ กฤษณะโลม on 10/23/54 BE.
//  Copyright (c) 2554 Agoda.co.ltd. All rights reserved.
//

#import "CoreGraphProvider.h"
#import  "SingletonData.h"
#import "EGODatabase.h"
#import "NSDate+Component.h"
#import "NSDate+Calculate.h"
#import "ECGraphPoint.h"
#import "ECGraphItem.h"

@implementation CoreGraphProvider
@synthesize  dailyGraph,monthlyGraph,weeklyGraph,period,periodList,delegate;

-(id) init
{
    self= [super init];
    if(self)
    {
        self->sqlHandler = [[SQLHandler alloc]initWithDelegate:self];
        self->dailyGraph = [[NSMutableArray alloc] init];
         self->weeklyGraph = [[NSMutableArray alloc] init];
         self->monthlyGraph = [[NSMutableArray alloc] init];
        self.period = Weekly;
        self.periodList = [[NSMutableArray alloc] init];
        [self.periodList addObject:[[SingletonData object].periodTypeList objectAtIndex:0]];
        [self.periodList addObject:[[SingletonData object].periodTypeList objectAtIndex:1]];
        [self.periodList addObject:[[SingletonData object].periodTypeList objectAtIndex:2]];        
        [self loadTransSQL];
    }
    return self;
}
-(void)dealloc
{
    [self->sqlHandler release];
    [super dealloc];
}

-(void) loadTransSQL
{
     NSString* sql = @"";
    if(typeindex == 0 ) // daily
    {
       sql =  [NSString stringWithFormat:@"SELECT Sum(Amount) as Amount from Trans where Trans.trans_time >= '%@ 00:00:00' and Trans.trans_time <= '%@ 00:00:00'",[[[NSDate date]lastDay:index ] toString],[[[NSDate date]lastDay:index ] nextDateString]] ;    
    }
    else if(typeindex == 1 ) // weekly
    {
        sql =  [NSString stringWithFormat:@"SELECT Sum(Amount) as Amount from Trans where Trans.trans_time >= '%@ 00:00:00' and Trans.trans_time <= '%@ 00:00:00'",[[[NSDate date]firstDayWeekWithPrevWeek:index ] toString],[[[NSDate date]lastDayWeekWithPrevWeek:index ] toString]] ;            
    }
    else
    {
        sql =  [NSString stringWithFormat:@"SELECT Sum(Amount) as Amount from Trans where Trans.trans_time >= '%@ 00:00:00' and Trans.trans_time <= '%@ 00:00:00'",[[[NSDate date]firstDayMonthWithPrevMonth:index ] toString],[[[NSDate date]lastDayMonthWithPrevMonth:index ] toString]] ;  
    }
    [self->sqlHandler prepareSQL:sql withDB:@"Trans.DB"]; 
    [self->sqlHandler executeSQL];
    
}
-(void) relocateList
{
    NSMutableArray* tempList = [[[NSMutableArray alloc]init] autorelease];
    for(int i =  [self.dailyGraph count]-1 ; i >=0 ; i --)
    {
        [tempList addObject:[self.dailyGraph objectAtIndex:i]];
    }
    
    NSMutableArray* tempListweek = [[[NSMutableArray alloc]init] autorelease];
    for(int i =  [self.weeklyGraph count]-1 ; i >=0 ; i --)
    {
        [tempListweek addObject:[self.weeklyGraph objectAtIndex:i]];
    }
    
    NSMutableArray* tempListmonth = [[[NSMutableArray alloc]init] autorelease];
    for(int i =  [self.monthlyGraph count]-1 ; i >=0 ; i --)
    {
        [tempListmonth addObject:[self.monthlyGraph objectAtIndex:i]];
    }
    self.dailyGraph = tempList;
    self.weeklyGraph = tempListweek;
    self.monthlyGraph = tempListmonth;
}
-(void)onSQLComplete:(NSDictionary*)info
{
    EGODatabaseResult* result = [info objectForKey:@"resultList"];
    [result retain];
    // add place object from result.
    for(EGODatabaseRow* row in result) 
    {   
        int amount = [row intForColumn:@"Amount"];
        NSString* periodString = @"";
        if(typeindex == 0 ) // daily
        {
            periodString =  [NSString stringWithFormat:@"%@",[[[NSDate date] lastDay:index] toShortString]];
        }
        else if(typeindex == 1 ) // weekly
        {
             periodString =  [NSString stringWithFormat:@"%@-%@",[[[NSDate date]firstDayWeekWithPrevWeek:index ] toShortString],[[[NSDate date]lastDayWeekWithPrevWeek:index ] toShortString]];               
        }
        else
        {
             periodString =  [NSString stringWithFormat:@"%@-%@",[[[NSDate date]firstDayMonthWithPrevMonth:index ] toShortString],[[[NSDate date]lastDayMonthWithPrevMonth:index ] toShortString]];      
        }
        
       	ECGraphItem *item = [[[ECGraphItem alloc] init] autorelease];
        item.isPercentage = YES;
        item.yValue = amount;
        item.width = 30;
        item.name = periodString;
        item.color = [UIColor colorWithRed:156.0/255.0 green:172.0/255.0 blue:192.0/255.0 alpha:1.0];
        
        if(typeindex == 0 ) // daily
        {
            [self.dailyGraph addObject:item];
        }
        else if(typeindex == 1 ) // weekly
        {
            [self.weeklyGraph addObject:item];
        }
        else
        {
            [self.monthlyGraph addObject:item];
        }
    }
    [result release];
    
    if([self shouldLoopNextRound])
    {
        [self loadTransSQL];
    }
    else
    {
        // complete callback delegate to draw graph.
        if(delegate)
        {
            [self relocateList];
            [self.delegate onPrepareComplete];
        }
    }
}
-(BOOL)shouldLoopNextRound
{
    if(typeindex == 0 ) // daily
    {
        if(index == 6 )
        {
            typeindex = 1;
            index = 0 ; 
        }
        else
        {
            index++;
        }
        return  YES;
    }
    else if(typeindex == 1 ) // weekly
    {
        if(index == 5 )
        {
            typeindex = 2;
            index = 0 ; 
        }
        else
        {
            index++;
        }
        return  YES;             
    }
    else
    {
        if(index == 5 )
        {
            index =0;
            typeindex = 0;
            return NO;
        }    
        else
        {
            index++;
            return  YES;  
        }
    }
}
-(void)onSQLUpdateComplete
{
    
}
-(void)createPaymentStatistic
{
    [self.dailyGraph removeAllObjects];
    [self.weeklyGraph  removeAllObjects];
    [self.monthlyGraph removeAllObjects];
    [self loadTransSQL];
}


@end
