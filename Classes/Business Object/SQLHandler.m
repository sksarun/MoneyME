//
//  SQLHandler.m
//  Agoda.Consumer
//
//  Created by Krishnalome, Sarun (Agoda) on 3/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SQLHandler.h"
#import "EGODatabase.h"

@implementation SQLHandler
@synthesize databasePath,databaseName,sqlCommand;

#pragma mark constructor
-(id) initWithDelegate:(id<ISQLUpdate>)_delegate
{
    self = [super init];
    if(self)
    {
        self->delegate = _delegate;
    }
    return self;
}
#pragma mark SQL Method
-(void) executeSQL
{
     NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    NSString* currentSQL = self.sqlCommand;
    [currentSQL retain];
	// Check if the database has already been created in the users filesystem
    NSFileManager *fileManager = [NSFileManager defaultManager];
    EGODatabaseResult* result = nil;
    // check is database is really exist before execute sql command
	if([fileManager fileExistsAtPath:self.databasePath] )
    {
        EGODatabase* database = [EGODatabase databaseWithPath:self.databasePath];
        result = [database executeQuery:currentSQL];
    }
    // check if the  thread is main thread or not
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:
                          result, @"resultList", currentSQL, @"SQL", nil];
    if([NSThread isMainThread])
    {
        // just fired the callback if this is in mainthread
        [self->delegate onSQLComplete:info];
    }
    else   
    {
        // suspends this thread and perform action back on main Thread
        [(id)self->delegate performSelectorOnMainThread:@selector(onSQLComplete:) withObject:info  waitUntilDone:NO];  
    }
    [currentSQL release];
    [pool release];
}
-(void)updateSQL
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    NSString* currentSQL = self.sqlCommand;
    [currentSQL retain];
	// Check if the database has already been created in the users filesystem
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // check is database is really exist before execute sql command
	if([fileManager fileExistsAtPath:self.databasePath] )
    {
        EGODatabase* database = [EGODatabase databaseWithPath:self.databasePath];
        [database executeUpdate:currentSQL];
    }
    
    [self->delegate onSQLUpdateComplete];
    [currentSQL release];
    [pool release];
}
-(void)prepareSQL:(NSString*)sql withDB:(NSString*)database 
{   
    // set the sql command and the sql path for query sql command
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	self.databasePath = [documentsDir stringByAppendingPathComponent:database];
    self.databaseName = database;
    self.sqlCommand = sql;
    
    [self checkAndCreateDatabase];
    
}
- (void)checkAndCreateDatabase {
	// Create a FileManager object, we will use this to check the status
    // of the database and to copy it over if required
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //NSLog(self.databasePath);
    // Check if the database has already been created in the users filesystem
    BOOL success = [fileManager fileExistsAtPath:self.databasePath];
    
    // If the database already exists then return without doing anything
    if(success) 
    {
        return;
    }
    
    // If not then proceed to copy the database from the application to the users filesystem
    
    // Get the path to the database in the application package
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseName];
    
    // Copy the database from the package to the users filesystem
    [fileManager copyItemAtPath:databasePathFromApp toPath:self.databasePath error:nil];
    
}
#pragma mark memory management
-(void) unBindDelegate
{
   self->delegate = nil; 
}
-(void) dealloc
{   
    self->delegate = nil;
    [self.databaseName release];
    [self.databasePath release];
    [self.sqlCommand release];
    [super dealloc];
}
@end
