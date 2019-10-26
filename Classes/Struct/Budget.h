//
//  Budget.h
//  MoneyMe
//
//  Created by Tong on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Budget : NSObject {
	@private
	NSInteger totalAmount;
	NSMutableArray* expenseList;
	NSMutableArray* incomeList;
}

@property (nonatomic,readonly) NSMutableArray* expenseList;
@property (nonatomic,readonly) NSMutableArray* incomeList;
@property (nonatomic,readonly) NSInteger totalAmount;


@end
