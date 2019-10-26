//
//  IPaidNameHandler.h
//  MoneyMe
//
//  Created by Tong on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol IPaidNameHandler 

-(void)onPaidNameUpdate:(NSString*) name;
@end
