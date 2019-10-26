//
//  CustomDatePicker.m
//  MoneyMe
//
//  Created by Tong on 7/21/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "CustomDatePicker.h"




@implementation CustomDatePicker

-(id) initWithDate:(NSDate*)date  withDelegate:(id<IDatePickerUpdate>)callback withTitle:(NSString*)title withTag:(int)calltag
{
	self = [super init];
	
	if(self)
	{
		self->aac = [[UIActionSheet alloc] initWithTitle:nil
												delegate:self
									   cancelButtonTitle:nil
								  destructiveButtonTitle:nil
									   otherButtonTitles:nil];
		
		self->theDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 44.0, 0.0, 0.0)];
		self->theDatePicker.datePickerMode = UIDatePickerModeDate;
        self->theDatePicker.date = date;
		self->delegate = callback;
		self->tag = calltag;
		
		UIToolbar* pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
		pickerDateToolbar.barStyle = UIBarStyleBlackOpaque;
		pickerDateToolbar.tintColor = [UIColor colorWithRed:0.11 green:0.11 blue:0.27 alpha:1.0];
		[pickerDateToolbar sizeToFit];
		
		NSMutableArray *barItems = [[NSMutableArray alloc] init];
		
		UILabel* textLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 100, 36)];
		textLabel.backgroundColor = [UIColor clearColor];
		textLabel.text = title;
		textLabel.font = [UIFont boldSystemFontOfSize:15.0];
		textLabel.textColor = [UIColor whiteColor];
		UIBarButtonItem *title = [[UIBarButtonItem alloc] initWithCustomView:textLabel];
		
		[barItems addObject:title];
		
		UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
		[barItems addObject:flexSpace];
		
		
		UIButton* selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
		selectButton.frame = CGRectMake(0, 0, 120, 35);
		[selectButton setBackgroundImage:[UIImage imageNamed:@"bt-bookit.png"] forState:UIControlStateNormal];
		[selectButton addTarget:self action: @selector(datePopupDone) forControlEvents:UIControlEventTouchUpInside];
		[selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
        selectButton.titleLabel.font =  [UIFont boldSystemFontOfSize:20.0];
		[selectButton setTitle:NSLocalizedStringWithDefaultValue(@"DatePicker_Select", nil, [NSBundle mainBundle], @"Select", "Select button text") forState:UIControlStateNormal];
        
		
		UIBarButtonItem *selectBtn = [[UIBarButtonItem alloc] initWithCustomView:selectButton];//[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonItemStyleBordered target:self action:@selector(datePopupDone)];
        
		[barItems addObject:selectBtn];
		
		[pickerDateToolbar setItems:barItems animated:YES];
		
		[textLabel release];
		[title release];
		[selectBtn release];
		[flexSpace release];
        
		[barItems release];
		
		[self->aac addSubview:pickerDateToolbar];
		[self->aac addSubview:self->theDatePicker];
		[pickerDateToolbar release];
		
	}
	return self;
}
-(void) show
{
	UIViewController* viewparent = (UIViewController*) self->delegate;
	[self->aac showInView:viewparent.view];
	[self->aac setBounds:CGRectMake(0,0,320, 464)];  
	[self retain];
}
-(void) datePopupDone
{
	//[self setdepartdate];
	[self->delegate onDatePickerUpdate:[theDatePicker date] withTag:tag];
	[self->theDatePicker release];
	[self->aac dismissWithClickedButtonIndex:0 animated:YES];
	[self->aac release];
	[self release];
}

-(void) dealloc
{
	[super dealloc];
}

@end
