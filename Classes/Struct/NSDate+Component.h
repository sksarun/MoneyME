//
//  NSDate+Component.h
//  MoneyMe
//
//  Created by Tong on 5/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (NSDate_Component)
-(NSString*)getSqlite3FirstHourTime;
-(NSString*)getSqlite3CurrentTime;
-(NSString*) nextDateString;
-(NSString*) toString;
-(NSString*) toShortString;

-(NSString*) lastDayMonthString;
-(NSString*) firstDayMonthString;

-(NSDate*) firstDayMonth;
-(NSDate*) firstDayMonthWithPrevMonth:(int)month;
-(NSDate*) lastDayMonthWithPrevMonth:(int)month;
-(NSDate*)lastDayWeekWithPrevWeek:(int)week;
-(NSDate*)firstDayWeekWithPrevWeek:(int)week;
-(NSDate*) lastDayMonth;

-(NSDate*) firstDayInWeek;
-(NSDate*) lastDayInWeek;
-(BOOL) isSameDate:(NSDate*)date;
-(NSDate*) lastDay:(int)days;
-(NSDate*) nextDay:(int)days;

-(BOOL) isWeekDay;
-(BOOL) isWeekEnd;
-(BOOL) isFirstOfMonth;
-(BOOL) isEndOfMonth;
@end
