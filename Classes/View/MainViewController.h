//
//  MainViewController.h
//  MoneyMe
//
//  Created by Tong on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "SQLHandler.h"
#import "ISQLUpdate.h"
#import "StatisticViewController.h"
#import "DisplayBoardItemView.h"
#import "GraphView.h"
#import "CoreGraphProvider.h"
#import "IGraphHandler.h"   

@interface MainViewController : UIViewController  <ISQLUpdate,UIScrollViewDelegate,IDisplayItemHandler,IGraphHandler> {
    
    IBOutlet UILabel* userLabel;

    IBOutlet UIButton* quickPaidButton;
    IBOutlet UIButton* transactionButton;
    IBOutlet UIButton* statisticButton;
    IBOutlet UIButton* optionButton;
    
    IBOutlet UIButton* displayManageButton;
    
    IBOutlet UIView* displayBoardView;
    
    IBOutlet UIView* portraitView;
    IBOutlet UIView* landScapeView;
    
    IBOutlet GraphView* dailyGraphView;
    IBOutlet GraphView* weeklyGraphView;
     IBOutlet GraphView* monthlyGraphView;
    
    SQLHandler* sqlHandler;
    int counter;
    CoreGraphProvider* coreGraphProvider;
    
}
@property (nonatomic,retain) IBOutlet GraphView* dailyGraphView; 
@property (nonatomic,retain) IBOutlet GraphView* weeklyGraphView; 
@property (nonatomic,retain) IBOutlet GraphView* monthlyGraphView; 

@property (nonatomic,retain) IBOutlet UIView* portraitView;
@property (nonatomic,retain) IBOutlet UIView* landScapeView;
@property (nonatomic,retain) IBOutlet UIView* displayBoardView;

@property (nonatomic,retain) IBOutlet UIButton* quickPaidButton;
@property (nonatomic,retain) IBOutlet UIButton* transactionButton;
@property (nonatomic,retain) IBOutlet UIButton* statisticButton;
@property (nonatomic,retain) IBOutlet UIButton* optionButton;

@property (nonatomic,retain)IBOutlet UILabel* userLabel;

-(void) loadStatisticData;

-(IBAction)pressBoard:(id)sender;

-(IBAction)quickpaidClicked:(id)sender;
-(IBAction)transactionClicked:(id)sender;
-(IBAction)statisticClicked:(id)sender;
-(IBAction)optionClicked:(id)sender;
-(IBAction)pressBoard:(id)sender;



-(void) createShadow;
@end
