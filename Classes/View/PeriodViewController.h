 //
//  PeriodViewController.h
//  MoneyMe
//
//  Created by Tong on 6/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IPeriodTypeHandler.h"


@interface PeriodViewController : UIViewController {
    
    id<IPeriodTypeHandler> handler;
    IBOutlet UITableView* table;
}

@property (nonatomic,retain) IBOutlet UITableView* table;
-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCallBack:(id<IPeriodTypeHandler>)_handler;
-(void) customClicked;

@end
