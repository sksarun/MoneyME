//
//  SQLHandler.h
//  Agoda.Consumer
//
//  Created by Krishnalome, Sarun (Agoda) on 3/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISQLUpdate.h"
// SQL wrapper the frame work for execute SQL command
@interface SQLHandler : NSObject {
    
    NSString* databasePath;
    NSString* databaseName;
    NSString* sqlCommand;
    
    // callback response for main thread's callback
    id<ISQLUpdate> delegate;
}
@property (nonatomic,copy)NSString* databasePath;
@property (nonatomic,copy)NSString* databaseName;
@property (nonatomic,copy)NSString* sqlCommand;

-(id) initWithDelegate:(id<ISQLUpdate>)_delegate;

-(void)executeSQL;
-(void)prepareSQL:(NSString*)sql withDB:(NSString*)database;
- (void)checkAndCreateDatabase;
-(void)updateSQL;

-(void) unBindDelegate;
@end
