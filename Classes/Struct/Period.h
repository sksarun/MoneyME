//
//  Period.h
//  MoneyMe
//
//  Created by Tong on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Period : NSObject {
    
    NSDate* startDate;
    NSDate* endDate;
    int periodID;
    NSString* periodName;
}
@property (nonatomic,retain) NSDate* startDate;
@property (nonatomic,retain) NSDate* endDate;
@property (nonatomic,readonly) int periodID;
@property (nonatomic,readonly) NSString* periodName;

-(id)initPeriod:(int)_periodID withPeriodName:(NSString*)periodName withStartDate:(NSDate*)start withEndDate:(NSDate*)end;

-(void) setupWeekly;
-(void) setupMonthly;
-(BOOL) isInPeriod:(NSDate*) date;
-(BOOL) isSameDate:(NSDate*)date1 withDate:(NSDate*)date2;

-(void) moveNextDay;
-(void) movePrevDay;
-(void) moveNextWeek;
-(void) movePrevWeek;
-(void) moveNextMonth;
-(void) movePrevMonth;

-(NSString*) periodToString;
@end
