//
//  SingletonData.h
//  MoneyMe
//
//  Created by Tong on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "TransType.h"
#import "PaymentType.h"
#import "Period.h"
#import "NSDate+Calculate.h"
#import "SQLHandler.h"
#import "Transaction.h"
#import "SequenceType.h"
#import "DisplayBoard.h"

 typedef enum PaidType {
	EClothes=0, EFAndB, EUtility, EEtc, ETransport,EActivity
} PaidType;

typedef enum Paid
{
    ECash = 0,ECreditCard,ELoan,ECoupon
}PaidCondition;

typedef enum SortType
{
    EDate= 0,EPriceAscending,EPriceDescending,EName
}SortType;



@interface SingletonData : NSObject<ISQLUpdate> {

	User* user;
    NSMutableArray* transTypeList;
    NSMutableArray* paymentTypeList;
    NSMutableArray* commonPaidName;
    NSMutableArray* periodTypeList;
    NSMutableArray* currencyList;
    NSMutableArray* sequenceTransList;
    NSMutableArray* sequenceList;
    NSMutableArray* displayBoardList;
    NSMutableArray* favoriteList;
    SortType sortType;
    NSString* currencyCode;
    
    NSDate* seqUpdateTime;
    
    SQLHandler* sqlHandler;
    
}
@property (nonatomic,retain)User* user;
@property (nonatomic,retain) NSMutableArray* favoriteList;
@property (nonatomic,retain)NSMutableArray* transTypeList;
@property (nonatomic,retain)NSMutableArray* paymentTypeList;
@property (nonatomic,retain)NSMutableArray* periodTypeList;
@property (nonatomic,retain)NSMutableArray* currencyList;
@property (nonatomic,retain)NSMutableArray* sequenceTransList;
@property (nonatomic,retain)NSMutableArray* sequenceList;
@property (nonatomic,copy) NSString* currencyCode;
@property (nonatomic,assign) SortType sortType;
@property (nonatomic,retain) NSMutableArray* commonPaidName;
@property (nonatomic,retain)SQLHandler* sqlHandler;
@property (nonatomic,retain) NSDate* seqUpdateTime;
@property (nonatomic,retain) NSMutableArray* displayBoardList;
+ (SingletonData*) object;
-(void) loadUser;
-(void) loadCommonNameList;
-(void) loadPaymentTypeList;
-(void) loadTransTypeList;
-(void) loadDisplayBoardData;
-(void) loadSeqTransList;
-(void) loadFavList;
-(void) saveCurrency;
-(void) savePaidNameList;
-(void) saveUser;
-(void) setLocaleCurrency;
-(void) saveTransType;
-(void) savePaymentType;
-(void) savePeriodList;
-(void) saveSeqTransList;
-(void) saveSeqDate;
-(void) saveDisplayBoard;
-(void) saveFavList;

-(void) createPeriodList;
-(void) createSeqList;

-(void) initCurrencyList;
-(NSString*) getTransTypeforID:(int)_id;
-(NSString*) getPaymentTypeforID:(int)_id;

-(void)performSequenceTask;
-(void)updateSequence;
-(void)execSequence:(Transaction*)trans withDate:(NSDate*)_date;
@end
