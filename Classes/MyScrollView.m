//
//  MyScrollView.m
//  MoneyMe
//
//  Created by Tong on 9/25/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "MyScrollView.h"



@implementation MyScrollView

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {
	
	if (!self.dragging) {
		[self.nextResponder touchesEnded:touches withEvent:event]; 
	}		
	[super touchesEnded: touches withEvent: event];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.dragging) {
		[self.nextResponder touchesBegan:touches withEvent:event]; 
	}	
    [super touchesBegan:touches withEvent:event];
}

@end
