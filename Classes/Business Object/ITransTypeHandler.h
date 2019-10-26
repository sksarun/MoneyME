//
//  ITransTypeHandler.h
//  MoneyMe
//
//  Created by Tong on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ITransTypeHandler 

-(void) onTransTypeSelected:(int) transId;

@end
