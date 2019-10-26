//
//  Transaction.h
//  MoneyMe
//
//  Created by Tong on 5/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Transaction : NSObject {
    
    int transID;
    NSString* name;
    NSInteger amount;
    NSDate* date;
    int transTypeID;
    NSString* description;
    int paymentType;
}
@property (nonatomic,assign) int transID;
@property (nonatomic,copy) NSString* name;
@property (nonatomic,assign) NSInteger amount;
@property (nonatomic,retain) NSDate* date;
@property (nonatomic,assign) int transTypeID;
@property (nonatomic,copy) NSString* description;
@property (nonatomic,assign)  int paymentType;

-(id)initWithName:(NSString*)_name withID:(int)_id withAmount:(NSInteger)_amount withDate:(NSDate*)_date withTransTypeID:(int) _transID withDesc:(NSString*)_desc withPaymentType:(int)_paymentType;

@end
