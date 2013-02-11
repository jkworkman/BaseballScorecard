//
//  BaseballViewController.h
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/9/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameDataController.h"

@class GameDataController;

@interface BaseballViewController : UIViewController
- (IBAction)PitchedBall:(id)sender;
- (IBAction)PitchedStrike:(id)sender;
- (IBAction)HitBall:(id)sender;
- (IBAction)HitSingle:(id)sender;
- (IBAction)HitDouble:(id)sender;
- (IBAction)HitTriple:(id)sender;
- (IBAction)HitHomeRun:(id)sender;
- (IBAction)HitOut:(id)sender;



@property (weak, nonatomic) IBOutlet UILabel *PitchedBallLabel;
@property (weak, nonatomic) IBOutlet UILabel *PitchedStrikeLabel;
@property (weak, nonatomic) IBOutlet UILabel *RecordedOutLabel;
@property (weak, nonatomic) IBOutlet UILabel *SideInningLabel;
@property (weak, nonatomic) IBOutlet UILabel *NumInningLabel;
@property (weak, nonatomic) IBOutlet UIButton *BallButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *StrikeButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *HitButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *HitSingleOutlet;
@property (weak, nonatomic) IBOutlet UIButton *HitDoubleOutlet;
@property (weak, nonatomic) IBOutlet UIButton *HitTripleOutlet;
@property (weak, nonatomic) IBOutlet UIButton *HitHomeRunOutlet;
@property (weak, nonatomic) IBOutlet UIButton *HitOutOutlet;
@property (weak, nonatomic) IBOutlet UILabel *HomeScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *AwayScoreLabel;

@property (strong, nonatomic) GameDataController *dataController;

-(void)ShowMainMenu;
-(void)ShowSubMenu;
-(void)Refresh;

@end
