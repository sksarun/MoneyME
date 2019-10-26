//
//  PaidTypeViewController.h
//  MoneyMe
//
//  Created by Tong on 5/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITransTypeHandler.h"

@interface PaidTypeViewController : UIViewController {
    id<ITransTypeHandler> handler;
    IBOutlet UITableView* table;
}

@property (nonatomic,retain) IBOutlet UITableView* table;
-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCallBack:(id<ITransTypeHandler>)_handler;


@end
