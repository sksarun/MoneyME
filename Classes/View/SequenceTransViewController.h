//
//  SequenceTransViewController.h
//  MoneyMe
//
//  Created by Tong on 9/5/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeqTransCell.h"
@interface SequenceTransViewController : UIViewController
{
    IBOutlet UITableView* table;  
    IBOutlet SeqTransCell* tempCell;
    
     int deleteIndex;
}
@property (nonatomic,retain) IBOutlet UITableView* table;
@property (nonatomic,assign)IBOutlet SeqTransCell* tempCell;

-(IBAction) onDeleteTransClicked:(id)sender;
@end
