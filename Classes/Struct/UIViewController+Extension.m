//
//  UIViewController+Extension.m
//  MoneyMe
//
//  Created by Tong on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIViewController+Extension.h"


@implementation UIViewController (UIViewController_Extension)


-(void) printErrorMessage:(NSString*) error
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"error" message:error delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
    [alert show];
    [alert release];
}
-(void) printMessage:(NSString*) error
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"message" message:error delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
    [alert show];
    [alert release];
}


@end
