//
//  DisplayBoardViewController.h
//  MoneyMe
//
//  Created by Tong on 9/7/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayBoardViewController : UIViewController
{
    BOOL isReplaceData;
    NSString* replaceMember;
    IBOutlet UITableView* table;
    IBOutlet UILabel* titleLabel;
}
@property (nonatomic,retain)  IBOutlet UITableView* table;
@property (nonatomic,retain) IBOutlet UILabel* titleLabel;
@property (nonatomic,copy) NSString* replaceMember;
@end
