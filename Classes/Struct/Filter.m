//
//  Filter.m
//  MoneyMe
//
//  Created by Tong on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Filter.h"
#import "TransType.h"
#import "Period.h"
#import "PaymentType.h"
#import "Transaction.h"

@implementation Filter
@synthesize filterID,filterName,filterTypeName,filterValue,IsSelected;

-(id)initFilter:(int)_filterID withFilterTypeName:(NSString*)_filterTypeName withFilterObject:(id)_filterObj
{
    self = [super init];
    if(self){
        self->filterID = _filterID;
        self->filterTypeName = _filterTypeName;
        [self->filterTypeName retain];
        self.filterValue = _filterObj;
        self.IsSelected = NO;
        [self updateFilterName];
         }
    
    return self;
}
-(void)updateFilterName
{
    if(filterName != nil)
    {
         [self->filterName release];
    }
    
    switch (self->filterID) {
            //Tran type
        case 0:
        {
            TransType* trans = (TransType*) self.filterValue;
            self->filterName = trans.transTypename;
            break;
        }
            //Period type
        case 1:
        {
            Period* period = (Period*) self.filterValue;
            self->filterName = period.periodName;
            break;
        }
            //Payment type
        case 2:
        {
            PaymentType* payment = (PaymentType*) self.filterValue;
            self->filterName  = payment.paymentTypename;
            break;
        }
            //Tran Name type
        case 3:
        {
            NSString* name = (NSString*) self.filterValue;
            self->filterName = name;
            break;
        }
            
        default:
            break;
    }
    [self->filterName retain];
    
}
-(void)updateFiterValue:(id)value
{
    self.filterValue = value;
     [self updateFilterName];
}
-(NSMutableArray*) performFilter:(NSMutableArray*)list;
{   
    NSMutableArray* filterArr = [[NSMutableArray alloc]init];
    switch (self->filterID) {
            //Tran type
        case 0:
        {
            TransType* trans = (TransType*) self.filterValue;
            for(Transaction* transaction in list)
            {
                if(transaction.transTypeID == trans.transTypeId)
                {
                    [filterArr addObject:transaction];
                }
                
            }
            break;
        }
            //Period type
        case 1:
        {
            Period* period = (Period*) self.filterValue;
            for(Transaction* transaction in list)
            {
                if([period isInPeriod:transaction.date])
                {
                    [filterArr addObject:transaction];
                }
                
            }
            break;
        }
            //Payment type
        case 2:
        {
            PaymentType* payment = (PaymentType*) self.filterValue;
            for(Transaction* transaction in list)
            {
                if(transaction.paymentType == payment.paymentTypeId)
                {
                    [filterArr addObject:transaction];
                }
                
            }
            break;
        }
            //Tran Name type
        case 3:
        {
            NSString* name = (NSString*) self.filterValue;
            for(Transaction* transaction in list)
            {
                
                NSRange textRange;
                textRange =[transaction.name rangeOfString:name];
                
                if(textRange.location != NSNotFound)
                {
                    
                     [filterArr addObject:transaction];
                }
                
                
            }
            break;
        }
            
        default:
            break;
    }
    return filterArr;
}
-(void) dealloc
{
    [filterName release];
    [filterValue release];
    [filterTypeName release];
    [super dealloc];
}
@end
