//
//  CustomDatePicker.h
//  MoneyMe
//
//  Created by Tong on 7/21/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "IDatePickerUpdate.h"

@interface CustomDatePicker : NSObject <UIActionSheetDelegate> {
    
	id<IDatePickerUpdate> delegate;
	
	//Action sheet instance and datapicker for select arrive data and depart date
	UIActionSheet *aac;
	UIDatePicker *theDatePicker;
	int tag;
    
}

-(id) initWithDate:(NSDate*)date  withDelegate:(id<IDatePickerUpdate>)callback  withTitle:(NSString*)title withTag:(int)calltag;
-(void) show;

-(void)datePopupDone;
@end

