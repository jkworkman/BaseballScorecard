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
    GameDataController* sharedSingleton = [GameDataController sharedInstance];
    [sharedSingleton PitchedBall];
    [self Refresh];
    [self CallLog];
    }

- (IBAction)PitchedStrike:(id)sender {
    GameDataController* sharedSingleton = [GameDataController sharedInstance];
    [sharedSingleton PitchedStrike];
    [self Refresh];
    [self CallLog];
}

- (IBAction)HitBall:(id)sender {
    [self ShowSubMenu];
}

- (IBAction)HitSingle:(id)sender {
    GameDataController* sharedSingleton = [GameDataController sharedInstance];
    [sharedSingleton HitSingle];
    [self ShowMainMenu];
    [self Refresh];
    [self CallLog];
}

- (IBAction)HitDouble:(id)sender {
    GameDataController* sharedSingleton = [GameDataController sharedInstance];
    [sharedSingleton HitDouble];
    [self ShowMainMenu];
    [self Refresh];
    [self CallLog];
}

- (IBAction)HitTriple:(id)sender {
    GameDataController* sharedSingleton = [GameDataController sharedInstance];
    [sharedSingleton HitTriple];
    [self ShowMainMenu];
    [self Refresh];
    [self CallLog];
}

- (IBAction)HitHomeRun:(id)sender {
    GameDataController* sharedSingleton = [GameDataController sharedInstance];
    [sharedSingleton HitHomeRun];
    [self ShowMainMenu];
    [self Refresh];
    [self CallLog];
}

- (IBAction)HitOut:(id)sender {
    GameDataController* sharedSingleton = [GameDataController sharedInstance];
    [sharedSingleton HitOut];
    [self ShowMainMenu];
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
