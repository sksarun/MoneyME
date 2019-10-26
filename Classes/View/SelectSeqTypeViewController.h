//
//  SelectSeqTypeViewController.h
//  MoneyMe
//
//  Created by Tong on 9/3/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISeqTypeHandler.h"

@interface SelectSeqTypeViewController : UIViewController
{
    id<ISeqTypeHandler> handler;
    IBOutlet UITableView* table;
}
@property (nonatomic,retain) IBOutlet UITableView* table;
-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCallBack:(id<ISeqTypeHandler>)_handler;


@end
