//
//  IFilterHandler.h
//  MoneyMe
//
//  Created by Tong on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol IFilterHandler <NSObject>

-(void)onFilterUpdate:(NSMutableArray*)_filters;

@end
