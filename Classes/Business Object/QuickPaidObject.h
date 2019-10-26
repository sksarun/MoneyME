//
//  QuickPaidObject.h
//  MoneyMe
//
//  Created by Tong on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QuickPaidObject : NSObject {
   int selectedTranTypeID;
    int selectedPaymentTypeID;
    int selectedSeqTypeID;
}

@property (nonatomic,assign)int selectedTranTypeID;
@property (nonatomic,assign)int selectedPaymentTypeID;
@property (nonatomic,assign)int selectedSeqTypeID;
@end
