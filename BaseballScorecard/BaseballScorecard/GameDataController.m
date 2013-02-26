//
//  GameDataController.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/9/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "GameDataController.h"
#import "Player.h"



@implementation GameDataController


static GameDataController *sharedInstance = nil;

// Get the shared instance and create it if necessary.
+ (GameDataController *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

// Equally, we don't want to generate multiple copies of the singleton.
- (id)copyWithZone:(NSZone *)zone {
    return self;
}
/*--------------------------------------------------------------------------------*/
-(id)init {
    self = [super init];
    if (self) {
        
        _balls = 0;
        _strikes = 0;
        _outs = 0;
        _numInning = 1;
        _isBottomInning = false;
        _sideInning = @"Top";
        _HomeTeam = [[NSMutableArray alloc] initWithCapacity:9];
        _AwayTeam = [[NSMutableArray alloc] initWithCapacity:9];
        
        _HomeTeamLineupIndex = _AwayTeamLineupIndex = _TypeofHit = 0;
        _FirstBase = _SecondBase = _ThirdBase = _Batter = _tempFirst = _tempSecond = _tempThird = NULL;
        _checkedfirst = _checkedsecond = _checkedthird = false;
        
        [self AwayPlayerLineup];
        [self HomePlayerLineup];
        
        _Batter = [_AwayTeam objectAtIndex:_AwayTeamLineupIndex];
    }
    return self;
}
/*--------------------------------------------------------------------------------*/
-(void)PitchedBall {
    _balls += 1;
    if(_balls == 4)
    {
        _balls = 0;
        _strikes = 0;
        if(!_isBottomInning)
        {
            if(_ThirdBase != NULL)
                _AwayScore += 1;
            _ThirdBase = _SecondBase;
            _SecondBase = _FirstBase;
            _FirstBase = [_AwayTeam objectAtIndex:_AwayTeamLineupIndex];
            
            _AwayTeamLineupIndex += 1;
            if(_AwayTeamLineupIndex == 9)
                _AwayTeamLineupIndex = 0;
            _Batter = [_AwayTeam objectAtIndex:_AwayTeamLineupIndex];
             
        }
        else
        {
            if(_ThirdBase != NULL)
                _HomeScore += 1;
            _ThirdBase = _SecondBase;
            _SecondBase = _FirstBase;
            _FirstBase = [_HomeTeam objectAtIndex:_HomeTeamLineupIndex];
            
            _HomeTeamLineupIndex += 1;
            if(_HomeTeamLineupIndex == 9)
                _HomeTeamLineupIndex = 0;
            _Batter = [_HomeTeam objectAtIndex:_HomeTeamLineupIndex];
             
        }
    }
}
/*--------------------------------------------------------------------------------*/
-(void)PitchedStrike {
    _strikes += 1;
    if(_strikes == 3)
    {
        _outs += 1;
        _strikes = 0;
        _balls = 0;
        _Batter.PlateAppearances += 1;
        [self BatterHit];
    }
    if(_outs == 3)
    {
        _outs = 0;
        if(_isBottomInning)
        {
            _sideInning = @"Top";
            _numInning += 1;
            _Batter = [_AwayTeam objectAtIndex:_AwayTeamLineupIndex];
        }
        else
        {
            _sideInning = @"Bottom";
            _Batter = [_HomeTeam objectAtIndex:_HomeTeamLineupIndex];
        }
        
        if(_isBottomInning)
        {
            _isBottomInning = false;
        }
        else
        {
            _isBottomInning = true;
        }
        _FirstBase = _SecondBase = _ThirdBase = NULL;
        
    }
}
/*--------------------------------------------------------------------------------*/
-(void)HitSingle {
    _Batter.PlateAppearances += 1;
    _Batter.Hits += 1;
    _TypeofHit = 1;
    _tempFirst = _Batter;
}
/*--------------------------------------------------------------------------------*/
-(void)HitDouble {
    _Batter.PlateAppearances += 1;
    _Batter.Hits += 1;
    _TypeofHit = 2;
    _tempSecond = _Batter;
}
/*--------------------------------------------------------------------------------*/
-(void)HitTriple {
    _Batter.PlateAppearances += 1;
    _Batter.Hits += 1;
    _TypeofHit = 3;
    _tempThird = _Batter;
}
/*--------------------------------------------------------------------------------*/
-(void)HitHomeRun {
    
    int x = 0;
    
    if(_ThirdBase != 0)
        x += 1;
    if(_SecondBase != 0)
        x += 1;
    if(_FirstBase != 0)
        x += 1;
    
    _Batter.RBI += x;
    _Batter.PlateAppearances += 1;
    _Batter.Hits += 1;
    x += 1; //the run for the batter
    
    if(!_isBottomInning)
        _AwayScore += x;
    else
        _HomeScore += x;
    
    _FirstBase = _SecondBase = _ThirdBase = NULL;
    _balls = _strikes = 0;
    [self BatterHit];
    
}
/*--------------------------------------------------------------------------------*/
-(void)HitOut {
    _strikes = 0;
    _balls = 0;
    _outs += 1;
    if(_outs == 3)
    {
        _outs = 0;
        if(_isBottomInning)
        {
            _sideInning = @"Top";
            _numInning += 1;
            _isBottomInning = false;
        }
        else
        {
            _sideInning = @"Bottom";
            _isBottomInning = true;
        }
        _FirstBase = _SecondBase = _ThirdBase = NULL;
    }
    [self BatterHit];
}
/*--------------------------------------------------------------------------------*/
-(void)RunnerScores {
    if(!_isBottomInning)
        _AwayScore += 1;
    
    else
        _HomeScore += 1;
    
    if(_FirstBase != NULL && _checkedfirst == false)
    {
        _checkedfirst = true;
        _FirstBase.RunsScored += 1;
        _Batter.RBI += 1;
    }
    else if(_SecondBase != NULL && _checkedsecond == false)
    {
        _checkedsecond = true;
        _SecondBase.RunsScored += 1;
        _Batter.RBI += 1;
    }
    else if(_ThirdBase != NULL && _checkedthird == false)
    {
        _checkedthird = true;
        _ThirdBase.RunsScored += 1;
        _Batter.RBI += 1;
    }
}
/*--------------------------------------------------------------------------------*/
-(void)RunnerToThird {
    
    if(_FirstBase != NULL && _checkedfirst == false)
    {
        _tempThird = _FirstBase;
        _checkedfirst = true;
    }
    else if(_SecondBase != NULL && _checkedsecond == false)
    {
        _tempThird = _SecondBase;
        _checkedsecond = true;
    }
}
/*--------------------------------------------------------------------------------*/
-(void)RunnerToSecond {
    
    _tempSecond = _FirstBase;
    _checkedfirst = true;
}
/*--------------------------------------------------------------------------------*/
-(void)RunnerOut {
    
    _outs += 1;
    if(_outs == 3)
    {
        _outs = 0;
        if(_isBottomInning)
        {
            _sideInning = @"Top";
            _numInning += 1;
            _isBottomInning = false;
        }
        else
        {
            _sideInning = @"Bottom";
            _isBottomInning = true;
        }
        
        _FirstBase = _tempFirst = _SecondBase = _tempSecond = _ThirdBase = _tempThird = _Batter = NULL;
        _checkedfirst = _checkedsecond = _checkedthird = false;
    }
    else
    {
        if(_FirstBase != 0 && _checkedfirst == false)
            _checkedfirst = true;
        else if(_SecondBase != 0 && _checkedsecond == false)
            _checkedsecond = true;
        else if(_ThirdBase != 0 && _checkedthird == false)
            _checkedthird = true;
    }
}
/*--------------------------------------------------------------------------------*/
-(void)RunnerStaysOnBase {
    if(_SecondBase != NULL && _checkedsecond == false)
    {
        _tempSecond = _SecondBase;
        _checkedsecond = true;
    }
    else if(_ThirdBase != NULL && _checkedthird == false)
    {
        _tempThird = _ThirdBase;
        _checkedthird = true;
    }
}
/*--------------------------------------------------------------------------------*/
-(void)BatterHit {
    if(!_isBottomInning)
    {
        _AwayTeamLineupIndex += 1;
        if(_AwayTeamLineupIndex == 9)
            _AwayTeamLineupIndex = 0;
        
        _Batter = [_AwayTeam objectAtIndex:_AwayTeamLineupIndex];
         
    }
    else
    {
        _HomeTeamLineupIndex += 1;
        if(_HomeTeamLineupIndex == 9)
            _HomeTeamLineupIndex = 0;
        
        _Batter = [_HomeTeam objectAtIndex:_HomeTeamLineupIndex];
         
    }
}
/*--------------------------------------------------------------------------------*/
-(void)HomePlayerLineup {
    [_HomeTeam addObject:[[Player alloc] initWithName:@"Jake" LastName:@"Workman" Position:@"SS"]];
    [_HomeTeam addObject:[[Player alloc] initWithName:@"Lester" LastName:@"Pacquio" Position:@"2B"]];
    [_HomeTeam addObject:[[Player alloc] initWithName:@"Jamal" LastName:@"Tinsley" Position:@"1B"]];
    [_HomeTeam addObject:[[Player alloc] initWithName:@"Brad" LastName:@"Meester" Position:@"3B"]];
    [_HomeTeam addObject:[[Player alloc] initWithName:@"Ziggy" LastName:@"Hood" Position:@"LF"]];
    [_HomeTeam addObject:[[Player alloc] initWithName:@"Allen" LastName:@"Ascher" Position:@"RF"]];
    [_HomeTeam addObject:[[Player alloc] initWithName:@"Jason" LastName:@"Kipnis" Position:@"CF"]];
    [_HomeTeam addObject:[[Player alloc] initWithName:@"Yovanni" LastName:@"Gallardo" Position:@"P"]];
    [_HomeTeam addObject:[[Player alloc] initWithName:@"Jurickson" LastName:@"Profar" Position:@"C"]];
}
/*--------------------------------------------------------------------------------*/
-(void)AwayPlayerLineup {
    [_AwayTeam addObject:[[Player alloc] initWithName:@"Jeremy" LastName:@"Sandcastle" Position:@"2B"]];
    [_AwayTeam addObject:[[Player alloc] initWithName:@"Myles" LastName:@"Leonard" Position:@"1B"]];
    [_AwayTeam addObject:[[Player alloc] initWithName:@"Sabby" LastName:@"Piscatelli" Position:@"3B"]];
    [_AwayTeam addObject:[[Player alloc] initWithName:@"Garvin" LastName:@"Greene" Position:@"CF"]];
    [_AwayTeam addObject:[[Player alloc] initWithName:@"Gibralter" LastName:@"Maker" Position:@"C"]];
    [_AwayTeam addObject:[[Player alloc] initWithName:@"Obtulla" LastName:@"Muhammad" Position:@"LF"]];
    [_AwayTeam addObject:[[Player alloc] initWithName:@"Dekker" LastName:@"Austin" Position:@"SS"]];
    [_AwayTeam addObject:[[Player alloc] initWithName:@"Grevious" LastName:@"Clark" Position:@"RF"]];
    [_AwayTeam addObject:[[Player alloc] initWithName:@"Jim" LastName:@"Plunkett" Position:@"P"]];
}

@end