//
//  NSString+Component.m
//  MoneyMe
//
//  Created by Tong on 5/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSString+Component.h"


@implementation NSString (NSString_Component)

-(NSDate*)sqlite3Date
{
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //this is the sqlite's forma;
    return [formatter dateFromString:self];
}
@end
