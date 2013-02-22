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
        _FirstBase = _SecondBase = _ThirdBase = _tempBase = _tempFirst = _tempSecond = _tempThird = 0;
        
        [self AwayPlayerLineup];
        [self HomePlayerLineup];
        
        _tempBase = [_AwayTeam objectAtIndex:_AwayTeamLineupIndex];
        
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
            if(_ThirdBase != 0)
                _AwayScore += 1;
            _ThirdBase = _SecondBase;
            _SecondBase = _FirstBase;
            _FirstBase = [_AwayTeam objectAtIndex:_AwayTeamLineupIndex];
            
            _AwayTeamLineupIndex += 1;
            if(_AwayTeamLineupIndex == 9)
                _AwayTeamLineupIndex = 0;
            _tempBase = [_AwayTeam objectAtIndex:_AwayTeamLineupIndex];
             
        }
        else
        {
            if(_ThirdBase != 0)
                _HomeScore += 1;
            _ThirdBase = _SecondBase;
            _SecondBase = _FirstBase;
            _FirstBase = [_HomeTeam objectAtIndex:_HomeTeamLineupIndex];
            
            _HomeTeamLineupIndex += 1;
            if(_HomeTeamLineupIndex == 9)
                _HomeTeamLineupIndex = 0;
            _tempBase = [_HomeTeam objectAtIndex:_HomeTeamLineupIndex];
             
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
        _tempBase.PlateAppearances += 1;
        [self BatterHit];
        /*
        if(!_isBottomInning)
        {
            _AwayTeamLineupIndex += 1;
            if(_AwayTeamLineupIndex == 9)
                _AwayTeamLineupIndex = 0;
            _tempBase = [_AwayTeam objectAtIndex:_AwayTeamLineupIndex];
        }
        else
        {
            _HomeTeamLineupIndex += 1;
            if(_HomeTeamLineupIndex == 9)
                _HomeTeamLineupIndex = 0;
            _tempBase = [_HomeTeam objectAtIndex:_HomeTeamLineupIndex];
        }
         */
    }
    if(_outs == 3)
    {
        _outs = 0;
        if(_isBottomInning)
        {
            _sideInning = @"Top";
            _numInning += 1;
            _tempBase = [_AwayTeam objectAtIndex:_AwayTeamLineupIndex];
        }
        else
        {
            _sideInning = @"Bottom";
            _tempBase = [_HomeTeam objectAtIndex:_HomeTeamLineupIndex];
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
    _tempBase.PlateAppearances += 1;
    _tempBase.Hits += 1;
    _TypeofHit = 1;
}

-(void)HitDouble {
    _tempBase.PlateAppearances += 1;
    _tempBase.Hits += 1;
    _TypeofHit = 2;
}
-(void)HitTriple {
    _tempBase.PlateAppearances += 1;
    _tempBase.Hits += 1;
    _TypeofHit = 3;
}
-(void)HitHomeRun {
    _tempBase.PlateAppearances += 1;
    _tempBase.Hits += 1;
    if(!_isBottomInning)
    {
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
    
    [self BatterHit];
    
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
            _sideInning = @"Top";
            _numInning += 1;
            _isBottomInning = false;
        }
        else
        {
            _sideInning = @"Bottom";
            _isBottomInning = true;
        }
        _FirstBase = 0;
        _SecondBase = 0;
        _ThirdBase = 0;
    }
    [self BatterHit];
}

-(void)RunnerScores {
    if(!_isBottomInning)
    {
        _AwayScore += 1;
        if(_tempThird != 0)
        {
            _ThirdBase.RunsScored += 1;
            _tempBase.RBI += 1;
            _ThirdBase = 0;
            _tempThird = 0;
        }
        else if(_tempSecond != 0)
        {
            _SecondBase.RunsScored += 1;
            _tempBase.RBI += 1;
            _SecondBase = 0;
            _tempSecond = 0;
        }
        else if(_tempFirst != 0)
        {
            _FirstBase.RunsScored += 1;
            _tempBase.RBI += 1;
            _FirstBase = 0;
            _tempFirst = 0;
        }
    }
    else{
        _HomeScore += 1;
        if(_tempThird != 0)
        {
            _ThirdBase.RunsScored += 1;
            _tempBase.RBI += 1;
            _ThirdBase = 0;
            _tempThird = 0;
        }
        else if(_tempSecond != 0)
        {
            _SecondBase.RunsScored += 1;
            _tempBase.RBI += 1;
            _SecondBase = 0;
            _tempSecond = 0;
        }
        else if(_tempFirst != 0)
        {
            _FirstBase.RunsScored += 1;
            _tempBase.RBI += 1;
            _FirstBase = 0;
            _tempFirst = 0;
        }
    }
}

-(void)RunnerToThird {
    if(_tempSecond != 0)
    {
        _tempThird = _tempSecond;
        _SecondBase = 0;
        _tempSecond = 0;
    }
    else if(_tempFirst != 0)
    {
        _tempThird = _tempFirst;
        _FirstBase = 0;
    }
}
-(void)RunnerToSecond {
    if(_tempFirst != 0)
    {
        _tempSecond = _tempFirst;
        _FirstBase = 0;
        _tempFirst = 0;
    }
}
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
        
        _FirstBase = _SecondBase = _ThirdBase = _tempThird = _tempSecond = _tempFirst = _tempBase = 0;
    }
    else
    {
        if(_tempThird != 0)
        {
            _ThirdBase = 0;
            _tempThird = 0;
        }
        else if(_tempSecond != 0)
        {
            _SecondBase = 0;
            _tempSecond = 0;
        }
        else if(_tempFirst != 0)
        {
            _FirstBase = 0;
            _tempFirst = 0;
        }
    }
}



-(void)BatterHit {
    if(!_isBottomInning)
    {
        _AwayTeamLineupIndex += 1;
        if(_AwayTeamLineupIndex == 9)
            _AwayTeamLineupIndex = 0;
        
        _tempBase = [_AwayTeam objectAtIndex:_AwayTeamLineupIndex];
    }
    else
    {
        _HomeTeamLineupIndex += 1;
        if(_HomeTeamLineupIndex == 9)
            _HomeTeamLineupIndex = 0;
        
        _tempBase = [_HomeTeam objectAtIndex:_HomeTeamLineupIndex];
    }
}

-(void)HomePlayerLineup {
    Player *Leadoff = [[Player alloc] initWithName:@"Jake" LastName:@"Workman" Position:@"SS"];
    [_HomeTeam addObject:Leadoff];
    Player *SecondSpot = [[Player alloc] initWithName:@"Lester" LastName:@"Pacquio" Position:@"2B"];
    [_HomeTeam addObject:SecondSpot];
    Player *ThirdSpot = [[Player alloc] initWithName:@"Jamal" LastName:@"Tinsley" Position:@"1B"];
    [_HomeTeam addObject:ThirdSpot];
    Player *FourthSpot = [[Player alloc] initWithName:@"Brad" LastName:@"Meester" Position:@"3B"];
    [_HomeTeam addObject:FourthSpot];
    Player *FifthSpot = [[Player alloc] initWithName:@"Ziggy" LastName:@"Hood" Position:@"LF"];
    [_HomeTeam addObject:FifthSpot];
    Player *SixthSpot = [[Player alloc] initWithName:@"Allen" LastName:@"Ascher" Position:@"RF"];
    [_HomeTeam addObject:SixthSpot];
    Player *SeventhSpot = [[Player alloc] initWithName:@"Jason" LastName:@"Kipnis" Position:@"CF"];
    [_HomeTeam addObject:SeventhSpot];
    Player *EighthSpot = [[Player alloc] initWithName:@"Yovanni" LastName:@"Gallardo" Position:@"P"];
    [_HomeTeam addObject:EighthSpot];
    Player *NinthSpot = [[Player alloc] initWithName:@"Jurickson" LastName:@"Profar" Position:@"C"];
    [_HomeTeam addObject:NinthSpot];
}

-(void)AwayPlayerLineup {
    Player *Leadoff = [[Player alloc] initWithName:@"Jeremy" LastName:@"Sandcastle" Position:@"2B"];
    [_AwayTeam addObject:Leadoff];
    Player *SecondSpot = [[Player alloc] initWithName:@"Myles" LastName:@"Leonard" Position:@"1B"];
    [_AwayTeam addObject:SecondSpot];
    Player *ThirdSpot = [[Player alloc] initWithName:@"Sabby" LastName:@"Piscatelli" Position:@"3B"];
    [_AwayTeam addObject:ThirdSpot];
    Player *FourthSpot = [[Player alloc] initWithName:@"Garvin" LastName:@"Greene" Position:@"CF"];
    [_AwayTeam addObject:FourthSpot];
    Player *FifthSpot = [[Player alloc] initWithName:@"Gibralter" LastName:@"Maker" Position:@"C"];
    [_AwayTeam addObject:FifthSpot];
    Player *SixthSpot = [[Player alloc] initWithName:@"Obtulla" LastName:@"Muhammad" Position:@"LF"];
    [_AwayTeam addObject:SixthSpot];
    Player *SeventhSpot = [[Player alloc] initWithName:@"Dekker" LastName:@"Austin" Position:@"SS"];
    [_AwayTeam addObject:SeventhSpot];
    Player *EighthSpot = [[Player alloc] initWithName:@"Grevious" LastName:@"Clark" Position:@"RF"];
    [_AwayTeam addObject:EighthSpot];
    Player *NinthSpot = [[Player alloc] initWithName:@"Jim" LastName:@"Plunkett" Position:@"P"];
    [_AwayTeam addObject:NinthSpot];
}




@end