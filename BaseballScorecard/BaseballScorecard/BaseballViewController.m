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
        NSLog(@"Temp Variable: %@" , _game.dataController.temp);
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
        _game = [[GameTabViewController alloc] init];
    [self ShowMainMenu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PitchedBall:(id)sender {
    [_game.dataController PitchedBall];
    [self Refresh];
    NSLog(@"Temp Variable: %@" , _game.dataController.temp);
    [self CallLog];
    }

- (IBAction)PitchedStrike:(id)sender {
    [_game.dataController PitchedStrike];
    [self Refresh];

    [self CallLog];
}

- (IBAction)HitBall:(id)sender {
    [self ShowSubMenu];
}

- (IBAction)HitSingle:(id)sender {
    [self ShowMainMenu];
    [_game.dataController HitSingle];
    [self Refresh];
    
    [self CallLog];
}

- (IBAction)HitDouble:(id)sender {
    [self ShowMainMenu];
    [_game.dataController HitDouble];
    [self Refresh];
    
    [self CallLog];
}

- (IBAction)HitTriple:(id)sender {
    [self ShowMainMenu];
    [_game.dataController HitTriple];
    [self Refresh];
    
    [self CallLog];
}

- (IBAction)HitHomeRun:(id)sender {
    [self ShowMainMenu];
    [_game.dataController HitHomeRun];
    [self Refresh];
    
    [self CallLog];
}

- (IBAction)HitOut:(id)sender {
    [self ShowMainMenu];
    [_game.dataController HitOut];
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
    _PitchedBallLabel.text = IntToString(_game.dataController.balls);
    _PitchedStrikeLabel.text = IntToString(_game.dataController.strikes);
    _RecordedOutLabel.text = IntToString(_game.dataController.outs);
    _SideInningLabel.text = _game.dataController.sideInning;
    _NumInningLabel.text = IntToString(_game.dataController.numInning);
    _HomeScoreLabel.text = IntToString(_game.dataController.HomeScore);
    _AwayScoreLabel.text = IntToString(_game.dataController.AwayScore);
}

-(void) CallLog {
    NSLog(@"Strikes: %d, Balls: %d, Outs: %d, FirstBase: %@, SecondBase: %@, ThirdBase: %@", _game.dataController.strikes, _game.dataController.balls, _game.dataController.outs, _game.dataController.FirstBase.LastName, _game.dataController.SecondBase.LastName, _game.dataController.ThirdBase.LastName);
}

NSString *IntToString(int p)
{
    NSString *greeting = [[NSString alloc] initWithFormat:@"%d", p];
    return greeting;
}



@end
