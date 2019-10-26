//
//  StatisticList.h
//  MoneyMe
//
//  Created by Tong on 8/17/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLHandler.h"
#import "Period.h"

typedef enum PeriodType {
	Daily=0,Weekly,Monthly
} PeriodType;
typedef enum StatisticType{
    StatisticPaid=0,   
    StatisticPayment=1
}StatisticType;
@interface StatisticList : NSObject<ISQLUpdate>
{
    //All transaction in database
    NSMutableArray* transactionList;
    // display list
    NSMutableArray* displayList;
    //sql connector
    SQLHandler* sqlHandler;
    //period display
    PeriodType period;
    StatisticType statisticType;
    NSMutableArray* periodList;
    
}
@property (nonatomic,retain) NSMutableArray* transactionList;
@property (nonatomic,retain) NSMutableArray* displayList;
@property (nonatomic,assign) PeriodType period;
@property (nonatomic,retain) NSMutableArray* periodList;
@property (nonatomic,assign) StatisticType statisticType;

-(bool) IsExistID:(int)typeID;
-(void) loadTransSQL;
-(void) createPaymentStatistic;
-(NSArray*) transForPeriod:(Period*)periodget;

-(int) getTotalPayment:(NSArray*)list;
-(int) getTotalPaymentForId:(int)typeID withList:(NSArray*)list;
-(int) getPercentForId:(int) typeID withList:(NSArray*) list;
-(NSString*)getPeriodString;

-(void) nextPeriod;
-(void) prevPeriod;
@end
