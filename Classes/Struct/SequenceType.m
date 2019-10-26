//
//  SequenceType.m
//  MoneyMe
//
//  Created by Tong on 9/4/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "SequenceType.h"

@implementation SequenceType
@synthesize  seqTypename,seqTypeId;

-(id) initWithType:(int)type_id withName:(NSString*) type_name
{
    self = [super init];
    if(self)
    {
        self->seqTypeId = type_id;
        self.seqTypename = type_name;
    }
    return self;
}
-(void)dealloc
{
    [self.seqTypename release];
    [super dealloc];
}
-(id)initWithCoder:(NSCoder*)decoder
{
    self = [super init];
    if(self)
    {
        self->seqTypeId = [decoder decodeIntegerForKey:@"seqTypeId"];
		self.seqTypename = [decoder decodeObjectForKey:@"seqTypename"];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeInt:self->seqTypeId forKey:@"seqTypeId"];
    [encoder encodeObject:self.seqTypename forKey:@"seqTypename"];
}
@end
