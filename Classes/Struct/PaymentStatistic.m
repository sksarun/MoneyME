//
//  PaymentStatistic.m
//  MoneyMe
//
//  Created by Tong on 8/17/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "PaymentStatistic.h"

@implementation PaymentStatistic

@synthesize transType,totalpayment,percent;

-(id)initWithType:(int)type withTotalAmount:(int)amount withPercent:(int)percentage;
{
    self = [super init];
    if (self) {
        self->transType = type;
        self->totalpayment = amount;
        self->percent = percentage;
    }
    
    return self;
}

@end
