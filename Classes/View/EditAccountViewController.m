//
//  EditAccountViewController.m
//  MoneyMe
//
//  Created by Tong on 9/7/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "EditAccountViewController.h"
#import "SingletonData.h"


@implementation EditAccountViewController
@synthesize nameTextField;
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Account";
    SingletonData* data = [SingletonData object];
    self.nameTextField.text = data.user.name;
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonItemStyleDone
                                               target:self 
                                               action:@selector(doneClicked)]
                                              autorelease];
    // Do any additional setup after loading the view from its nib.
}
-(void)doneClicked
{
    // done clicked button to save user data
    
    SingletonData* data = [SingletonData object];
    data.user.name = self.nameTextField.text;
    [data saveUser];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)dealloc
{
    self.nameTextField = nil;
    [super dealloc];
}
@end
