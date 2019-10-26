//
//  PaymentType.m
//  MoneyMe
//
//  Created by Tong on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PaymentType.h"


@implementation PaymentType
@synthesize paymentTypeId,paymentTypename ;


-(id) initWithType:(int)type_id withName:(NSString*) type_name
{
    self = [super init];
    if(self)
    {
        self->paymentTypeId = type_id;
        self.paymentTypename = type_name;
    }
    return self;
}


-(void) dealloc
{
    [self.paymentTypename release];
    [super dealloc];
}

-(id)initWithCoder:(NSCoder*)decoder
{
    self = [super init];
    if(self)
    {
        self->paymentTypeId = [decoder decodeIntegerForKey:@"paymentId"];
		self.paymentTypename = [decoder decodeObjectForKey:@"paymentName"];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeInt:self->paymentTypeId forKey:@"paymentId"];
    [encoder encodeObject:self.paymentTypename forKey:@"paymentName"];
}

@end
