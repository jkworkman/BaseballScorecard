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
@property (nonatomic) NSMutableArray *Bases;
@property (nonatomic) NSMutableArray *HomeTeam;
@property (nonatomic) NSMutableArray *AwayTeam;
@property (nonatomic) int HomeTeamLineupIndex;
@property (nonatomic) int AwayTeamLineupIndex;
@property (nonatomic) NSObject *FirstBase;
@property (nonatomic) NSObject *SecondBase;
@property (nonatomic) NSObject *ThirdBase;
@property (nonatomic) int HomePlate;
@property (nonatomic) int HomeScore;
@property (nonatomic) int AwayScore;
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
    _HitOutOutlet.hidden = true;
    _Bases = [[NSMutableArray alloc] initWithCapacity:3];
    _HomeTeam = [[NSMutableArray alloc] initWithCapacity:9];
    _AwayTeam = [[NSMutableArray alloc] initWithCapacity:9];
    _HomeTeamLineupIndex = 0;
    _AwayTeamLineupIndex = 0;
    
    for(int i = 0; i < 9; i++)
    {
        [_HomeTeam addObject:[NSNumber numberWithInt:i]];
        [_AwayTeam addObject:[NSNumber numberWithInt:i]];
    }
    


    ///***********************************************
    /*
    GameDataController *game = [[GameDataController alloc] init];
    [game game.PitchedBall];
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
        if(!_isBottomInning)
        {
            _AwayTeamLineupIndex += 1;
            if(_AwayTeamLineupIndex == 9)
                _AwayTeamLineupIndex = 0;
        }
        else
        {
            _HomeTeamLineupIndex += 1;
            if(_HomeTeamLineupIndex == 9)
                _HomeTeamLineupIndex = 0;
        }
    NSLog(@"Away Atbat: %d, HomeAtbat: %d", _AwayTeamLineupIndex, _HomeTeamLineupIndex);
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
        if(!_isBottomInning)
        {
            _AwayTeamLineupIndex += 1;
            if(_AwayTeamLineupIndex == 9)
                _AwayTeamLineupIndex = 0;
        }
        else
        {
            _HomeTeamLineupIndex += 1;
            if(_HomeTeamLineupIndex == 9)
                _HomeTeamLineupIndex = 0;
        }
    NSLog(@"Away Atbat: %d, HomeAtbat: %d", _AwayTeamLineupIndex, _HomeTeamLineupIndex);
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
        _FirstBase = 0;
        _SecondBase = 0;
        _ThirdBase = 0;
        
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
    _HitOutOutlet.hidden = false;
}

- (IBAction)HitSingle:(id)sender {
    _HitSingleOutlet.hidden = true;
    _HitDoubleOutlet.hidden = true;
    _HitTripleOutlet.hidden = true;
    _HitHomeRunOutlet.hidden = true;
    _BallButtonOutlet.hidden = false;
    _StrikeButtonOutlet.hidden = false;
    _HitButtonOutlet.hidden = false;
    _HitOutOutlet.hidden = true;

    if(!_isBottomInning)
    {
        _AwayTeamLineupIndex += 1;
        if(_AwayTeamLineupIndex == 9)
            _AwayTeamLineupIndex = 0;
        
        if(_FirstBase == 0)
        {
            _FirstBase = [_AwayTeam objectAtIndex:_AwayTeamLineupIndex];
        }
        else
        {
            if(_SecondBase == 0)
            {
                _SecondBase = _FirstBase;
                _FirstBase = [_AwayTeam objectAtIndex:_AwayTeamLineupIndex];
            }
            else
            {
                if(_ThirdBase == 0)
                {
                    _ThirdBase = _SecondBase;
                    _SecondBase = _FirstBase;
                    _FirstBase = [_AwayTeam objectAtIndex:_AwayTeamLineupIndex];
                }
                else
                {
                    _AwayScore += 1;
                    _AwayScoreLabel.text = IntToString(_AwayScore);
                    _ThirdBase = _SecondBase;
                    _SecondBase = _FirstBase;
                    _FirstBase = [_AwayTeam objectAtIndex:_AwayTeamLineupIndex];
                    
                }
            }
        }
    }
    else
    {
        _HomeTeamLineupIndex += 1;
        if(_HomeTeamLineupIndex == 9)
            _HomeTeamLineupIndex = 0;
        
        if(_FirstBase == 0)
        {
            _FirstBase = [_HomeTeam objectAtIndex:_HomeTeamLineupIndex];
        }
        else
        {
            if(_SecondBase == 0)
            {
                _SecondBase = _FirstBase;
                _FirstBase = [_HomeTeam objectAtIndex:_HomeTeamLineupIndex];
            }
            else
            {
                if(_ThirdBase == 0)
                {
                    _ThirdBase = _SecondBase;
                    _SecondBase = _FirstBase;
                    _FirstBase = [_HomeTeam objectAtIndex:_HomeTeamLineupIndex];
                }
                else
                {
                    _HomeScore += 1;
                    _AwayScoreLabel.text = IntToString(_AwayScore);
                    _ThirdBase = _SecondBase;
                    _SecondBase = _FirstBase;
                    _FirstBase = [_HomeTeam objectAtIndex:_HomeTeamLineupIndex];
                    
                }
            }
        }
    }
    NSLog(@"FirstBase: %@, SecondBase: %@, ThirdBase %@", _FirstBase, _SecondBase, _ThirdBase);
}

- (IBAction)HitDouble:(id)sender {
    _HitSingleOutlet.hidden = true;
    _HitDoubleOutlet.hidden = true;
    _HitTripleOutlet.hidden = true;
    _HitHomeRunOutlet.hidden = true;
    _BallButtonOutlet.hidden = false;
    _StrikeButtonOutlet.hidden = false;
    _HitButtonOutlet.hidden = false;
    _HitOutOutlet.hidden = true;
    
    if(!_isBottomInning)
    {
        _AwayTeamLineupIndex += 1;
        if(_AwayTeamLineupIndex == 9)
            _AwayTeamLineupIndex = 0;
        

        if(_SecondBase == 0)
        {
            _SecondBase = [_AwayTeam objectAtIndex:_AwayTeamLineupIndex];
        }
        else
        {
            if(_ThirdBase == 0)
            {
                _ThirdBase = _SecondBase;
                _SecondBase = [_AwayTeam objectAtIndex:_AwayTeamLineupIndex];
            }
            else
            {
                if(_FirstBase != 0 && _SecondBase != 0 && _ThirdBase != 0)
                    _HomeScore += 2;
                else
                    _HomeScore += 1;
                _AwayScoreLabel.text = IntToString(_AwayScore);
                _ThirdBase = _SecondBase;
                _SecondBase = [_AwayTeam objectAtIndex:_AwayTeamLineupIndex];
            }
        }
    }
    else
    {
        _HomeTeamLineupIndex += 1;
        if(_HomeTeamLineupIndex == 9)
            _HomeTeamLineupIndex = 0;
        
        if(_SecondBase == 0)
        {
            _SecondBase = [_HomeTeam objectAtIndex:_HomeTeamLineupIndex];
        }
        else
        {
            if(_ThirdBase == 0)
            {
                _ThirdBase = _SecondBase;
                _SecondBase = [_HomeTeam objectAtIndex:_HomeTeamLineupIndex];
            }
            else
            {
                if(_FirstBase != 0 && _SecondBase != 0 && _ThirdBase != 0)
                    _HomeScore += 2;
                else
                    _HomeScore += 1;
                _HomeScoreLabel.text = IntToString(_HomeScore);
                _ThirdBase = _SecondBase;
                _SecondBase = [_HomeTeam objectAtIndex:_HomeTeamLineupIndex];
            }
        }
    }
    NSLog(@"FirstBase: %@, SecondBase: %@, ThirdBase %@", _FirstBase, _SecondBase, _ThirdBase);
}

- (IBAction)HitTriple:(id)sender {
    _HitSingleOutlet.hidden = true;
    _HitDoubleOutlet.hidden = true;
    _HitTripleOutlet.hidden = true;
    _HitHomeRunOutlet.hidden = true;
    _BallButtonOutlet.hidden = false;
    _StrikeButtonOutlet.hidden = false;
    _HitButtonOutlet.hidden = false;
    _HitOutOutlet.hidden = true;
    
    if(!_isBottomInning)
    {
        _AwayTeamLineupIndex += 1;
        if(_AwayTeamLineupIndex == 9)
            _AwayTeamLineupIndex = 0;
        
        

            if(_ThirdBase == 0)
            {
                _ThirdBase = [_AwayTeam objectAtIndex:_AwayTeamLineupIndex];
            }
            else
            {
                if(_FirstBase != 0 && _SecondBase != 0 && _ThirdBase != 0)
                    _AwayScore += 3;
                else if(_SecondBase != 0 && _ThirdBase != 0)
                    _AwayScore += 2;
                else
                    _AwayScore += 1;
                _AwayScoreLabel.text = IntToString(_AwayScore);
                _ThirdBase = [_AwayTeam objectAtIndex:_AwayTeamLineupIndex];
            }
    }
    else
    {
        _HomeTeamLineupIndex += 1;
        if(_HomeTeamLineupIndex == 9)
            _HomeTeamLineupIndex = 0;
        
        _HomeTeamLineupIndex += 1;
        if(_HomeTeamLineupIndex == 9)
            _HomeTeamLineupIndex = 0;
        
        
        
        if(_ThirdBase == 0)
        {
            _ThirdBase = [_HomeTeam objectAtIndex:_HomeTeamLineupIndex];
        }
        else
        {
            if(_FirstBase != 0 && _SecondBase != 0 && _ThirdBase != 0)
                _HomeScore += 3;
            else if(_SecondBase != 0 && _ThirdBase != 0)
                _HomeScore += 2;
            else
                _HomeScore += 1;
            _HomeScoreLabel.text = IntToString(_HomeScore);
            _ThirdBase = [_HomeTeam objectAtIndex:_HomeTeamLineupIndex];
        }
    }
    NSLog(@"FirstBase: %@, SecondBase: %@, ThirdBase %@", _FirstBase, _SecondBase, _ThirdBase);

}

- (IBAction)HitHomeRun:(id)sender {
    _HitSingleOutlet.hidden = true;
    _HitDoubleOutlet.hidden = true;
    _HitTripleOutlet.hidden = true;
    _HitHomeRunOutlet.hidden = true;
    _BallButtonOutlet.hidden = false;
    _StrikeButtonOutlet.hidden = false;
    _HitButtonOutlet.hidden = false;
    _HitOutOutlet.hidden = true;
    
    if(!_isBottomInning)
    {
        _AwayTeamLineupIndex += 1;
        if(_AwayTeamLineupIndex == 9)
            _AwayTeamLineupIndex = 0;
        
        _AwayScore += 1;
        if(_ThirdBase != 0)
            _AwayScore += 1;
        if(_SecondBase != 0)
            _AwayScore += 1;
        if(_FirstBase != 0)
            _AwayScore += 1;
        _AwayScoreLabel.text = IntToString(_AwayScore);
    }
    else
    {
        _HomeTeamLineupIndex += 1;
        if(_HomeTeamLineupIndex == 9)
            _HomeTeamLineupIndex = 0;
        
        _HomeScore += 1;
        if(_ThirdBase != 0)
            _HomeScore += 1;
        if(_SecondBase != 0)
            _HomeScore += 1;
        if(_FirstBase != 0)
            _HomeScore += 1;
        _HomeScoreLabel.text = IntToString(_HomeScore);
    }
    _FirstBase = 0;
    _SecondBase = 0;
    _ThirdBase = 0;
    NSLog(@"FirstBase: %@, SecondBase: %@, ThirdBase %@", _FirstBase, _SecondBase, _ThirdBase);
}

- (IBAction)HitOut:(id)sender {
    _HitSingleOutlet.hidden = true;
    _HitDoubleOutlet.hidden = true;
    _HitTripleOutlet.hidden = true;
    _HitHomeRunOutlet.hidden = true;
    _BallButtonOutlet.hidden = false;
    _StrikeButtonOutlet.hidden = false;
    _HitButtonOutlet.hidden = false;
    _HitOutOutlet.hidden = true;
    
    _strikes = 0;
    _balls = 0;
    _outs += 1;
    if(_outs == 3)
    {
        _outs = 0;
        if(_isBottomInning)
        {
            _AwayTeamLineupIndex += 1;
            if(_AwayTeamLineupIndex == 9)
                _AwayTeamLineupIndex = 0;
            _sideInning = @"Top";
            _numInning += 1;
        }
        else
        {
            _HomeTeamLineupIndex += 1;
            if(_HomeTeamLineupIndex == 9)
                _HomeTeamLineupIndex = 0;
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
        _FirstBase = 0;
        _SecondBase = 0;
        _ThirdBase = 0;
    }
    _PitchedStrikeLabel.text = IntToString(_strikes);
    _PitchedBallLabel.text = IntToString(_balls);
    _RecordedOutLabel.text = IntToString(_outs);
    _SideInningLabel.text = _sideInning;
    _NumInningLabel.text = IntToString(_numInning);

}



NSString *IntToString(int p)
{
    NSString *greeting = [[NSString alloc] initWithFormat:@"%d", p];
    return greeting;
}



@end
