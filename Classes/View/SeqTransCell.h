//
//  SeqTransCell.h
//  MoneyMe
//
//  Created by Tong on 9/5/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransCell.h"
#import "SequenceTransaction.h"

@interface SeqTransCell : TransCell
{
    IBOutlet UILabel* seqTitleLabel;
    IBOutlet UILabel* seqLabel;
}
@property (nonatomic,retain) IBOutlet UILabel* seqTitleLabel;
@property (nonatomic,retain) IBOutlet UILabel* seqLabel;
-(void) setCell:(SequenceTransaction*)seq;
@end
