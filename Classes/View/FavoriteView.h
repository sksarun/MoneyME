//
//  FavoriteView.h
//  MoneyMe
//
//  Created by Tong on 9/27/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"

@interface FavoriteView : UIView
{
    Transaction* transaction;
}
- (id)initWithFrame:(CGRect)frame withTransaction:(Transaction*)trans;

@end
