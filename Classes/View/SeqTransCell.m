//
//  SeqTransCell.m
//  MoneyMe
//
//  Created by Tong on 9/5/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "SeqTransCell.h"
#import "SingletonData.h"
@implementation SeqTransCell
@synthesize seqTitleLabel,seqLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) setCell:(SequenceTransaction*)seq
{
    [super setCell:seq];
    self.seqTitleLabel.text = @"Sequence";
    self.timeTitleLabel.text = @"Create date";
    SequenceType* seqtype = (SequenceType*)  [[SingletonData object].sequenceList objectAtIndex:seq.seqType];
    self.seqLabel.text = seqtype.seqTypename;
}
-(void) dealloc
{
    [self.seqLabel release];
    [self.seqTitleLabel release];
    [super dealloc];
}
@end
