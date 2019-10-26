//
//  Trans_Type.h
//  MoneyMe
//
//  Created by Tong on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TransType : NSObject {
    
    int transTypeId;
    NSString* transTypename;
}

@property (nonatomic,retain) NSString* transTypename;
@property (nonatomic,assign) int transTypeId;

-(id) initWithType:(int)type_id withName:(NSString*) type_name;
@end
