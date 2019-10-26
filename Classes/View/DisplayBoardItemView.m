//
//  DisplayBoardItemView.m
//  MoneyMe
//
//  Created by Tong on 10/2/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "DisplayBoardItemView.h"
#import "SingletonData.h"

@implementation DisplayBoardItemView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame withIndex:(int)_index withName:(NSString*)name withAmount:(int) amount
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 , 10, 167, 21)];
        nameLabel.text = name;
        nameLabel.font= [UIFont boldSystemFontOfSize:14];
        nameLabel.textAlignment = UITextAlignmentLeft;
        nameLabel.backgroundColor = [UIColor clearColor];
        
        
        UILabel* amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(128, 10, 107, 21)];
        amountLabel.text = [NSString stringWithFormat:@"%d %@",amount,[SingletonData object].currencyCode];
        amountLabel.font= [UIFont boldSystemFontOfSize:14];
        amountLabel.textColor = [UIColor lightGrayColor];
        amountLabel.textAlignment = UITextAlignmentRight;
        amountLabel.backgroundColor = [UIColor clearColor];
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [button addTarget:self action:@selector(onDisplaySelected:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:nameLabel];
        [self addSubview:amountLabel]; 
        [self addSubview:button]; 
        [nameLabel release];
        [amountLabel release];
        
        self->index = _index;
    }
    return self;
}

-(void)onDisplaySelected:(id)sender
{
    if(self.delegate)
    {
        [self.delegate onDisplayBoardSelected:self->index];
    }
}

@end
