//
//  IDatePickerUpdate.h
//  MoneyMe
//
//  Created by Tong on 7/21/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDatePickerUpdate <NSObject>

/*
 fire callback when date picker already selected date
 */
-(void) onDatePickerUpdate:(NSDate*)selectDate withTag:(int)calltag;

@end
