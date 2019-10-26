//
//  Trans_Type.m
//  MoneyMe
//
//  Created by Tong on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TransType.h"


@implementation TransType
@synthesize transTypeId,transTypename ;


-(id) initWithType:(int)type_id withName:(NSString*) type_name
{
    self = [super init];
    if(self)
    {
        self->transTypeId = type_id;
        self.transTypename = type_name;
    }
    return self;
}


-(void) dealloc
{
    [self.transTypename release];
    [super dealloc];
}

-(id)initWithCoder:(NSCoder*)decoder
{
    self = [super init];
    if(self)
    {
        self->transTypeId = [decoder decodeIntegerForKey:@"transId"];
		self.transTypename = [decoder decodeObjectForKey:@"transName"];

    }
    return self;
}

-(void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeInt:self->transTypeId forKey:@"transId"];
    [encoder encodeObject:self.transTypename forKey:@"transName"];
}

@end
