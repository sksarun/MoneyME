//
//  FilterCell.h
//  MoneyMe
//
//  Created by Tong on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Filter.h"

@interface FilterCell : UITableViewCell {
    
    IBOutlet UISwitch* filterSwitch;
    IBOutlet UILabel* filterName;
    IBOutlet UILabel* filterType;
    int filterID;
}
@property (nonatomic,retain)IBOutlet UISwitch* filterSwitch;
@property (nonatomic,retain)IBOutlet UILabel* filterName;
@property (nonatomic,retain)IBOutlet UILabel* filterType;
@property (nonatomic,assign) int filterID;

-(void) setupFilterCell:(Filter*)filter;
@end
