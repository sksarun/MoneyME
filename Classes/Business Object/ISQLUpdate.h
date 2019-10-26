//
//  ISQLUpdate.h
//  Agoda.Consumer
//
//  Created by Krishnalome, Sarun (Agoda) on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ISQLUpdate 

-(void)onSQLComplete:(NSDictionary*)info;
-(void)onSQLUpdateComplete;

@end
