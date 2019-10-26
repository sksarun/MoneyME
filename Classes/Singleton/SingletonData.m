//
//  SingletonData.m
//  MoneyMe
//
//  Created by Tong on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SingletonData.h"
#import "NSDate+Component.h"
#import "SequenceTransaction.h"
#import "NSDate+Component.h"
#import "NSDate+Calculate.h"

@implementation SingletonData
@synthesize sequenceList,currencyList,periodTypeList,user,transTypeList,currencyCode,commonPaidName,paymentTypeList,sortType,sequenceTransList,sqlHandler,seqUpdateTime,displayBoardList,favoriteList;

static SingletonData* config = nil;
//get the System data from plist
+ (SingletonData*) object
{
	@synchronized(self) {
		
		if(config == nil) {
			// assign the config instance at first seen
			config = [[SingletonData alloc] init];	
		}
		
		return config;
	}
}

#pragma mark init
-(id) init
{
	self = [super init];
	if(self)
	{
        self.sortType = EDate;
        self->sqlHandler = [[SQLHandler alloc] init];
		[self loadUser];
        [self initCurrencyList];
        
        
	}
	return self;
}
- (id)retain {
    return self;
}

- (NSUInteger)retainCount {
    return UINT_MAX;  // denotes an object that cannot be released
}

- (void)release {
    //do nothing
}

- (id)autorelease {
    return self;
}
-(void) initCurrencyList
{
    self->currencyList = [[NSMutableArray  alloc] init];
    [self->currencyList addObject:@"USD"];
    [self->currencyList addObject:@"JPY"];
    [self->currencyList addObject:@"THB"];
    [self->currencyList addObject:@"HKD"];
    [self->currencyList addObject:@"AED"];
    [self->currencyList addObject:@"SGD"];
    [self->currencyList addObject:@"AUD"];
    [self->currencyList addObject:@"GBP"];
    [self->currencyList addObject:@"CNY"];
    [self->currencyList addObject:@"EUR"];
    [self->currencyList addObject:@"INR"];
    [self->currencyList addObject:@"KRW"];
    [self->currencyList addObject:@"MYR"];
    [self->currencyList addObject:@"MXN"];
    [self->currencyList addObject:@"CHF"];
    [self->currencyList addObject:@"CNY"];
    [self->currencyList addObject:@"VND"];
    
}
-(void) setLocaleCurrency
{
    NSLocale* locale = [[[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale currentLocale] localeIdentifier] ]autorelease];
    NSNumberFormatter* fmtr = [[[NSNumberFormatter alloc] init] autorelease];
    [fmtr setNumberStyle:NSNumberFormatterCurrencyStyle];
    [fmtr setLocale:locale];
    
    self.currencyCode = [fmtr currencyCode];
}
-(void)saveUser
{
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
	[prefs setObject:[NSKeyedArchiver archivedDataWithRootObject:self.user] forKey:@"User"];
	
	[prefs synchronize];
	
}

-(void) saveTransType
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:self.transTypeList] forKey:@"transTypeArray"];
}
-(void)savePaymentType
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:self.paymentTypeList] forKey:@"paymentTypeArray"];
}
-(void) savePaidNameList
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:self.commonPaidName] forKey:@"commonNameArray"];
}
-(void) savePeriodList
{
    //[[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:self.commonPaidName] forKey:@"commonNameArray"];
}
-(void) saveSeqTransList
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:self.sequenceTransList] forKey:@"seqArray"];
    [self saveSeqDate];
}
-(void) saveSeqDate
{
    self.seqUpdateTime = [NSDate date];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs setObject:self.seqUpdateTime forKey:@"updateTime"];
    
    [prefs synchronize];
}
-(void) saveCurrency
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
	[prefs setObject:self.currencyCode forKey:@"Currency"];
	[prefs synchronize];
}
-(void) loadDisplayBoardData
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *displayBoardSavedArray = [prefs objectForKey:@"displayBoardList"];
    if (displayBoardSavedArray != nil)
    {
        NSArray *nameSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:displayBoardSavedArray];
        if (nameSavedArray != nil)
        {
            self->displayBoardList = [[NSMutableArray alloc] initWithArray:nameSavedArray];
        }
    }
    else
    {

        
        self->displayBoardList = [[NSMutableArray alloc] init];
        
        DisplayBoard* dailyDisplayBoardItem = [[DisplayBoard alloc] initWithDisplayType:YES  withName:@"Daily paid"];
        DisplayBoard* weeklyDisplayBoardItem = [[DisplayBoard alloc] initWithDisplayType:YES  withName:@"Weekly paid" ];
        DisplayBoard* monthDisplayBoardItem = [[DisplayBoard alloc] initWithDisplayType:YES withName:@"Monthly paid" ];
        DisplayBoard* totalDisplayBoardItem = [[DisplayBoard alloc] initWithDisplayType:NO withName:@"Total paid" ];
        DisplayBoard* maxdailyDisplayBoardItem = [[DisplayBoard alloc] initWithDisplayType:NO withName:@"Most paid of the day"];
        DisplayBoard* maxweeklyDisplayBoardItem = [[DisplayBoard alloc] initWithDisplayType:NO withName:@"Most paid of the week" ];
        DisplayBoard* maxmonthlyDisplayBoardItem = [[DisplayBoard alloc] initWithDisplayType:NO withName:@"Most paid of the month"];
        
        [self->displayBoardList addObject:dailyDisplayBoardItem];
        [self->displayBoardList addObject:weeklyDisplayBoardItem];
        [self->displayBoardList addObject:monthDisplayBoardItem];
        [self->displayBoardList addObject:totalDisplayBoardItem];
         [self->displayBoardList addObject:maxdailyDisplayBoardItem];
         [self->displayBoardList addObject:maxweeklyDisplayBoardItem];
         [self->displayBoardList addObject:maxmonthlyDisplayBoardItem];
        
        [dailyDisplayBoardItem release];
        [weeklyDisplayBoardItem release];
        [monthDisplayBoardItem release];
        [totalDisplayBoardItem release];
        [maxdailyDisplayBoardItem release];
        [maxweeklyDisplayBoardItem release];
        [maxmonthlyDisplayBoardItem release];
        [self saveDisplayBoard];
    }
}
-(void) saveDisplayBoard
{
     [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:self.displayBoardList] forKey:@"displayBoardList"];
}
-(void)loadFavList
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *FavSavedArray = [prefs objectForKey:@"favArray"];
    if (FavSavedArray != nil)
    {
        NSArray *favSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:FavSavedArray];
        if (favSavedArray != nil)
        {
            self->favoriteList = [[NSMutableArray alloc] initWithArray:favSavedArray];
        }
    }
    else
    {
        self->favoriteList = [[NSMutableArray alloc] init];
    }
}
-(void)saveFavList
{
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:self.favoriteList] forKey:@"favArray"];
}
-(void)loadSeqTransList
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *SeqSavedArray = [prefs objectForKey:@"seqArray"];
    if (SeqSavedArray != nil)
    {
        NSArray *seqSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:SeqSavedArray];
        if (seqSavedArray != nil)
        {
            self->sequenceTransList = [[NSMutableArray alloc] initWithArray:seqSavedArray];
        }
    }
    else
    {
        self->sequenceTransList = [[NSMutableArray alloc] init];
    }
    
    self.seqUpdateTime = (NSDate*) [prefs objectForKey:@"updateTime"];
    if(self.seqUpdateTime == nil)
    {
        [self saveSeqDate];
    }
}
-(void) loadCommonNameList
{
     NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *commonNameSavedArray = [prefs objectForKey:@"commonNameArray"];
    if (commonNameSavedArray != nil)
    {
        NSArray *nameSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:commonNameSavedArray];
        if (nameSavedArray != nil)
        {
            self->commonPaidName = [[NSMutableArray alloc] initWithArray:nameSavedArray];
        }
    }
    else
    {
        self->commonPaidName = [[NSMutableArray alloc] init];
    }
}
-(void)createPeriodList
{
    //create Period List
    
    self->periodTypeList = [[NSMutableArray alloc]init];
    // Period today date
    Period* todayPeriod = [[Period alloc]initPeriod:0 withPeriodName:@"Today" withStartDate:[NSDate date] withEndDate:[NSDate date]];
    
    Period* weeklyPeriod = [[Period alloc]initPeriod:1 withPeriodName:@"Weekly" withStartDate:[[NSDate date]firstDayInWeek] withEndDate:[[NSDate date]lastDayInWeek]];
    //Period monthly
    Period* monthlyPeriod = [[Period alloc]initPeriod:2 withPeriodName:@"Monthly" withStartDate:[[NSDate date]firstDayMonth] withEndDate:[[NSDate date]lastDayMonth]]; 
    
    //Period custom 
    Period* customPeriod  = [[Period alloc]initPeriod:2 withPeriodName:@"Custom" withStartDate:[NSDate date] withEndDate:[[NSDate date]nextDate:30]];  
    
    [self.periodTypeList addObject:todayPeriod];
    [self.periodTypeList addObject:weeklyPeriod];
    [self.periodTypeList addObject:monthlyPeriod];
    [self.periodTypeList addObject:customPeriod];
}
-(void)createSeqList
{
    self->sequenceList = [[NSMutableArray alloc]init];
    [self->sequenceList addObject:[[[SequenceType alloc]initWithType:0 withName:@"Everyday"]autorelease]];
    [self->sequenceList addObject:[[[SequenceType alloc]initWithType:1 withName:@"Weekday"] autorelease]];
    [self->sequenceList addObject:[[[SequenceType alloc]initWithType:2 withName:@"Weekend"]autorelease ]];
    [self->sequenceList addObject:[[[SequenceType alloc]initWithType:3 withName:@"First of month"]autorelease ]];
    [self->sequenceList addObject:[[[SequenceType alloc]initWithType:4 withName:@"Last of month"]autorelease ]];
    [self->sequenceList addObject:[[[SequenceType alloc]initWithType:5 withName:@"Weekly"]autorelease] ];
    [self->sequenceList addObject:[[[SequenceType alloc]initWithType:6 withName:@"Monthly"] autorelease]];
}
-(void) loadPaymentTypeList
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    //load paymentType
    NSData *paymentSavedArray = [prefs objectForKey:@"paymentTypeArray"];
    if (paymentSavedArray != nil)
    {
        NSArray *paymentoldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:paymentSavedArray];
        if (paymentoldSavedArray != nil)
        {
            self->paymentTypeList = [[NSMutableArray alloc] initWithArray:paymentoldSavedArray];
        }
    }
    else
    {
        self->paymentTypeList = [[NSMutableArray alloc] init];
        // create default payment 
        PaymentType* cash = [[[PaymentType alloc] initWithType:0 withName:@"Cash"] autorelease];
        PaymentType* credit = [[[PaymentType alloc] initWithType:1 withName:@"Credit Card"] autorelease];
        [self.paymentTypeList addObject:cash];
        [self.paymentTypeList addObject:credit];
        
        
        [self savePaymentType];
    }
}
-(void) loadTransTypeList
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *dataRepresentingSavedArray = [prefs objectForKey:@"transTypeArray"];
    if (dataRepresentingSavedArray != nil)
    {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil)
        {
            self.transTypeList = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        }
    }
    else
    {
        self->transTypeList = [[NSMutableArray alloc] init];
        // create default trans 
        TransType* transfood = [[[TransType alloc] initWithType:0 withName:@"Foods"] autorelease];
        TransType* transclothes = [[[TransType alloc] initWithType:1 withName:@"Clothes"] autorelease];
        TransType* transutility = [[[TransType alloc] initWithType:2 withName:@"Utility"] autorelease];
        TransType* transaccesory = [[[TransType alloc] initWithType:3 withName:@"Accessory"] autorelease];
        TransType* transelectronic = [[[TransType alloc] initWithType:4 withName:@"Electronics"] autorelease];
        [self.transTypeList addObject:transfood];
        [self.transTypeList addObject:transclothes];
        [self.transTypeList addObject:transutility];
        [self.transTypeList addObject:transaccesory];
        [self.transTypeList addObject:transelectronic];
        
        [self saveTransType];
    }

}
-(void)loadUser
{	
    
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSData* encodeObj = [prefs objectForKey:@"User"];
	self.user = (User*)[NSKeyedUnarchiver unarchiveObjectWithData:encodeObj];
    self.currencyCode = [prefs stringForKey:@"Currency"];
    if(self.currencyCode == nil)
    {
        [self setLocaleCurrency];
    }
    [self createPeriodList];
    [self loadTransTypeList];
    [self loadPaymentTypeList];
    [self createSeqList];
    [self loadCommonNameList];
    [self loadSeqTransList];
    [self loadDisplayBoardData];
    [self loadFavList];
}
-(void)performSequenceTask
{
    if(![self.seqUpdateTime isSameDate:[NSDate date]])
    {
        self.seqUpdateTime = [ self.seqUpdateTime nextDay:1];
        [self updateSequence];
    }
}
-(NSString*) getPaymentTypeforID:(int)_id
{
    for(PaymentType* payment in self.paymentTypeList  )
    {
        if(payment.paymentTypeId == _id)
        {
            return payment.paymentTypename;
        }
    }
    return  @"";
}
-(NSString*) getTransTypeforID:(int)_id
{
    for(TransType* tran in self.transTypeList  )
    {
        if(tran.transTypeId == _id)
        {
            return tran.transTypename;
        }
    }
    return  @"";
}
-(void)updateSequence
{
    for(SequenceTransaction* seq in self.sequenceTransList)
    {
        NSDate* updateDate = self.seqUpdateTime;
        NSDate* curDate = [NSDate date];
        while([updateDate compare:curDate] == NSOrderedAscending || [updateDate isSameDate:curDate])
        {
            switch (seq.seqType) {
                case EEveryday:
                    [self execSequence:seq withDate:updateDate]; 
                    break;
                case EWeekday:
                    if([updateDate isWeekDay])
                    {
                        [self execSequence:seq withDate:updateDate];
                    }
                    break;
                case EWeekend:
                    if([updateDate isWeekEnd])
                    {
                        [self execSequence:seq withDate:updateDate];
                    }
                    break;
                case EFirstOfMonth :
                    if([updateDate isFirstOfMonth])
                    {
                        [self execSequence:seq withDate:updateDate];
                    }
                    break;
                case ELastOfMonth:
                    if([updateDate isEndOfMonth])
                    {
                        [self execSequence:seq withDate:updateDate];
                    }
                    break;
                default:
                    break;
            }
            updateDate = [updateDate nextDay:1];
        }

       
    }
    [self saveSeqDate];
    
}
-(void)execSequence:(Transaction*)trans  withDate:(NSDate*)_date
{
    NSString* sql = [NSString stringWithFormat:@"INSERT into Trans(Account_id,Amount,trans_type_id,payment_type_id,trans_time,trans_name,trans_desc) VALUES(1,%@,%d,%d,'%@','%@','%@');",[NSString stringWithFormat:@"%d",trans.amount],trans.transTypeID,trans.paymentType,[_date getSqlite3FirstHourTime],trans.name,trans.description];
         [self->sqlHandler prepareSQL:sql withDB:@"Trans.DB"]; 
         [self->sqlHandler updateSQL];
         
}
-(void)onSQLUpdateComplete
{
    
}
-(void)onSQLComplete:(NSDictionary*)info
{
    
}
@end
