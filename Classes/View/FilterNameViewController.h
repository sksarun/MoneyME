//
//  FilterNameViewController.h
//  MoneyMe
//
//  Created by Tong on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IPaidNameHandler.h"


@interface FilterNameViewController : UIViewController<UIScrollViewDelegate> {
    id<IPaidNameHandler> handler;
    IBOutlet UITextField* nameText;
}
@property (nonatomic,retain) IBOutlet UITextField* nameText;


-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCallBack:(id<IPaidNameHandler>)_handler;

-(void) doneButtonClicked;

-(void) hideKeyboard;
@end
