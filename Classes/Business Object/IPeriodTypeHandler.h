//
//  IPeriodTypeHandler.h
//  MoneyMe
//
//  Created by Tong on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol IPeriodTypeHandler <NSObject>

-(void) onPeriodTypeSelect:(int) periodIndex;
@end
