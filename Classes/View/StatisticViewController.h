//
//  StatisticViewController.h
//  MoneyMe
//
//  Created by Tong on 7/31/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatisticCell.h"
#import "BaseTableViewCell.h"
#import "StatisticList.h"

@interface StatisticViewController : UIViewController
{
    IBOutlet BaseTableViewCell* headerCell;
    IBOutlet StatisticCell* tempCell;
    IBOutlet UITabBar* periodBar;
    
    //Button
    IBOutlet UIButton* prevButton;
    IBOutlet UIButton* nextButton;
    
    //Label
    IBOutlet UILabel* titleLabel;
    IBOutlet UILabel* periodLabel;
    IBOutlet UILabel* column1Label;
    IBOutlet UILabel* column2Label;
    IBOutlet UILabel* column3Label;
    
    IBOutlet UITableView* statisticTable;
    
    StatisticList* statisticList;
    
    
}
@property (nonatomic,retain) IBOutlet UIButton* prevButton;
@property (nonatomic,retain) IBOutlet UIButton* nextButton;

@property (nonatomic,retain) IBOutlet UITabBar* periodBar;
@property (nonatomic,retain) IBOutlet BaseTableViewCell* headerCell;
@property (nonatomic,assign) IBOutlet StatisticCell* tempCell;

@property (nonatomic,retain) IBOutlet UILabel* titleLabel;
@property (nonatomic,retain) IBOutlet UILabel* periodLabel;
@property (nonatomic,retain) IBOutlet UILabel* column1Label;
@property (nonatomic,retain) IBOutlet UILabel* column2Label;
@property (nonatomic,retain) IBOutlet UILabel* column3Label;
@property (nonatomic,retain) IBOutlet UITableView* statisticTable;

-(IBAction)nextClicked:(id)sender;
-(IBAction)prevClicked:(id)sender;
-(IBAction)hasChangedContent:(id)sender;

-(void) reConstructStatistic;
@end
