//
//  BaseballViewController.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/9/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "BaseballViewController.h"
#import "GameDataController.h"

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
    [self ShowBaseRunnerMenu];
    [self Refresh];
    [self CallLog];
}

- (IBAction)HitDouble:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    
    [s HitDouble];
    [self ShowBaseRunnerMenu];
    [self Refresh];
    [self CallLog];
}

- (IBAction)HitTriple:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    [s HitTriple];
    [self ShowBaseRunnerMenu];
    [self Refresh];
    [self CallLog];
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
    
    if(s.tempSecond != 0)
    {
        s.tempSecond = s.tempFirst;
        s.FirstBase = 0;
        s.tempFirst = 0;
    }
    [self RunnerAdvancing];
}

- (IBAction)RunnerToThird:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    
    if(s.tempSecond != 0)
    {
        s.tempThird = s.tempSecond;
        s.SecondBase = 0;
        s.tempSecond = 0;
    }
    else if(s.tempFirst != 0)
    {
        s.tempThird = s.tempFirst;
        s.FirstBase = 0;
    }
    [self RunnerAdvancing];
}

- (IBAction)RunnerScores:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    
    if(!s.isBottomInning)
    {
        s.AwayScore += 1;
        if(s.tempThird != 0)
        {
            s.ThirdBase = 0;
            s.tempThird = 0;
        }
        else if(s.tempSecond != 0)
        {
            s.SecondBase = 0;
            s.tempSecond = 0;
        }
        else if(s.tempFirst != 0)
        {
            s.FirstBase = 0;
            s.tempFirst = 0;
        }
    }
    else{
        s.HomeScore += 1;
        if(s.tempThird != 0)
        {
            s.ThirdBase = 0;
            s.tempThird = 0;
        }
        else if(s.tempSecond != 0)
        {
            s.SecondBase = 0;
            s.tempSecond = 0;
        }
        else if(s.tempFirst != 0)
        {
            s.FirstBase = 0;
            s.tempFirst = 0;
        }
    }
}

- (IBAction)RunnerOut:(id)sender {

}

-(void)RunnerAdvancing {
    GameDataController* s = [GameDataController sharedInstance];
    
    if(s.ThirdBase != 0)
    {
        s.tempThird = s.ThirdBase;
        _RunnerOutLabel.hidden = false;
        _RunnerScoresLabel.hidden = false;
    }
    else if(s.SecondBase != 0)
    {
        s.tempSecond = s.SecondBase;
        _RunnerOutLabel.hidden = false;
        _RunnerScoresLabel.hidden = false;
        _RunnerToThirdLabel.hidden = false;
    }
    else if(s.FirstBase != 0)
    {
        s.tempFirst = s.FirstBase;
        _RunnerOutLabel.hidden = false;
        _RunnerScoresLabel.hidden = false;
        _RunnerToThirdLabel.hidden = false;
        _RunnerToSecondLabel.hidden = false;
    }
    else
    {
        s.ThirdBase = s.tempThird;
        s.SecondBase = s.tempSecond;
        s.FirstBase = s.tempBase;
    }
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
}

-(void)Refresh {
    GameDataController* sharedSingleton = [GameDataController sharedInstance];
    
    _PitchedBallLabel.text = IntToString(sharedSingleton.balls);
    _PitchedStrikeLabel.text = IntToString(sharedSingleton.strikes);
    _RecordedOutLabel.text = IntToString(sharedSingleton.outs);
    _SideInningLabel.text = sharedSingleton.sideInning;
    _NumInningLabel.text = IntToString(sharedSingleton.numInning);
    _HomeScoreLabel.text = IntToString(sharedSingleton.HomeScore);
    _AwayScoreLabel.text = IntToString(sharedSingleton.AwayScore);
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
