//
//  IPaymentTypeHandler.h
//  MoneyMe
//
//  Created by Tong on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol IPaymentTypeHandler <NSObject>

-(void) onPaymentTypeSelected:(int) paymentId;

@end
