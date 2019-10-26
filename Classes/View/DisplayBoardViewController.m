//
//  DisplayBoardViewController.m
//  MoneyMe
//
//  Created by Tong on 9/7/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "DisplayBoardViewController.h"
#import "SingletonData.h"

@implementation DisplayBoardViewController
@synthesize table,titleLabel,replaceMember;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Display Board";
    self.titleLabel.text = @"Current display items";
    // Do any additional setup after loading the view from its nib.
}
-(void)dealloc
{
    self.replaceMember = nil;
    [self.titleLabel release];
    [self.table release];
    [super dealloc];
}
#pragma mark TableView


//return the UITableViewCell for each row of the searchView component
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"displayCell"]; 
    if (cell == nil) { 
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"displayCell"] autorelease];
    } 
    int count = 0;
    if(self->isReplaceData)
    {
        for(DisplayBoard* dp in [SingletonData object].displayBoardList)
        {
            if( !dp.isSelected )
            {
                if(count == indexPath.row)
                {
                    cell.textLabel.text = dp.displayName;
                    break;
                }
                count++;
            }
        }
    }
    else
    {
        for(DisplayBoard* dp in [SingletonData object].displayBoardList)
        {
            if( dp.isSelected )
            {
                if(count == indexPath.row)
                {
                    cell.textLabel.text = dp.displayName;
                    break;
                }
                count++;
            }
        }
    }
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int count = 0;
    if(self->isReplaceData)
    {
        for(DisplayBoard* dp in [SingletonData object].displayBoardList)
        {
            if( !dp.isSelected )
            {
                if(count == indexPath.row)
                {
                    for(DisplayBoard* dpOld in [SingletonData object].displayBoardList)
                    {
                        if( [dpOld.displayName isEqualToString:self.replaceMember])
                        {
                            dpOld.isSelected = NO;
                        }
                        else if([dpOld.displayName isEqualToString:dp.displayName])
                        {
                            dpOld.isSelected = YES;
                        }
                    }
                    self->isReplaceData = NO;
                    [[SingletonData object] saveDisplayBoard];
                    self.titleLabel.text = @"Current display items";
                    [UIView beginAnimations:nil context:NULL];
                    [UIView setAnimationDuration:0.5];
                    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.table cache:YES];
                    [UIView commitAnimations];
                    [self.table reloadData];
                    break;
                }
                else
                {
                    count++;
                }
               
            }
        }
    }
    else
    {
        for(DisplayBoard* dp in [SingletonData object].displayBoardList)
        {
            if(dp.isSelected )
            {
                if(count == indexPath.row)
                {
                    self.replaceMember = dp.displayName;
                    self->isReplaceData = YES;
                    self.titleLabel.text = @"please select display item.";
                    [UIView beginAnimations:nil context:NULL];
                    [UIView setAnimationDuration:0.5];
                    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.table cache:YES];
                    [UIView commitAnimations];
                    [self.table reloadData];
                    break;
                }
                else
                {
                    count++;
                }
            }
        }
    }
}
//return the section for the Searchview Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//we have 3 section for this view
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = 0;
    if(self->isReplaceData)
    {
        for(DisplayBoard* dp in [SingletonData object].displayBoardList)
        {
           if( !dp.isSelected )
           {
               count++;
           }
        }
    }
    else
    {
        for(DisplayBoard* dp in [SingletonData object].displayBoardList)
        {
            if( dp.isSelected )
            {
                count++;
            }
        }
    }
    return  count;
}
@end
