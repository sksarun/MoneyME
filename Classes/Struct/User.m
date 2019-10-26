//
//  User.m
//  MoneyMe
//
//  Created by Tong on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "User.h"


@implementation User
@synthesize name,nickname,salary,salaryType,gender;

#pragma mark constructor
-(id) initWithName:(NSString*)_name withNickName:(NSString*)_nickname withSalary:(NSInteger)_salary withSalaryType:(SalaryType)_salaryType withGender:(int)_gender
{
	self = [super init];
	if(self)
	{
		self->name = _name;
		[self->name	 retain];
		self->nickname = _nickname;
		[self->nickname retain];
		self->salary = _salary;
		self->salaryType = _salaryType;
        self->gender = _gender;
	}
	return self;
}

-(id)initWithCoder:(NSCoder*)decoder
{
    self = [super init];
    if(self)
    {
        self->name = [decoder decodeObjectForKey:@"name"];
		[self->name	 retain];
		self->nickname = [decoder decodeObjectForKey:@"nickname"];
		[self->nickname retain];
		self->salary = [decoder decodeIntForKey:@"salary"];
		self->salaryType = [decoder decodeIntForKey:@"salaryType"];
        self->gender = [decoder decodeIntForKey:@"gender"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeObject:self->name forKey:@"name"];
    [encoder encodeObject:self->nickname forKey:@"nickname"];
    [encoder encodeInt:self->salary forKey:@"salary"];
    [encoder encodeInt:self->salaryType forKey:@"salaryType"];
    [encoder encodeInt:self->gender forKey:@"gender"];
}


#pragma mark  memory management
-(void) dealloc
{
	[self->name release];
	[self->nickname release];
	[super dealloc];
}
@end
