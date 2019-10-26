//
//  SequenceType.h
//  MoneyMe
//
//  Created by Tong on 9/4/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SequenceType : NSObject
{
int seqTypeId;
NSString* seqTypename;
}

@property (nonatomic,retain) NSString* seqTypename;
@property (nonatomic,assign) int seqTypeId;

-(id) initWithType:(int)type_id withName:(NSString*) type_name;
@end

