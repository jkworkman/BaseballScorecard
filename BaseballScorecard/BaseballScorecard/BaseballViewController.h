//
//  BaseballViewController.h
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/9/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameDataController.h"
#import "Quartz2D.h"

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
- (IBAction)RunnerToSecond:(id)sender;
- (IBAction)RunnerToThird:(id)sender;
- (IBAction)RunnerScores:(id)sender;
- (IBAction)RunnerOut:(id)sender;
- (IBAction)RunnerStaysOnBase:(id)sender;


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
@property (weak, nonatomic) IBOutlet UIButton *RunnerToSecondLabel;
@property (weak, nonatomic) IBOutlet UIButton *RunnerToThirdLabel;
@property (weak, nonatomic) IBOutlet UIButton *RunnerScoresLabel;
@property (weak, nonatomic) IBOutlet UIButton *RunnerOutLabel;
@property (weak, nonatomic) IBOutlet UIButton *RunnerStaysOnBaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *RunnerAdvancingLabel;

-(void)RunnerAdvancing;

-(void)ShowMainMenu;
-(void)ShowSubMenu;
-(void)ShowBaseRunnerMenu;
-(void)HideAllMenu;
-(void)Refresh;
-(void)SetLabels;

-(void) CallLog;

@end
