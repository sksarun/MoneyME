//
//  NSDate+Calculate.h
//  MoneyMe
//
//  Created by Tong on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (NSDate_Calculate)

//calculate for different days for two NSDate given
-(NSInteger)dateSubstract:(NSDate*)subDate;

// get the specify future date from specific date
-(NSDate*) nextDate:(NSInteger)number;

// get the next year date from specific date
-(NSDate*) nextYearDate;

// get the next day date from specific date
-(NSDate*) nextDayDate;

// get the yesterday date from specific date
-(NSDate*) yesterdayDate;

@end
