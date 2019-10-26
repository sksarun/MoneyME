//
//  StatisticCell.h
//  MoneyMe
//
//  Created by Tong on 8/14/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatisticCell : UITableViewCell
{
    IBOutlet UILabel* typeNameLabel;
    IBOutlet UILabel* amountLabel;
    IBOutlet UILabel* percentLabel;
    
}

@property(nonatomic,retain) IBOutlet UILabel* typeNameLabel;
@property(nonatomic,retain) IBOutlet UILabel* amountLabel;
@property(nonatomic,retain) IBOutlet UILabel* percentLabel;

-(void) setCell:(id)statisticObject;
@end
