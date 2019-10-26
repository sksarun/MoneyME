//
//  PaidTypeStatistic.h
//  MoneyMe
//
//  Created by Tong on 8/17/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaidTypeStatistic : NSObject
{
    int paidType;
    int totalpayment;
    int percent;
}
@property (readonly)  int paidType;
@property (readonly)  int totalpayment;
@property (readonly)  int percent;

-(id)initWithType:(int)type withTotalAmount:(int)amount withPercent:(int)percentage;
@end
