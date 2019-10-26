//
//  MoneyMeAppDelegate.m
//  MoneyMe
//
//  Created by Tong on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MoneyMeAppDelegate.h"
#import "SingletonData.h"
@implementation MoneyMeAppDelegate

@synthesize window,mainNav,createNav;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
    
    
    SingletonData* data = [SingletonData object];
    if(data.user != nil)
    {
        [self.window addSubview:self.mainNav.view];
    }
    else
    {
        [self.window addSubview:self.createNav.view];
    }
    
    application.applicationIconBadgeNumber = 0;
	
	// Handle launching from a notification
	UILocalNotification *localNotif =
	[launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif) {
		NSLog(@"Recieved Notification %@",localNotif);
	}
    
    [self scheduleNotification];   
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
	// Handle the notificaton when the app is running
	NSLog(@"Recieved Notification %@",notif);
}
-(void) switchToMainView
{
    [self.createNav.view removeFromSuperview];
    [self.window addSubview:self.mainNav.view];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    [[SingletonData object] performSequenceTask];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}
-(void) scheduleNotification
{
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit fromDate:[[NSDate date]nextDayDate]]; 
    [comps setHour:21];
    NSDate *tDateMonth = [calendar dateFromComponents:comps];
    
    localNotif.fireDate = tDateMonth;
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
	
	// Notification details
    localNotif.alertBody = @"Don't forget to update your payment :)";
	// Set the action button
    localNotif.alertAction = @"View";
	
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 1;
	
	// Specify custom data for the notification
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
    localNotif.userInfo = infoDict;
	
	// Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    [localNotif release];

}

- (void)dealloc {
	[self.mainNav release];
	[self.createNav release];
    [window release];
    [super dealloc];
}


@end
