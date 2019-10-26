//
//  NSDate+Component.m
//  MoneyMe
//
//  Created by Tong on 5/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSDate+Component.h"


@implementation NSDate (NSDate_Component)

-(NSString*)getSqlite3CurrentTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    formatter.locale = usLocale;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //this is the sqlite's format
    return [formatter stringFromDate:self];
}

-(NSString*)getSqlite3FirstHourTime
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit fromDate:self]; 
    [comps setHour:0];
    NSDate *tDateMonth = [calendar dateFromComponents:comps];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    formatter.locale = usLocale;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //this is the sqlite's format
    return [formatter stringFromDate:tDateMonth];
}

// get the specify future date from specific date
-(NSString*) nextDateString
{
    // now build a NSDate object for the next day
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *offsetComponents = [[[NSDateComponents alloc] init] autorelease];
    [offsetComponents setDay:1];
	
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    formatter.locale = usLocale;
    [formatter setDateFormat:@"yyyy-MM-dd"]; //this is the sqlite's format
    return [formatter stringFromDate:[gregorian dateByAddingComponents:offsetComponents toDate: self options:0]];
}
// get the specify future date from specific date
-(NSString*) toString
{	
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    formatter.locale = usLocale;
    [formatter setDateFormat:@"yyyy-MM-dd"]; //this is the sqlite's format
    //NSLog([NSString stringWithFormat:@"date = %@",[formatter stringFromDate:self]]);
    return [formatter stringFromDate:self];
}
-(NSString*) toShortString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    formatter.locale = usLocale;
    [formatter setDateFormat:@"dd/MM"]; //this is the sqlite's format
    //NSLog([NSString stringWithFormat:@"date = %@",[formatter stringFromDate:self]]);
    return [formatter stringFromDate:self];
}
-(NSString*) lastDayMonthString
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
     calendar.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateComponents* comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:self]; // Get necessary date components
    
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:self]; // Get necessary date components
    // set last of month
    [comps setMonth:[comps month]+1];
    [comps setDay:0];
    NSDate *tDateMonth = [calendar dateFromComponents:comps];
    return [tDateMonth toString];
}
-(NSDate*) lastDayMonth
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
     calendar.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateComponents* comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:self]; // Get necessary date components
    
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:self]; // Get necessary date components
    // set last of month
    [comps setMonth:[comps month]+1];
    [comps setDay:0];
    NSDate *tDateMonth = [calendar dateFromComponents:comps];
    return tDateMonth;
}
-(NSDate*) firstDayWeekWithPrevWeek:(int)week
{
    NSDate* selDate  = [NSDate date];
    if(week == 0)
    {
        selDate = [selDate firstDayInWeek];
    }
    else
    {
    for (int i = 0; i < week; i++) {
        selDate = [selDate firstDayInWeek];
        selDate = [selDate lastDay:1];
        selDate = [selDate firstDayInWeek];
    }
    }
    return selDate;
}
-(NSDate*)lastDayWeekWithPrevWeek:(int)week
{
    NSDate* selDate  = [NSDate date];
    if(week == 0)
    {
        selDate = [selDate lastDayInWeek];
    }
    else
    {
    for (int i = 0; i < week; i++) {
        selDate = [selDate firstDayInWeek];
        selDate = [selDate lastDay:1];
    }
    }
    return selDate;
}
-(NSDate*) firstDayMonthWithPrevMonth:(int)month
{   
    NSDate* selDate  = [NSDate date];
    if(month == 0)
    {
          selDate = [selDate firstDayMonth];
    }
    else
    {
        for (int i = 0; i < month; i++) {
            selDate = [selDate firstDayMonth];
            selDate = [selDate lastDay:1];
            selDate = [selDate firstDayMonth];
        }
    }

    return selDate;
}
-(NSDate*) lastDayMonthWithPrevMonth:(int)month
{
    NSDate* selDate  = [NSDate date];
    if(month == 0)
    {
        selDate = [selDate lastDayMonth];
    }
    else
    {
        for (int i = 0; i < month; i++) {
            selDate = [selDate firstDayMonth];
            selDate = [selDate lastDay:1];
        }
    }
    return selDate;
}
-(NSDate*) firstDayMonth
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    gregorian.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
    
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [gregorian dateFromComponents:comp];
    return firstDayOfMonthDate ;
}

-(NSDate*)lastDay:(int)days
{
    NSCalendar *cal = [NSCalendar currentCalendar];
     cal.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:-days];
    return [cal dateByAddingComponents:components toDate:self options:0];
}
-(NSDate*) nextDay:(int)days
{
    NSCalendar *cal = [NSCalendar currentCalendar];
     cal.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    return [cal dateByAddingComponents:components toDate:self options:0];
}
-(NSDate*) firstDayInWeek
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    gregorian.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:self];
    return [self lastDay:[weekdayComponents weekday]-1];
}
-(NSDate*) lastDayInWeek
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    gregorian.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:self];
    return [self nextDay:7-[weekdayComponents weekday]];
}

-(NSString*) firstDayMonthString
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    gregorian.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [gregorian dateFromComponents:comp];
    return [firstDayOfMonthDate toString];
}
-(BOOL) isWeekDay
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    gregorian.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:self];
    NSInteger weekday = [weekdayComponents weekday];
    return weekday != 1 && weekday !=7;
}
-(BOOL) isWeekEnd
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    gregorian.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:self];
    NSInteger weekday = [weekdayComponents weekday];
    return weekday == 1 || weekday ==7;
}
-(BOOL) isFirstOfMonth
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    gregorian.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [gregorian dateFromComponents:comp];
    return [self isSameDate:firstDayOfMonthDate];
}
-(BOOL) isEndOfMonth
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    calendar.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateComponents* comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:self]; // Get necessary date components
    
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:self]; // Get necessary date components
    // set last of month
    [comps setMonth:[comps month]+1];
    [comps setDay:0];
    NSDate *tDateMonth = [calendar dateFromComponents:comps];
    return [self isSameDate:tDateMonth];
}

-(BOOL) isSameDate:(NSDate*)date
{
    NSDateFormatter* dateComparer = [[[NSDateFormatter alloc]init]autorelease];
    [dateComparer setDateFormat:@"yyyy-MM-dd"];
    dateComparer.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    if([[dateComparer stringFromDate:self]isEqualToString:[dateComparer stringFromDate:date]])
    {
        return true;
    }
    return false;
}
@end
