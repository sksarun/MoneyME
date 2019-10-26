//
//  MoneyMeAppDelegate.h
//  MoneyMe
//
//  Created by Tong on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoneyMeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	
	IBOutlet UINavigationController* mainNav;
	IBOutlet UINavigationController* navControl;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic,retain) IBOutlet UINavigationController* mainNav;
@property (nonatomic,retain) IBOutlet UINavigationController* createNav;

-(void) switchToMainView;
-(void) scheduleNotification;
@end

