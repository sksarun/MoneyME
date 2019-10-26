//
//  StatisticCell.m
//  MoneyMe
//
//  Created by Tong on 8/14/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "StatisticCell.h"
#import "PaymentStatistic.h"
#import "SingletonData.h"
#import "PaidTypeStatistic.h"

@implementation StatisticCell
@synthesize percentLabel,typeNameLabel,amountLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) setCell:(id)statisticObject
{
    if([statisticObject isKindOfClass:[PaymentStatistic class]])
    {
        PaymentStatistic* payment = (PaymentStatistic*)statisticObject;
        
        self.typeNameLabel.text =  [[SingletonData object] getTransTypeforID:payment.transType];
        self.amountLabel.text = [NSString stringWithFormat:@"%d",payment.totalpayment];
        self.percentLabel.text = [NSString stringWithFormat:@"%d",payment.percent];
    }
    else
    {
        PaidTypeStatistic* payment = (PaidTypeStatistic*)statisticObject;
        
        self.typeNameLabel.text =  [[SingletonData object] getPaymentTypeforID:payment.paidType];
        self.amountLabel.text = [NSString stringWithFormat:@"%d",payment.totalpayment];
        self.percentLabel.text = [NSString stringWithFormat:@"%d",payment.percent];
    }
}

- (void)dealloc
{
    [self.amountLabel release];
    [self.percentLabel release];
    [self.typeNameLabel release];
    [super dealloc];
}
@end
