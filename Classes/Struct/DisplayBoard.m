//
//  DisplayBoard.m
//  MoneyMe
//
//  Created by Tong on 9/8/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "DisplayBoard.h"
#import "NSDate+Component.h"

@implementation DisplayBoard
@synthesize isSelected,sqlCommand,displayName;

-(id) initWithDisplayType:(BOOL)_isSelected withName:(NSString*)_displayName 
{
    self = [super init];
    if (self) {
        // Initialization code here.        
        self->isSelected = _isSelected;
        self.displayName = _displayName;
    }
    
    return self;
}
-(void) dealloc
{
    [self->sqlCommand release];
    self.displayName = nil;
    [super dealloc];
}

-(id)initWithCoder:(NSCoder*)decoder
{
    self = [super init];
    if(self)
    {
        self->isSelected = [decoder decodeBoolForKey:@"isSelected"];
        self.displayName = [decoder decodeObjectForKey:@"displayName"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeBool:self->isSelected forKey:@"isSelected"];
    [encoder encodeObject:self.displayName forKey:@"displayName"];
}
-(NSString*)sqlRequestCommand
{
    if([self.displayName isEqualToString:@"Daily paid"])
    {
        return [NSString stringWithFormat:@"SELECT * from Trans where Trans.trans_time >= '%@ 00:00:00' and Trans.trans_time <= '%@ 00:00:00' ",
                [[NSDate date] toString],[[NSDate date]nextDateString]];
    }
    else if([self.displayName isEqualToString:@"Weekly paid"])
    {
        return  [NSString stringWithFormat:@"SELECT *  from Trans where Trans.trans_time >= '%@ 00:00:00' and Trans.trans_time <= '%@ 00:00:00' ",
                 [[[NSDate date] firstDayInWeek] toString],[[[NSDate date]lastDayInWeek]toString]];
    }
    else if([self.displayName isEqualToString:@"Monthly paid"])
    {
        return [NSString stringWithFormat:@"SELECT * from Trans where Trans.trans_time >= '%@ 00:00:00' and Trans.trans_time <= '%@ 00:00:00' ",
                [[NSDate date] firstDayMonthString ],[[NSDate date]lastDayMonthString]];
    }
    else if([self.displayName isEqualToString:@"Total paid"])
    {
        return [NSString stringWithFormat:@"SELECT * from Trans "];
    }
    else if([self.displayName isEqualToString:@"Most paid of the day"])
    {
        return [NSString stringWithFormat:@"SELECT Max(Amount) as Amount,* from Trans where Trans.trans_time >= '%@ 00:00:00' and Trans.trans_time <= '%@ 00:00:00' ",
                [[NSDate date] toString],[[NSDate date]nextDateString]];
    }
    else if([self.displayName isEqualToString:@"Most paid of the week"])
    {
        return [NSString stringWithFormat:@"SELECT Max(Amount) as Amount,* from Trans where Trans.trans_time >= '%@ 00:00:00' and Trans.trans_time <= '%@ 00:00:00' ",
                [[[NSDate date] firstDayInWeek]toString],[[[NSDate date]lastDayInWeek]toString]];
    }
    else 
    {  
        return [NSString stringWithFormat:@"SELECT Max(Amount) as Amount from Trans where Trans.trans_time >= '%@ 00:00:00' and Trans.trans_time <= '%@ 00:00:00' ",
                [[NSDate date] firstDayMonthString],[[NSDate date]lastDayMonthString]];
    }
    return @"";
}
-(NSString*) sqlCommand
{
    if([self.displayName isEqualToString:@"Daily paid"])
       {
          return [NSString stringWithFormat:@"SELECT Sum(Amount) as Amount from Trans where Trans.trans_time >= '%@ 00:00:00' and Trans.trans_time <= '%@ 00:00:00' ",
                               [[NSDate date] toString],[[NSDate date]nextDateString]];
       }
    else if([self.displayName isEqualToString:@"Weekly paid"])
       {

           return  [NSString stringWithFormat:@"SELECT Sum(Amount) as Amount from Trans where Trans.trans_time >= '%@ 00:00:00' and Trans.trans_time <= '%@ 00:00:00' ",
                                [[[NSDate date] firstDayInWeek] toString],[[[NSDate date]lastDayInWeek]toString]];
       }
    else if([self.displayName isEqualToString:@"Monthly paid"])
    {
        return [NSString stringWithFormat:@"SELECT Sum(Amount) as Amount from Trans where Trans.trans_time >= '%@ 00:00:00' and Trans.trans_time <= '%@ 00:00:00' ",
                             [[NSDate date] firstDayMonthString ],[[NSDate date]lastDayMonthString]];
    }
    else if([self.displayName isEqualToString:@"Total paid"])
    {
         return [NSString stringWithFormat:@"SELECT Sum(Amount) as Amount from Trans "];
    }
    else if([self.displayName isEqualToString:@"Most paid of the day"])
    {
        return [NSString stringWithFormat:@"SELECT Max(Amount) as Amount from Trans where Trans.trans_time >= '%@ 00:00:00' and Trans.trans_time <= '%@ 00:00:00' ",
                             [[NSDate date] toString],[[NSDate date]nextDateString]];
    }
    else if([self.displayName isEqualToString:@"Most paid of the week"])
    {
        return [NSString stringWithFormat:@"SELECT Max(Amount) as Amount from Trans where Trans.trans_time >= '%@ 00:00:00' and Trans.trans_time <= '%@ 00:00:00' ",
                            [[[NSDate date] firstDayInWeek] toString],[[[NSDate date]lastDayInWeek]toString]];
    }
    else 
    {
        return [NSString stringWithFormat:@"SELECT Max(Amount) as Amount from Trans where Trans.trans_time >= '%@ 00:00:00' and Trans.trans_time <= '%@ 00:00:00' ",
                             [[NSDate date] firstDayMonthString],[[NSDate date]lastDayMonthString]];
    }
    return @"";
}
@end
