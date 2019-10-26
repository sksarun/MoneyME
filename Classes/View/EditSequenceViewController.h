//
//  EditSequenceViewController.h
//  MoneyMe
//
//  Created by Tong on 9/6/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditSequenceViewController : UIViewController
{
    int sequnceIndex;
}
-(id)initWithNibName:(NSString *)nibNameOrNil withIndex:(int)index bundle:(NSBundle *)nibBundleOrNil;
@end
