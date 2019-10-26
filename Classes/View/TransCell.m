//
//  TransCell.m
//  MoneyMe
//
//  Created by Tong on 5/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TransCell.h"
#import "SingletonData.h"
#import <QuartzCore/QuartzCore.h>


@implementation TransCell
@synthesize  nameLabel,amountLabel,amountTitleLabel,typeLabel,typeTitleLabel,timeLabel,timeTitleLabel,paymentLabel,paymentTitleLabel,deleteButton;

-(void)setCell:(Transaction*)trans
{
    //set Shadow for edit button and delete button
    self.deleteButton.layer.shadowOffset = CGSizeMake(1, 1);
    self.deleteButton.layer.shadowRadius = 2;
    self.deleteButton.layer.shadowOpacity = 0.5;
    
    self.nameLabel.text = trans.name;
    self.amountLabel.text = [NSString stringWithFormat:@"%d %@",trans.amount,[SingletonData object].currencyCode];
    self.typeLabel.text =  [[SingletonData object] getTransTypeforID:trans.transTypeID];
    self.paymentLabel.text = [[SingletonData object] getPaymentTypeforID:trans.paymentType];
    NSDateFormatter* format = [[NSDateFormatter alloc] init];
    [format setDateStyle:NSDateFormatterLongStyle];
    self.timeLabel.text = [format stringFromDate:trans.date];
    [format release];
}

- (void)dealloc
{
    [self.paymentLabel release];
    [self.paymentTitleLabel release];
    [self.nameLabel release];
    [self.amountLabel release];
    [self.timeTitleLabel release];
    [self.timeLabel release];
    [self.amountTitleLabel release];
    [self.typeTitleLabel release];
    [self.typeLabel release];
    [self.deleteButton release];
    [super dealloc];
}

@end
