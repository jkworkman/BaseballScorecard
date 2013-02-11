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

    NSLog(@"Strikes: %d, Balls: %d, Outs: %d, FirstBase: %@, SecondBase: %@, ThirdBase: %@", _dataController.strikes, _dataController.balls, _dataController.outs, _dataController.FirstBase, _dataController.SecondBase, _dataController.ThirdBase);
    }

- (IBAction)PitchedStrike:(id)sender {
    [self.dataController PitchedStrike];
    [self Refresh];

    NSLog(@"Strikes: %d, Balls: %d, Outs: %d, FirstBase: %@, SecondBase: %@, ThirdBase: %@", _dataController.strikes, _dataController.balls, _dataController.outs, _dataController.FirstBase, _dataController.SecondBase, _dataController.ThirdBase);
}

- (IBAction)HitBall:(id)sender {
    [self ShowSubMenu];
}

- (IBAction)HitSingle:(id)sender {
    [self ShowMainMenu];
    [_dataController HitSingle];
    [self Refresh];
    
    NSLog(@"Strikes: %d, Balls: %d, Outs: %d, FirstBase: %@, SecondBase: %@, ThirdBase: %@", _dataController.strikes, _dataController.balls, _dataController.outs, _dataController.FirstBase, _dataController.SecondBase, _dataController.ThirdBase);
}

- (IBAction)HitDouble:(id)sender {
    [self ShowMainMenu];
    [_dataController HitDouble];
    [self Refresh];
    
    NSLog(@"Strikes: %d, Balls: %d, Outs: %d, FirstBase: %@, SecondBase: %@, ThirdBase: %@", _dataController.strikes, _dataController.balls, _dataController.outs, _dataController.FirstBase, _dataController.SecondBase, _dataController.ThirdBase);

}

- (IBAction)HitTriple:(id)sender {
    [self ShowMainMenu];
    [_dataController HitTriple];
    [self Refresh];
    
    NSLog(@"Strikes: %d, Balls: %d, Outs: %d, FirstBase: %@, SecondBase: %@, ThirdBase: %@", _dataController.strikes, _dataController.balls, _dataController.outs, _dataController.FirstBase, _dataController.SecondBase, _dataController.ThirdBase);

}

- (IBAction)HitHomeRun:(id)sender {
    [self ShowMainMenu];
    [_dataController HitHomeRun];
    [self Refresh];
    
    NSLog(@"Strikes: %d, Balls: %d, Outs: %d, FirstBase: %@, SecondBase: %@, ThirdBase: %@", _dataController.strikes, _dataController.balls, _dataController.outs, _dataController.FirstBase, _dataController.SecondBase, _dataController.ThirdBase);
}

- (IBAction)HitOut:(id)sender {
    [self ShowMainMenu];
    [_dataController HitOut];
    [self Refresh];
    
    NSLog(@"Strikes: %d, Balls: %d, Outs: %d, FirstBase: %@, SecondBase: %@, ThirdBase: %@", _dataController.strikes, _dataController.balls, _dataController.outs, _dataController.FirstBase, _dataController.SecondBase, _dataController.ThirdBase);
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

NSString *IntToString(int p)
{
    NSString *greeting = [[NSString alloc] initWithFormat:@"%d", p];
    return greeting;
}



@end
