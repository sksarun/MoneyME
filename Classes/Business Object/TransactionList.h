//
//  TransactionList.h
//  MoneyMe
//
//  Created by Tong on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TransactionList : NSObject {
    
    NSMutableArray* transactionList;
    NSMutableArray* displayList;
    NSMutableArray* filterList;
}
@property (nonatomic,retain) NSMutableArray* transactionList;
@property (nonatomic,retain) NSMutableArray* displayList;
@property (nonatomic,retain) NSMutableArray* filterList;

-(void) createFilterList;
-(void) applyFilter;
-(void) sortByKey:(NSString*)key isAscending:(BOOL)ascending;
-(void) doSort;
@end
