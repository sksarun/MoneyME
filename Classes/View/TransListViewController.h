//
//  TransListViewController.h
//  MoneyMe
//
//  Created by Tong on 5/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransCell.h"
#import "ISQLUpdate.h"
#import "SQLHandler.h"
#import "IFilterHandler.h"
#import "TransactionList.h"
#import "ITranEditUpdate.h"

@interface TransListViewController : UIViewController <ISQLUpdate,IFilterHandler,ITranEditUpdate> {
    IBOutlet UITableView* table;
    IBOutlet TransCell* tempCell;
    
    IBOutlet UIButton* filterButton;
    IBOutlet UIButton* sortButton;
    SQLHandler* sqlHandler;
    
    TransactionList* trans;
    
    NSString* sqlRequest;
    int deleteIndex;
}
@property (nonatomic,retain) IBOutlet UITableView* table;
@property (nonatomic,assign)IBOutlet TransCell* tempCell;
@property (nonatomic,retain) IBOutlet UIButton* filterButton;
@property (nonatomic,retain) IBOutlet UIButton* sortButton;


-(id)initWithNibName:(NSString *)nibNameOrNil withSQLRequest:(NSString*)sql bundle:(NSBundle *)nibBundleOrNil;
-(void) loadTransSQL; 

-(IBAction) onDeleteTransClicked:(id)sender;

-(IBAction) onFilterClicked:(id)sender;
-(IBAction) onSortClicked:(id)sender;

@end
