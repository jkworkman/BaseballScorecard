//
//  BaseballViewController.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/9/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "BaseballViewController.h"
#import "GameDataController.h"
#import <QuartzCore/QuartzCore.h>
#import "FPPopoverController.h"
#import "FPPopoverView.h"
#import "FPTouchView.h"

@implementation BaseballViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [self SetLabels];
    [self ShowMainMenu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PitchedBall:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    [s PitchedBall];
    [self Refresh];
    [self CallLog];
    }

- (IBAction)PitchedStrike:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    [s PitchedStrike];
    [self Refresh];
    [self CallLog];
}

- (IBAction)HitBall:(id)sender {
    [self ShowSubMenu];
}

- (IBAction)HitSingle:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    
    [s HitSingle];
    [self HideAllMenu];
    [self Refresh];
    [self CallLog];
    [self RunnerAdvancing];
}

- (IBAction)HitDouble:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    
    [s HitDouble];
    [self HideAllMenu];
    [self Refresh];
    [self CallLog];
    [self RunnerAdvancing];
}

- (IBAction)HitTriple:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    [s HitTriple];
    [self HideAllMenu];
    [self Refresh];
    [self CallLog];
    [self RunnerAdvancing];
}

- (IBAction)HitHomeRun:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    [s HitHomeRun];
    [self ShowMainMenu];
    [self Refresh];
    [self CallLog];
}

- (IBAction)HitOut:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    [s HitOut];
    [self ShowMainMenu];
    [self Refresh];
    [self CallLog];
}

- (IBAction)RunnerToSecond:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    [s RunnerToSecond];
    [self RunnerAdvancing];
}

- (IBAction)RunnerToThird:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    [s RunnerToThird];
    [self RunnerAdvancing];
}

- (IBAction)RunnerScores:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    [s RunnerScores];
    [self RunnerAdvancing];
}

- (IBAction)RunnerOut:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    [s RunnerOut];
    [self RunnerAdvancing];
}

- (IBAction)RunnerStaysOnBase:(id)sender {
}

-(void)RunnerAdvancing {
    GameDataController* s = [GameDataController sharedInstance];
    
    if(s.ThirdBase != 0)
    {
        s.tempThird = s.ThirdBase;
        _RunnerAdvancingLabel.text = @"Runner On Third";
        _RunnerAdvancingLabel.hidden = false;
        _RunnerOutLabel.hidden = false;
        _RunnerScoresLabel.hidden = false;
    }
    else if(s.SecondBase != 0)
    {
        s.tempSecond = s.SecondBase;
        _RunnerAdvancingLabel.text = @"Runner On Second";
        _RunnerAdvancingLabel.hidden = false;
        _RunnerOutLabel.hidden = false;
        _RunnerScoresLabel.hidden = false;
        if(s.TypeofHit != 3)
            _RunnerToThirdLabel.hidden = false;
    }
    else if(s.FirstBase != 0)
    {
        s.tempFirst = s.FirstBase;
        _RunnerAdvancingLabel.text = @"Runner On First";
        _RunnerAdvancingLabel.hidden = false;
        _RunnerOutLabel.hidden = false;
        _RunnerScoresLabel.hidden = false;
        if(s.TypeofHit != 3)
        {
            _RunnerToThirdLabel.hidden = false; 
            if(s.TypeofHit == 1)
                    _RunnerToSecondLabel.hidden = false; 
        }
    }
    else
    {
        if(s.TypeofHit == 1)
        {
            s.ThirdBase = s.tempThird;
            s.SecondBase = s.tempSecond;
            s.FirstBase = s.tempBase;
        }
        else if(s.TypeofHit == 2)
        {
            s.ThirdBase = s.tempThird;
            s.SecondBase = s.tempBase;
        }
        else
        {
            s.ThirdBase = s.tempBase;
        }
        s.tempBase = s.tempFirst = s.tempSecond = s.tempThird = 0;
        s.TypeofHit = 0;
        [self ShowMainMenu];
    }
    
    [self Refresh];
    [self CallLog];
}

-(void)ShowMainMenu {
    _HitSingleOutlet.hidden = true;
    _HitDoubleOutlet.hidden = true;
    _HitTripleOutlet.hidden = true;
    _HitHomeRunOutlet.hidden = true;
    _BallButtonOutlet.hidden = false;
    _StrikeButtonOutlet.hidden = false;
    _HitButtonOutlet.hidden = false;
    _HitOutOutlet.hidden = true;
    _RunnerToSecondLabel.hidden = true;
    _RunnerToThirdLabel.hidden = true;
    _RunnerScoresLabel.hidden = true;
    _RunnerOutLabel.hidden = true;
    _RunnerAdvancingLabel.hidden = true;
    _RunnerStaysOnBaseLabel.hidden = true;
}

-(void)ShowSubMenu {
    _HitSingleOutlet.hidden = false;
    _HitDoubleOutlet.hidden = false;
    _HitTripleOutlet.hidden = false;
    _HitHomeRunOutlet.hidden = false;
    _BallButtonOutlet.hidden = true;
    _StrikeButtonOutlet.hidden = true;
    _HitButtonOutlet.hidden = true;
    _HitOutOutlet.hidden = false;
    _RunnerToSecondLabel.hidden = true;
    _RunnerToThirdLabel.hidden = true;
    _RunnerScoresLabel.hidden = true;
    _RunnerOutLabel.hidden = true;
    _RunnerAdvancingLabel.hidden = true;
    _RunnerStaysOnBaseLabel.hidden = true;
}

-(void)ShowBaseRunnerMenu {
    _HitSingleOutlet.hidden = true;
    _HitDoubleOutlet.hidden = true;
    _HitTripleOutlet.hidden = true;
    _HitHomeRunOutlet.hidden = true;
    _BallButtonOutlet.hidden = true;
    _StrikeButtonOutlet.hidden = true;
    _HitButtonOutlet.hidden = true;
    _HitOutOutlet.hidden = true;;
    _RunnerToSecondLabel.hidden = false;
    _RunnerToThirdLabel.hidden = false;
    _RunnerScoresLabel.hidden = false;
    _RunnerOutLabel.hidden = false;
    _RunnerAdvancingLabel.hidden = true;
    _RunnerStaysOnBaseLabel.hidden = true;
}

-(void)HideAllMenu {
    _HitSingleOutlet.hidden = true;
    _HitDoubleOutlet.hidden = true;
    _HitTripleOutlet.hidden = true;
    _HitHomeRunOutlet.hidden = true;
    _BallButtonOutlet.hidden = true;
    _StrikeButtonOutlet.hidden = true;
    _HitButtonOutlet.hidden = true;
    _HitOutOutlet.hidden = true;;
    _RunnerToSecondLabel.hidden = true;
    _RunnerToThirdLabel.hidden = true;
    _RunnerScoresLabel.hidden = true;
    _RunnerOutLabel.hidden = true;
    _RunnerAdvancingLabel.hidden = true;
    _RunnerStaysOnBaseLabel.hidden = true;
}

-(void)Refresh {
    GameDataController* s = [GameDataController sharedInstance];
    
    _PitchedBallLabel.text = [NSString stringWithFormat:@"Balls: %@ Strikes: %@ Outs: %@", IntToString(s.balls), IntToString(s.strikes), IntToString(s.outs)];
    _NumInningLabel.text = [NSString stringWithFormat:@"%@ %@", s.sideInning, IntToString(s.numInning)];
    _HomeScoreLabel.text = [NSString stringWithFormat:@"Home: %@",IntToString(s.HomeScore)];
    _AwayScoreLabel.text = [NSString stringWithFormat:@"Away: %@",IntToString(s.AwayScore)];
}
-(void)SetLabels {
    _PitchedBallLabel.layer.backgroundColor = (__bridge CGColorRef)([UIColor grayColor]);
    _PitchedBallLabel.layer.shadowColor = (__bridge CGColorRef)([UIColor blackColor]);
    _PitchedBallLabel.layer.cornerRadius = 10;
    _NumInningLabel.layer.cornerRadius = 10;
    _HomeScoreLabel.layer.cornerRadius = 10;
    _AwayScoreLabel.layer.cornerRadius = 10;
}

-(void) CallLog {
    GameDataController* sharedSingleton = [GameDataController sharedInstance];
    
    NSLog(@"Strikes: %d, Balls: %d, Outs: %d, FirstBase: %@, SecondBase: %@, ThirdBase: %@", sharedSingleton.strikes, sharedSingleton.balls, sharedSingleton.outs, sharedSingleton.FirstBase.LastName, sharedSingleton.SecondBase.LastName, sharedSingleton.ThirdBase.LastName);
}

NSString *IntToString(int p)
{
    NSString *greeting = [[NSString alloc] initWithFormat:@"%d", p];
    return greeting;
}



@end
