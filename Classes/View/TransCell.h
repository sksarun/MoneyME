//
//  TransCell.h
//  MoneyMe
//
//  Created by Tong on 5/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"
#import "BaseTableViewCell.h"

@interface TransCell : BaseTableViewCell {
    
    IBOutlet UILabel* nameLabel;
    IBOutlet UILabel* amountLabel;
    IBOutlet UILabel* typeLabel;
    IBOutlet UILabel* timeLabel;
    IBOutlet UILabel* paymentLabel;
    
    IBOutlet UILabel* amountTitleLabel;
    IBOutlet UILabel* typeTitleLabel;
    IBOutlet UILabel* paymentTitleLabel;
    IBOutlet UILabel* timeTitleLabel;
    
    IBOutlet UIButton* deleteButton;
}
@property (nonatomic,retain) IBOutlet UIButton* deleteButton;

@property (nonatomic,retain) IBOutlet UILabel* nameLabel;
@property (nonatomic,retain) IBOutlet UILabel* amountLabel;
@property (nonatomic,retain) IBOutlet UILabel* typeLabel;
@property (nonatomic,retain) IBOutlet UILabel* amountTitleLabel;
@property (nonatomic,retain) IBOutlet UILabel* typeTitleLabel;
@property (nonatomic,retain) IBOutlet UILabel* timeTitleLabel;
@property (nonatomic,retain) IBOutlet UILabel* timeLabel;
@property (nonatomic,retain) IBOutlet UILabel* paymentLabel;
@property (nonatomic,retain) IBOutlet UILabel* paymentTitleLabel;
-(void)setCell:(Transaction*)trans;
@end
