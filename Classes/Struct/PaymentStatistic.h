//
//  PaymentStatistic.h
//  MoneyMe
//
//  Created by Tong on 8/17/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaymentStatistic : NSObject
{
    int transType;
    int totalpayment;
    int percent;
}
@property (readonly)  int transType;
@property (readonly)  int totalpayment;
@property (readonly)  int percent;

-(id)initWithType:(int)type withTotalAmount:(int)amount withPercent:(int)percentage;
@end
