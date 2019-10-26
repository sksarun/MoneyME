//
//  FilterCell.m
//  MoneyMe
//
//  Created by Tong on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FilterCell.h"


@implementation FilterCell
@synthesize filterSwitch,filterName,filterType,filterID;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [self.filterSwitch release];
    [self.filterName release];
    [self.filterType release];
    [super dealloc];
}
-(void) setupFilterCell:(Filter*)filter
{
    self.filterSwitch.on  = filter.IsSelected;
    self.filterType.text = filter.filterTypeName;
    self.filterName.text = filter.filterName;
}

@end
