//
//  CreatePaidTypeViewController.m
//  MoneyMe
//
//  Created by Tong on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CreatePaidTypeViewController.h"
#import "SingletonData.h"

@implementation CreatePaidTypeViewController
@synthesize navBar,doneItem,titleLabel,textField,cancelItem;


-(IBAction) onDoneClicked
{
    if([textField.text length]>0)
    {
        TransType* type = [[[TransType alloc] initWithType:[[SingletonData object].transTypeList count] withName:textField.text] autorelease];
        [[SingletonData object].transTypeList addObject:type];
        [[SingletonData object] saveTransType];
        [self dismissModalViewControllerAnimated:YES];
    }
    
}
-(IBAction) onCancelClicked
{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)dealloc
{
    [self.navBar release];
    [self.doneItem release];
    [self.cancelItem release]; 
    [self.titleLabel release];
    [self.textField release];
    [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setLocalizedText];
    // Do any additional setup after loading the view from its nib.
}

-(void) setLocalizedText
{
    self.navBar.title =  NSLocalizedString(@"QuickPaid_CellTitle_Payment Type", @"section title");
    self.doneItem.title =  NSLocalizedString(@"Common_Done", @"section title");
    self.cancelItem.title = NSLocalizedString(@"Common_Cancel", @"Cancel");
    self.titleLabel.text = NSLocalizedString(@"AddPaidType_CreateTitle", @"section title");

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [self.textField resignFirstResponder];
    }
}


@end
