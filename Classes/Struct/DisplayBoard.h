//
//  DisplayBoard.h
//  MoneyMe
//
//  Created by Tong on 9/8/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DisplayBoard : NSObject
{
    NSString* displayName;
    BOOL isSelected;
}
@property (nonatomic,readonly) NSString* sqlCommand;
@property (nonatomic,copy) NSString* displayName;
@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,readonly) NSString* sqlRequestCommand;

-(id) initWithDisplayType:(BOOL)_isSelected withName:(NSString*)_displayName ;
@end
