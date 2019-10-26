//
//  GraphView.h
//  MoneyMe
//
//  Created by Tong on 10/12/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECGraph.h"
@interface GraphView : UIView<ECGraphDelegate>
{
    NSArray* graphlists;
}
@property (nonatomic,retain) NSArray* graphlists;

-(void) updateObject:(NSArray*)graph;
@end
