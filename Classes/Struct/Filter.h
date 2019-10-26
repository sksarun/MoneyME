//
//  Filter.h
//  MoneyMe
//
//  Created by Tong on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Filter : NSObject {
    
    int filterID;
    NSString* filterName;
    NSString* filterTypeName;
    id filterValue;
    bool IsSelected;
}
@property (nonatomic,readonly) int filterID;
@property (nonatomic,retain) NSString* filterName;
@property (nonatomic,readonly) NSString* filterTypeName;
@property (nonatomic,retain) id filterValue;
@property (nonatomic,assign) bool IsSelected;

-(id)initFilter:(int)_filterID withFilterTypeName:(NSString*)_filterTypeName withFilterObject:(id)_filterObj;
-(void)updateFilterName;
-(void)updateFiterValue:(id)value;

-(NSMutableArray*) performFilter:(NSMutableArray*)list;
@end
