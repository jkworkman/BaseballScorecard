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

@interface BaseballViewController : UIViewController <UIActionSheetDelegate>

- (IBAction)ThrowPitch:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *PitchedBallLabel;
@property (weak, nonatomic) IBOutlet UILabel *NumInningLabel;
@property (weak, nonatomic) IBOutlet UILabel *HomeScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *AwayScoreLabel;



-(void)RunnerAdvancing;

-(void)ShowPitchCountMenu;
-(void)ShowHitMenu;
-(void)RunnerOnFirstMenu;
-(void)RunnerOnSecondMenu;
-(void)RunnerOnThirdMenu;

-(void)Refresh;
-(void)CallLog;
-(void)StartNewGame;

-(void)LoadFromPlist;

@end
