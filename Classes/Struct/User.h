//
//  User.h
//  MoneyMe
//
//  Created by Tong on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum  {
	EYearly = 0,
	EMonthly,
	EWeekly,
	EDay
}SalaryType;

@interface User : NSObject {
	
	@private
	NSString* name;
	NSString* nickname;
	NSInteger salary;
	SalaryType salaryType;
    int gender;
}
@property (nonatomic,retain)NSString* name;
@property (nonatomic,readonly)NSString* nickname;
@property (nonatomic,readonly)NSInteger salary;
@property (nonatomic,readonly)SalaryType salaryType;
@property (nonatomic,readonly)int gender;

-(id) initWithName:(NSString*)_name withNickName:(NSString*)_nickname withSalary:(NSInteger)_salary withSalaryType:(SalaryType)_salaryType withGender:(int)_gender;
@end
