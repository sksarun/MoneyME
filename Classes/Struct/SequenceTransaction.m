//
//  SequenceTransaction.m
//  MoneyMe
//
//  Created by Tong on 8/31/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.   //

#import "SequenceTransaction.h"

@implementation SequenceTransaction
@synthesize seqType;
-(id) initWithTrans:(Transaction*)tran withType:(SequenceTypes)type;
{
    self = [super initWithName:tran.name withID:tran.transID withAmount:tran.amount withDate:tran.date withTransTypeID:tran.transTypeID withDesc:tran.description withPaymentType:tran.paymentType];
    if (self) {
        // Initialization code here.
        self.seqType = type;
    }
    
    return self;
}



-(id)initWithCoder:(NSCoder*)decoder
{
    self = [super init];
    if(self)
    {
        self->transID = [decoder decodeIntegerForKey:@"transID"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self->amount = [decoder decodeIntegerForKey:@"amount"];
        self.date = [decoder decodeObjectForKey:@"date"];
        self.description = [decoder decodeObjectForKey:@"description"];
        self->transTypeID = [decoder decodeIntegerForKey:@"transTypeID"];
        self->paymentType = [decoder decodeIntegerForKey:@"paymentType"];
        self->seqType = [decoder decodeIntegerForKey:@"seqType"];
        
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
    [encoder encodeInt:self->seqType forKey:@"seqType"];
}
@end
