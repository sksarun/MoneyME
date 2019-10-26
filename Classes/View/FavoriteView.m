//
//  FavoriteView.m
//  MoneyMe
//
//  Created by Tong on 9/27/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "FavoriteView.h"
#import "SingletonData.h"
#import <QuartzCore/QuartzCore.h>

@implementation FavoriteView

- (id)initWithFrame:(CGRect)frame withTransaction:(Transaction*)trans
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = self.bounds;
        gradient.cornerRadius = 5;
        gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor grayColor] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
        [self.layer insertSublayer:gradient atIndex:0];
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8; // if you like rounded corners
        self.layer.shadowOffset = CGSizeMake(3, 3);
        self.layer.shadowRadius = 3;
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
        // Initialization code
        self->transaction = [trans retain];
        
        PaymentType* payment =[[SingletonData object].paymentTypeList objectAtIndex:trans.paymentType];
        
        UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, 130, 22)];
        nameLabel.text = trans.name;
        nameLabel.font= [UIFont boldSystemFontOfSize:14];
        nameLabel.textAlignment = UITextAlignmentCenter;
        nameLabel.backgroundColor = [UIColor clearColor];
        
        UILabel* typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 39, 130, 21)];
        typeLabel.text = [NSString stringWithFormat:@"%@/%@",
                          [[SingletonData object] getTransTypeforID:trans.transTypeID],payment.paymentTypename];
        typeLabel.font= [UIFont systemFontOfSize:12];
        
        typeLabel.textAlignment = UITextAlignmentCenter;
        typeLabel.backgroundColor = [UIColor clearColor];
        
         UILabel* amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 75, 130, 21)];
        amountLabel.text = [NSString stringWithFormat:@"%d %@",trans.amount,[SingletonData object].currencyCode];
        amountLabel.font= [UIFont boldSystemFontOfSize:13];
        amountLabel.textAlignment = UITextAlignmentCenter;
        amountLabel.backgroundColor = [UIColor clearColor];
        
        
         

        [self addSubview:nameLabel];
        [self addSubview:typeLabel];
        [self addSubview:amountLabel]; 
        [nameLabel release];
        [typeLabel release];
        [amountLabel release];
    }
    return self;
}

-(void)dealloc
{
    [self->transaction release];
    [super dealloc];
}

@end
