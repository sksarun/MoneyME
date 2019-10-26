//
//  SequenceTransaction.h
//  MoneyMe
//
//  Created by Tong on 8/31/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "Transaction.h"

typedef enum SequenceTypes
{
    EEveryday= 0,EWeekday,EWeekend,EFirstOfMonth,ELastOfMonth,ESeqWeekly,ESeqMonthy
}SequenceTypes;

@interface SequenceTransaction : Transaction
{
    SequenceTypes seqType;
}
@property (nonatomic,assign) SequenceTypes seqType;

-(id) initWithTrans:(Transaction*)tran withType:(SequenceTypes)type;
@end
