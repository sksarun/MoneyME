//
//  OptionViewController.h
//  MoneyMe
//
//  Created by Tong on 7/27/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface OptionViewController : UIViewController
{
    
    IBOutlet BaseTableViewCell* currencyCell;
    IBOutlet BaseTableViewCell* displayBoardCell;
    IBOutlet BaseTableViewCell* aboutCell;
    IBOutlet BaseTableViewCell* accountCell;
    
    IBOutlet UILabel* currencyLabel;
    
    IBOutlet UILabel* currencyTitle;
    IBOutlet UILabel* displayBoardTitle;
    IBOutlet UILabel* aboutTitle;
    IBOutlet UILabel* accountTitle;
    
    IBOutlet UITableView* table;
    
}
@property (nonatomic,retain) IBOutlet BaseTableViewCell* currencyCell;
@property (nonatomic,retain) IBOutlet BaseTableViewCell* displayBoardCell;
@property (nonatomic,retain) IBOutlet BaseTableViewCell* aboutCell;
@property (nonatomic,retain) IBOutlet BaseTableViewCell* accountCell;
@property (nonatomic,retain) IBOutlet UILabel* currencyLabel;
@property (nonatomic,retain) IBOutlet UILabel* currencyTitle;
@property (nonatomic,retain) IBOutlet UILabel* displayBoardTitle;
@property (nonatomic,retain) IBOutlet UILabel* aboutTitle;
@property (nonatomic,retain) IBOutlet UILabel* accountTitle;

@property (nonatomic,retain) IBOutlet UITableView* table;
@end
