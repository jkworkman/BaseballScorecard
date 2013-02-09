//
//  BaseballViewController.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/9/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "BaseballViewController.h"
#import "GameDataController.h"

@interface BaseballViewController ()

@property (nonatomic) int balls;
@property (nonatomic) int strikes;
@property (nonatomic) int outs;
@property (nonatomic) NSString *sideInning;
@property (nonatomic) int numInning;
@property (nonatomic) BOOL isBottomInning;

@end

@implementation BaseballViewController

- (void)viewDidLoad
{
    
    _balls = 0;
    _strikes = 0;
    _outs = 0;
    _numInning = 1;
    _isBottomInning = false;
    _sideInning = @"Top";
    _PitchedStrikeLabel.text = IntToString(_strikes);
    _PitchedBallLabel.text = IntToString(_balls);
    _RecordedOutLabel.text = IntToString(_outs);
    _SideInningLabel.text = _sideInning;
    _NumInningLabel.text = IntToString(_numInning);
    _HitSingleOutlet.hidden = true;
    _HitDoubleOutlet.hidden = true;
    _HitTripleOutlet.hidden = true;
    _HitHomeRunOutlet.hidden = true;
    _BallButtonOutlet.hidden = false;
    _StrikeButtonOutlet.hidden = false;
    _HitButtonOutlet.hidden = false;
    ///***********************************************
    /*
    _game = [[GameDataController alloc] init];
    [_game init];
    */
    ///***********************************************
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PitchedBall:(id)sender {
    _balls += 1;
    
    if(_balls == 4)
    {
        _balls = 0;
        _strikes = 0;
    }
    _PitchedStrikeLabel.text = IntToString(_strikes);
    _PitchedBallLabel.text = IntToString(_balls);
    _RecordedOutLabel.text = IntToString(_outs);
}

- (IBAction)PitchedStrike:(id)sender {
    _strikes += 1;
    if(_strikes == 3)
    {
        _outs += 1;
        _strikes = 0;
        _balls = 0;
    }
    if(_outs == 3)
    {
        _outs = 0;
        if(_isBottomInning)
        {
            _sideInning = @"Top";
            _numInning += 1;
        }
        else
        {
            _sideInning = @"Bottom";
        }
        
        if(_isBottomInning)
        {
            _isBottomInning = false;
        }
        else
        {
            _isBottomInning = true;
        }
        
    }
    _PitchedStrikeLabel.text = IntToString(_strikes);
    _PitchedBallLabel.text = IntToString(_balls);
    _RecordedOutLabel.text = IntToString(_outs);
    _SideInningLabel.text = _sideInning;
    _NumInningLabel.text = IntToString(_numInning);
}

- (IBAction)HitBall:(id)sender {
    _HitSingleOutlet.hidden = false;
    _HitDoubleOutlet.hidden = false;
    _HitTripleOutlet.hidden = false;
    _HitHomeRunOutlet.hidden = false;
    _BallButtonOutlet.hidden = true;
    _StrikeButtonOutlet.hidden = true;
    _HitButtonOutlet.hidden = true;
}

- (IBAction)HitSingle:(id)sender {
    _HitSingleOutlet.hidden = true;
    _HitDoubleOutlet.hidden = true;
    _HitTripleOutlet.hidden = true;
    _HitHomeRunOutlet.hidden = true;
    _BallButtonOutlet.hidden = false;
    _StrikeButtonOutlet.hidden = false;
    _HitButtonOutlet.hidden = false;
}

- (IBAction)HitDouble:(id)sender {
    _HitSingleOutlet.hidden = true;
    _HitDoubleOutlet.hidden = true;
    _HitTripleOutlet.hidden = true;
    _HitHomeRunOutlet.hidden = true;
    _BallButtonOutlet.hidden = false;
    _StrikeButtonOutlet.hidden = false;
    _HitButtonOutlet.hidden = false;
}

- (IBAction)HitTriple:(id)sender {
    _HitSingleOutlet.hidden = true;
    _HitDoubleOutlet.hidden = true;
    _HitTripleOutlet.hidden = true;
    _HitHomeRunOutlet.hidden = true;
    _BallButtonOutlet.hidden = false;
    _StrikeButtonOutlet.hidden = false;
    _HitButtonOutlet.hidden = false;
}

- (IBAction)HitHomeRun:(id)sender {
    _HitSingleOutlet.hidden = true;
    _HitDoubleOutlet.hidden = true;
    _HitTripleOutlet.hidden = true;
    _HitHomeRunOutlet.hidden = true;
    _BallButtonOutlet.hidden = false;
    _StrikeButtonOutlet.hidden = false;
    _HitButtonOutlet.hidden = false;
}

NSString *IntToString(int p)
{
    NSString *greeting = [[NSString alloc] initWithFormat:@"%d", p];
    return greeting;
}



@end
