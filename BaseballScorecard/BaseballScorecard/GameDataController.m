//
//  GameDataController.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/9/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "GameDataController.h"



@implementation GameDataController

-(id)init {
    self = [super init];
    if (self) {
        
        _balls = 0;
        _strikes = 0;
        _outs = 0;
        _numInning = 1;
        _isBottomInning = false;
        _sideInning = @"Top";
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
    }
    return self;
}

-(void)PitchedBall {
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
    }
}

-(void)PitchedStrike {
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
}

-(void)HitSingle {
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
                    _ThirdBase = _SecondBase;
                    _SecondBase = _FirstBase;
                    _FirstBase = [_HomeTeam objectAtIndex:_HomeTeamLineupIndex];
                    
                }
            }
        }
    }
}

-(void)HitDouble {
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
                _ThirdBase = _SecondBase;
                _SecondBase = [_HomeTeam objectAtIndex:_HomeTeamLineupIndex];
            }
        }
    }

}
-(void)HitTriple {
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
            _ThirdBase = [_HomeTeam objectAtIndex:_HomeTeamLineupIndex];
        }
    }

    
}
-(void)HitHomeRun {
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
    }
    _FirstBase = 0;
    _SecondBase = 0;
    _ThirdBase = 0;
    
}

-(void)HitOut {
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

}

@end
