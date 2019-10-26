//
//  PaymentType.h
//  MoneyMe
//
//  Created by Tong on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PaymentType : NSObject {
    int paymentTypeId;
    NSString* paymentTypename;
}

@property (nonatomic,retain) NSString* paymentTypename;
@property (nonatomic,assign) int paymentTypeId;

-(id) initWithType:(int)type_id withName:(NSString*) type_name;
@end
