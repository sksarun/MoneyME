//
//  DisplayBoardItemView.h
//  MoneyMe
//
//  Created by Tong on 10/2/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDisplayItemHandler.h"

@interface DisplayBoardItemView : UIView
{
    int index;
    id<IDisplayItemHandler> delegate;
}

@property (nonatomic,assign) id<IDisplayItemHandler> delegate;

-(void)onDisplaySelected:(id)sender;
- (id)initWithFrame:(CGRect)frame withIndex:(int)_index withName:(NSString*)name withAmount:(int) amount;
@end
