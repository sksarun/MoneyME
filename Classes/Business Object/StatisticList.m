//
//  StatisticList.m
//  MoneyMe
//
//  Created by Tong on 8/17/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "StatisticList.h"
#import "EGODatabase.h"
#import "Transaction.h"
#import "NSString+Component.h"
#import "Period.h"
#import "PaymentStatistic.h"
#import "SingletonData.h"
#import "PaidTypeStatistic.h"

@implementation StatisticList

@synthesize transactionList,displayList,period,statisticType;
@synthesize periodList;
-(id) init
{
    self= [super init];
    if(self)
    {
        self->sqlHandler = [[SQLHandler alloc]initWithDelegate:self];
        self.transactionList = [[NSMutableArray alloc] init];
        self.displayList = [[NSMutableArray alloc] init];
        self.period = Daily;
        self.statisticType = StatisticPayment;
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
    [self.transactionList release];
    [self.displayList release];
    [self->sqlHandler release];
    [self.periodList release];
    [super dealloc];
}

-(void) loadTransSQL
{
    NSString* sql = [NSString stringWithFormat:@"SELECT * from Trans order by trans_time desc"];
    [self->sqlHandler prepareSQL:sql withDB:@"Trans.DB"]; 
    [self->sqlHandler executeSQL];
    
}
-(void)onSQLComplete:(NSDictionary*)info
{
    EGODatabaseResult* result = [info objectForKey:@"resultList"];
    [result retain];
    [self.transactionList removeAllObjects];
    // add place object from result.
    for(EGODatabaseRow* row in result) 
    {   
        Transaction* transaction = [[Transaction alloc] initWithName:[row stringForColumn:@"trans_name"] withID:[row intForColumn:@"Trans_id"] withAmount:[row intForColumn:@"Amount"] withDate:[[row stringForColumn:@"trans_time"]sqlite3Date] withTransTypeID:[row intForColumn:@"trans_type_id"] withDesc:[row stringForColumn:@"trans_desc"] withPaymentType:[row intForColumn:@"payment_type_id"]];
        [self.transactionList addObject:transaction];
        
        [transaction release];
    }
    [result release];
    
    
    [self createPaymentStatistic];
}
-(void)onSQLUpdateComplete
{
    
}
-(void)createPaymentStatistic
{
    [self.displayList removeAllObjects];
    NSArray* list = [self transForPeriod:[self.periodList objectAtIndex:period]];
    if(self.statisticType == StatisticPayment)
    {
        for(Transaction* tran in list)
        {
            if(![self IsExistID:tran.transTypeID])
            {
                [self.displayList addObject:[[[PaymentStatistic alloc]initWithType:tran.transTypeID withTotalAmount:[self getTotalPaymentForId:tran.transTypeID withList:list] withPercent:[self getPercentForId:tran.transTypeID withList:list] ]autorelease]];
            }
        }
    }
    else
    {
        for(Transaction* tran in list)
        {
            if(![self IsExistID:tran.paymentType])
            {
                [self.displayList addObject:[[[PaidTypeStatistic alloc]initWithType:tran.paymentType withTotalAmount:[self getTotalPaymentForId:tran.paymentType withList:list] withPercent:[self getPercentForId:tran.paymentType withList:list] ]autorelease]];
            }
        }
    }
}
-(NSString*)getPeriodString
{
    Period* currentPeriod = [self->periodList objectAtIndex:period];
    return [currentPeriod periodToString];
}
-(bool) IsExistID:(int)typeID;
{
    if(self.statisticType == StatisticPayment)
    {
        for(PaymentStatistic* payment in self.displayList)
        {
            if(payment.transType == typeID)
            {
                return YES;
            }
        }
    }
    else
    {
        for(PaidTypeStatistic* paid in self.displayList)
        {
            if(paid.paidType == typeID)
            {
                return YES;
            }
        }
    }
    return NO;
}

-(int) getPercentForId:(int) typeID withList:(NSArray*) list
{
    double divide = (double)[self getTotalPaymentForId:typeID withList:list]/(double)  [self getTotalPayment:list];
    return divide*100;
}
-(int) getTotalPayment:(NSArray*)list
{
    int totalamount = 0;
    for(Transaction* tran in list)
    {
        totalamount += tran.amount;
    }
    return totalamount;
}
-(int) getTotalPaymentForId:(int)typeID withList:(NSArray*)list
{
    int totalamount = 0;
    for(Transaction* tran in list)
    {
        if(self.statisticType == StatisticPayment)
        {
            if(tran.transTypeID == typeID)
            {
                totalamount += tran.amount;
            }
        }
        else
        {
            if(tran.paymentType == typeID)
            {
                totalamount += tran.amount;
            }
        }
    }
    return totalamount;
}
-(void) nextPeriod
{
    Period* currentPeriod = [self->periodList objectAtIndex:period];
    if(self.period == Daily)
    {
        [currentPeriod moveNextDay];
    }
    else if(period == Weekly)
    {
        [currentPeriod moveNextWeek];
    }
    else
    {
        [currentPeriod moveNextMonth];
    }
}
-(void) prevPeriod
{
    Period* currentPeriod = [self->periodList objectAtIndex:period];
    if(self.period == Daily)
    {
        [currentPeriod movePrevDay];
    }
    else if(period == Weekly)
    {
        [currentPeriod movePrevWeek];
    }
    else
    {
        [currentPeriod movePrevMonth];
    }
}
-(NSArray*) transForPeriod:(Period*)periodget
{
    NSMutableArray* datalist = [[NSMutableArray alloc] init];
    for(Transaction* transaction in self.transactionList )
    {
        if([periodget isInPeriod:transaction.date])
        {
            [datalist addObject:transaction];
        }
        
    }
    return [datalist autorelease];
}
@end
