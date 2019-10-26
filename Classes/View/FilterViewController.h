//
//  FilterViewController.h
//  MoneyMe
//
//  Created by Tong on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterCell.h"
#import "ITransTypeHandler.h"
#import "IPaidNameHandler.h"
#import "IPeriodTypeHandler.h"
#import "IPaymentTypeHandler.h"
#import "IFilterHandler.h"

@interface FilterViewController : UIViewController<ITransTypeHandler,IPaidNameHandler,IPaymentTypeHandler,IPeriodTypeHandler >{
    NSMutableArray* filterList;
    id<IFilterHandler> handler;
    IBOutlet FilterCell* tempCell;
    IBOutlet UITableView* table;
}
@property (nonatomic,assign)IBOutlet FilterCell* tempCell;
@property (nonatomic,retain)IBOutlet UITableView* table;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withFilterList:(NSMutableArray*)_filterList withCallback:(id<IFilterHandler>)_handler;

-(IBAction) onSwitchFilter:(id)sender;

-(void) onDoneFilter:(id)sender;
-(void) onCancelFilter:(id)sender;
@end
