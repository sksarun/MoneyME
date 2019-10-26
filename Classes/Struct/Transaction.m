//
//  Transaction.m
//  MoneyMe
//
//  Created by Tong on 5/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Transaction.h"


@implementation Transaction
@synthesize name,amount,date,transTypeID,description,transID,paymentType;

-(id)initWithName:(NSString*)_name withID:(int)_id withAmount:(NSInteger)_amount withDate:(NSDate*)_date withTransTypeID:(int) _transID withDesc:(NSString*)_desc withPaymentType:(int)_paymentType;
{
    self = [super init];
    if(self)
    {
        self->transID = _id;
        self->name = _name;
        [self->name retain];
        self->amount = _amount;
        self->date = _date;
        [self->date retain];
        self->transTypeID = _transID;
        self->description = _desc;
        [self->description retain];
        self->paymentType = _paymentType;
    }
    return self;
}

-(void) dealloc
{
    [self->name release];
    [self->date release];
    [self->description release];
    [super dealloc];
}

-(id)initWithCoder:(NSCoder*)decoder
{
    self = [super init];
    if(self)
    {
        self->transID = [decoder decodeIntegerForKey:@"transID"];
        self->name = [[decoder decodeObjectForKey:@"name"] retain];
        self->amount = [decoder decodeIntegerForKey:@"amount"];
        self->date = [[decoder decodeObjectForKey:@"date"] retain];
        self->description = [[decoder decodeObjectForKey:@"description"] retain];
        self->transTypeID = [decoder decodeIntegerForKey:@"transTypeID"];
        self->paymentType = [decoder decodeIntegerForKey:@"paymentType"];
        
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeInt:self->transID forKey:@"transID"];
    [encoder encodeObject:self->name forKey:@"name"];
     [encoder encodeInt:self->amount forKey:@"amount"];
    [encoder encodeObject:self->date forKey:@"date"];
    [encoder encodeObject:self->description forKey:@"description"];
     [encoder encodeInt:self->transTypeID forKey:@"transTypeID"];
     [encoder encodeInt:self->paymentType forKey:@"paymentType"];
}
@end
