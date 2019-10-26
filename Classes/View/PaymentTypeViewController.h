//
//  PaymentTypeViewController.h
//  MoneyMe
//
//  Created by Tong on 6/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IPaymentTypeHandler.h"

@interface PaymentTypeViewController : UIViewController {
     id<IPaymentTypeHandler> handler;
    IBOutlet UITableView* table;
}

@property (nonatomic,retain) IBOutlet UITableView* table;
-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCallBack:(id<IPaymentTypeHandler>)_handler;

@end
