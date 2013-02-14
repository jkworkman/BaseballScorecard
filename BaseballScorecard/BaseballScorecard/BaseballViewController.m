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



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _dataController = [[GameDataController alloc] init];
    [self ShowMainMenu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PitchedBall:(id)sender {
    [_dataController PitchedBall];
    [self Refresh];

    [self CallLog];
    
    NSLog(@"tempString: %@", _temp);
    }

- (IBAction)PitchedStrike:(id)sender {
    [_dataController PitchedStrike];
    [self Refresh];

    [self CallLog];
}

- (IBAction)HitBall:(id)sender {
    [self ShowSubMenu];
}

- (IBAction)HitSingle:(id)sender {
    [self ShowMainMenu];
    [_dataController HitSingle];
    [self Refresh];
    
    [self CallLog];
}

- (IBAction)HitDouble:(id)sender {
    [self ShowMainMenu];
    [_dataController HitDouble];
    [self Refresh];
    
    [self CallLog];
}

- (IBAction)HitTriple:(id)sender {
    [self ShowMainMenu];
    [_dataController HitTriple];
    [self Refresh];
    
    [self CallLog];
}

- (IBAction)HitHomeRun:(id)sender {
    [self ShowMainMenu];
    [_dataController HitHomeRun];
    [self Refresh];
    
    [self CallLog];
}

- (IBAction)HitOut:(id)sender {
    [self ShowMainMenu];
    [_dataController HitOut];
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
    _PitchedBallLabel.text = IntToString(_dataController.balls);
    _PitchedStrikeLabel.text = IntToString(_dataController.strikes);
    _RecordedOutLabel.text = IntToString(_dataController.outs);
    _SideInningLabel.text = _dataController.sideInning;
    _NumInningLabel.text = IntToString(_dataController.numInning);
    _HomeScoreLabel.text = IntToString(_dataController.HomeScore);
    _AwayScoreLabel.text = IntToString(_dataController.AwayScore);
}

-(void) CallLog {
    NSLog(@"Strikes: %d, Balls: %d, Outs: %d, FirstBase: %@, SecondBase: %@, ThirdBase: %@", _dataController.strikes, _dataController.balls, _dataController.outs, _dataController.FirstBase.LastName, _dataController.SecondBase.LastName, _dataController.ThirdBase.LastName);
}

NSString *IntToString(int p)
{
    NSString *greeting = [[NSString alloc] initWithFormat:@"%d", p];
    return greeting;
}



@end
