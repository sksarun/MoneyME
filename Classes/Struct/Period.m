//
//  Period.m
//  MoneyMe
//
//  Created by Tong on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Period.h"
#import "NSDate+Component.h"


@implementation Period
@synthesize periodID,periodName,startDate,endDate;

-(id)initPeriod:(int)_periodID withPeriodName:(NSString*)_periodName withStartDate:(NSDate*)start withEndDate:(NSDate*)end
{
    self = [super init];
    if(self)
    {
        self->periodID = _periodID;
        self.startDate = start;
        self.endDate = end;
        self->periodName = _periodName;
        [self->periodName retain];
    }
    return self;
}
-(void) dealloc
{
    [self->periodName release];
    [self.startDate release];
    [self.endDate release];
    [super dealloc];
}
-(NSString*) periodToString
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MMM-yyyy"];
    if(![self isSameDate:self.startDate withDate:self.endDate])
    {
        return [NSString stringWithFormat:@"%@ - %@",[dateFormat stringFromDate:self.startDate],[dateFormat stringFromDate:self.endDate]];
    }
    else
    {
        return [dateFormat stringFromDate:self.startDate];
    }
}
- (BOOL)isSameDate:(NSDate*)date1 withDate:(NSDate*)date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}
-(id)initWithCoder:(NSCoder*)decoder
{
    self = [super init];
    if(self)
    {
        self->periodID = [decoder decodeIntegerForKey:@"periodID"];
		self->periodName = [decoder decodeObjectForKey:@"periodName"];
        [self->periodName retain];
        self.startDate = [decoder decodeObjectForKey:@"start"];
        self.endDate = [decoder decodeObjectForKey:@"end"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeInt:self->periodID forKey:@"periodID"];
    [encoder encodeObject:self.periodName forKey:@"periodName"];
    [encoder encodeObject:self.startDate forKey:@"start"];
    [encoder encodeObject:self.endDate forKey:@"end"];
}
-(BOOL) isInPeriod:(NSDate*)date
{
    if ([self.endDate compare:date] == NSOrderedDescending && [self.startDate compare:date] == NSOrderedAscending) {
        return YES;    
        
    } 
    else if([self.endDate isSameDate:date]&& [self.startDate isSameDate:date])
    {
        return  YES;
    }
    else
    {
        return NO;
    }

}
-(void) moveNextDay
{
    self.startDate =  [self.startDate nextDay:1];
    self.endDate =[self.endDate nextDay:1];
}
-(void) movePrevDay
{
    self.startDate =  [self.startDate lastDay:1];
    self.endDate =[self.endDate lastDay:1];
}
-(void) moveNextWeek
{
    self.startDate =  [[self.startDate lastDayInWeek]nextDay:1];
    self.endDate = [self.startDate lastDayInWeek];
}
-(void) movePrevWeek
{
    self.endDate = [[self.startDate firstDayInWeek]lastDay:1];
    self.startDate = [self.endDate firstDayInWeek];
}
-(void) moveNextMonth
{
    self.startDate =[[self.startDate lastDayMonth]nextDay:1];
    self.endDate = [self.startDate lastDayMonth]; 
}
-(void) movePrevMonth
{
    self.endDate = [[self.startDate firstDayMonth]lastDay:1];
    self.startDate = [self.endDate firstDayMonth];
}
-(void) setupWeekly
{
    

}
-(void) setupMonthly
{
    
}
@end
