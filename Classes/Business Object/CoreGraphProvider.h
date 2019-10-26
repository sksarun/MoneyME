//
//  CoreGraphProvider.h
//  MoneyMe
//
//  Created by ศรัณย์ กฤษณะโลม on 10/23/54 BE.
//  Copyright (c) 2554 Agoda.co.ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLHandler.h"
#import "Period.h"
#import "StatisticList.h"
#import "IGraphHandler.h"

@interface CoreGraphProvider : NSObject<ISQLUpdate>
{
    NSMutableArray* dailyGraph;
     NSMutableArray* weeklyGraph;
     NSMutableArray* monthlyGraph;
    SQLHandler* sqlHandler;
    
    //period display
    PeriodType period;
    StatisticType statisticType;
    NSMutableArray* periodList;
    
    int index;
    int typeindex;
    
    id<IGraphHandler> delegate;
}

@property (nonatomic,retain) NSMutableArray* dailyGraph;
@property (nonatomic,retain) NSMutableArray* weeklyGraph;
@property (nonatomic,retain) NSMutableArray* monthlyGraph;
@property (nonatomic,assign) PeriodType period;
@property (nonatomic,assign)  id<IGraphHandler> delegate;
@property (nonatomic,retain) NSMutableArray* periodList;

-(void) loadTransSQL;
-(void) createPaymentStatistic;
-(void) relocateList;


-(BOOL)shouldLoopNextRound;



@end
