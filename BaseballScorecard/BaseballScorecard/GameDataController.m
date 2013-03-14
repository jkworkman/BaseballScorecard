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

@synthesize balls;
@synthesize strikes;
@synthesize outs;
@synthesize numInning;
@synthesize sideInning;
@synthesize isBottomInning;
@synthesize HomeTeam;
@synthesize AwayTeam;
@synthesize HomeScore;
@synthesize AwayScore;
@synthesize HomeTeamLineupIndex;
@synthesize AwayTeamLineupIndex;
@synthesize TypeofHit;
@synthesize tempFirst;
@synthesize tempSecond;
@synthesize tempThird;
@synthesize Batter;
@synthesize FirstBase;
@synthesize SecondBase;
@synthesize ThirdBase;
@synthesize FirstBaseAdvance;
@synthesize SecondBaseAdvance;
@synthesize ThirdBaseAdvance;
@synthesize BatterAdvance;
@synthesize checkedfirst;
@synthesize checkedsecond;
@synthesize checkedthird;

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

        //numInning = 1;
        isBottomInning = false;
        sideInning = @"Top";
        HomeTeam = [[NSMutableArray alloc] initWithCapacity:9];
        AwayTeam = [[NSMutableArray alloc] initWithCapacity:9];
        
        HomeTeamLineupIndex = AwayTeamLineupIndex = TypeofHit = FirstBaseAdvance = SecondBaseAdvance = ThirdBaseAdvance = BatterAdvance = 0;
        FirstBase = SecondBase = ThirdBase = Batter = tempFirst = tempSecond = tempThird = NULL;
        checkedfirst = checkedsecond = checkedthird = false;
        
        [self AwayPlayerLineup];
        [self HomePlayerLineup];
        
        Batter = [AwayTeam objectAtIndex:AwayTeamLineupIndex];
    }
    return self;
}
/*--------------------------------------------------------------------------------*/
-(void)PitchedBall {
    balls += 1;
    if(balls == 4)
    {
        balls = 0;
        strikes = 0;
        if(!isBottomInning)
        {
            if(ThirdBase != NULL)
                AwayScore += 1;
            ThirdBase = SecondBase;
            SecondBase = FirstBase;
            FirstBase = [AwayTeam objectAtIndex:AwayTeamLineupIndex];
            
            AwayTeamLineupIndex += 1;
            if(AwayTeamLineupIndex == 9)
                AwayTeamLineupIndex = 0;
            Batter = [AwayTeam objectAtIndex:AwayTeamLineupIndex];
             
        }
        else
        {
            if(ThirdBase != NULL)
                HomeScore += 1;
            ThirdBase = SecondBase;
            SecondBase = FirstBase;
            FirstBase = [HomeTeam objectAtIndex:HomeTeamLineupIndex];
            
            HomeTeamLineupIndex += 1;
            if(HomeTeamLineupIndex == 9)
                HomeTeamLineupIndex = 0;
            Batter = [HomeTeam objectAtIndex:HomeTeamLineupIndex];
             
        }
    }
}
/*--------------------------------------------------------------------------------*/
-(void)PitchedStrike {
    strikes += 1;
    if(strikes == 3)
    {
        outs += 1;
        strikes = 0;
        balls = 0;
        Batter.PlateAppearances += 1;
        [self BatterHit];
    }
    if(outs == 3)
    {
        outs = 0;
        if(isBottomInning)
        {
            sideInning = @"Top";
            numInning += 1;
            Batter = [AwayTeam objectAtIndex:AwayTeamLineupIndex];
        }
        else
        {
            sideInning = @"Bottom";
            Batter = [HomeTeam objectAtIndex:HomeTeamLineupIndex];
        }
        
        if(isBottomInning)
        {
            isBottomInning = false;
        }
        else
        {
            isBottomInning = true;
        }
        FirstBase = SecondBase = ThirdBase = NULL;
        
    }
}
/*--------------------------------------------------------------------------------*/
-(void)HitSingle {
    Batter.PlateAppearances += 1;
    Batter.Hits += 1;
    TypeofHit = 1;
    Batter.BattingAverage = (float)Batter.Hits / (float)Batter.PlateAppearances;
    tempFirst = Batter;
}
/*--------------------------------------------------------------------------------*/
-(void)HitDouble {
    Batter.PlateAppearances += 1;
    Batter.Hits += 1;
    TypeofHit = 2;
    Batter.BattingAverage = (float)Batter.Hits / (float)Batter.PlateAppearances;
    tempSecond = Batter;
}
/*--------------------------------------------------------------------------------*/
-(void)HitTriple {
    Batter.PlateAppearances += 1;
    Batter.Hits += 1;
    TypeofHit = 3;
    Batter.BattingAverage = (float)Batter.Hits / (float)Batter.PlateAppearances;
    tempThird = Batter;
}
/*--------------------------------------------------------------------------------*/
-(void)HitHomeRun {
    
    int x = 0;
    
    if(ThirdBase != 0)
        x += 1;
    if(SecondBase != 0)
        x += 1;
    if(FirstBase != 0)
        x += 1;
    
    Batter.RBI += x;
    Batter.PlateAppearances += 1;
    Batter.Hits += 1;
    Batter.BattingAverage = (float)Batter.Hits / (float)Batter.PlateAppearances;
    x += 1; //the run for the batter
    
    if(!isBottomInning)
        AwayScore += x;
    else
        HomeScore += x;
    
    FirstBase = SecondBase = ThirdBase = NULL;
    balls = strikes = 0;
    [self BatterHit];
    
}
/*--------------------------------------------------------------------------------*/
-(void)HitOut {
    strikes = 0;
    balls = 0;
    outs += 1;
    Batter.PlateAppearances += 1;
    if(outs == 3)
    {
        outs = 0;
        if(isBottomInning)
        {
            sideInning = @"Top";
            numInning += 1;
            isBottomInning = false;
        }
        else
        {
            sideInning = @"Bottom";
            isBottomInning = true;
        }
        FirstBase = SecondBase = ThirdBase = NULL;
    }
    [self BatterHit];
}
/*--------------------------------------------------------------------------------*/
-(void)RunnerScores {
    if(!isBottomInning)
        AwayScore += 1;
    
    else
        HomeScore += 1;
    
    if(FirstBase != NULL && checkedfirst == false)
    {
        checkedfirst = true;
        FirstBase.RunsScored += 1;
        Batter.RBI += 1;
    }
    else if(SecondBase != NULL && checkedsecond == false)
    {
        checkedsecond = true;
        SecondBase.RunsScored += 1;
        Batter.RBI += 1;
    }
    else if(ThirdBase != NULL && checkedthird == false)
    {
        checkedthird = true;
        ThirdBase.RunsScored += 1;
        Batter.RBI += 1;
    }
}
/*--------------------------------------------------------------------------------*/
-(void)RunnerToThird {
    
    if(FirstBase != NULL && checkedfirst == false)
    {
        tempThird = FirstBase;
        checkedfirst = true;
    }
    else if(SecondBase != NULL && checkedsecond == false)
    {
        tempThird = SecondBase;
        checkedsecond = true;
    }
}
/*--------------------------------------------------------------------------------*/
-(void)RunnerToSecond {
    
    tempSecond = FirstBase;
    checkedfirst = true;
}
/*--------------------------------------------------------------------------------*/
-(void)RunnerOut {
    
    outs += 1;
    if(outs == 3)
    {
        outs = 0;
        if(isBottomInning)
        {
            sideInning = @"Top";
            numInning += 1;
            isBottomInning = false;
        }
        else
        {
            sideInning = @"Bottom";
            isBottomInning = true;
        }
        
        FirstBase = tempFirst = SecondBase = tempSecond = ThirdBase = tempThird = Batter = NULL;
        checkedfirst = checkedsecond = checkedthird = false;
    }
    else
    {
        if(FirstBase != 0 && checkedfirst == false)
            checkedfirst = true;
        else if(SecondBase != 0 && checkedsecond == false)
            checkedsecond = true;
        else if(ThirdBase != 0 && checkedthird == false)
            checkedthird = true;
    }
}
/*--------------------------------------------------------------------------------*/
-(void)RunnerStaysOnBase {
    if(SecondBase != NULL && checkedsecond == false)
    {
        tempSecond = SecondBase;
        checkedsecond = true;
    }
    else if(ThirdBase != NULL && checkedthird == false)
    {
        tempThird = ThirdBase;
        checkedthird = true;
    }
}
/*--------------------------------------------------------------------------------*/
-(void)BatterHit {
    if(!isBottomInning)
    {
        AwayTeamLineupIndex += 1;
        if(AwayTeamLineupIndex == 9)
            AwayTeamLineupIndex = 0;
        
        Batter = [AwayTeam objectAtIndex:AwayTeamLineupIndex];
         
    }
    else
    {
        HomeTeamLineupIndex += 1;
        if(HomeTeamLineupIndex == 9)
            HomeTeamLineupIndex = 0;
        
        Batter = [HomeTeam objectAtIndex:HomeTeamLineupIndex];
         
    }
}
/*--------------------------------------------------------------------------------*/
-(void)HomePlayerLineup {
    [HomeTeam addObject:[[Player alloc] initWithName:@"Jake" LastName:@"Workman" Position:@"SS"]];
    [HomeTeam addObject:[[Player alloc] initWithName:@"Lester" LastName:@"Pacquio" Position:@"2B"]];
    [HomeTeam addObject:[[Player alloc] initWithName:@"Jamal" LastName:@"Tinsley" Position:@"1B"]];
    [HomeTeam addObject:[[Player alloc] initWithName:@"Brad" LastName:@"Meester" Position:@"3B"]];
    [HomeTeam addObject:[[Player alloc] initWithName:@"Ziggy" LastName:@"Hood" Position:@"LF"]];
    [HomeTeam addObject:[[Player alloc] initWithName:@"Allen" LastName:@"Ascher" Position:@"RF"]];
    [HomeTeam addObject:[[Player alloc] initWithName:@"Jason" LastName:@"Kipnis" Position:@"CF"]];
    [HomeTeam addObject:[[Player alloc] initWithName:@"Yovanni" LastName:@"Gallardo" Position:@"P"]];
    [HomeTeam addObject:[[Player alloc] initWithName:@"Jurickson" LastName:@"Profar" Position:@"C"]];
}
/*--------------------------------------------------------------------------------*/
-(void)AwayPlayerLineup {
    [AwayTeam addObject:[[Player alloc] initWithName:@"Jeremy" LastName:@"Sandcastle" Position:@"2B"]];
    [AwayTeam addObject:[[Player alloc] initWithName:@"Myles" LastName:@"Leonard" Position:@"1B"]];
    [AwayTeam addObject:[[Player alloc] initWithName:@"Sabby" LastName:@"Piscatelli" Position:@"3B"]];
    [AwayTeam addObject:[[Player alloc] initWithName:@"Garvin" LastName:@"Greene" Position:@"CF"]];
    [AwayTeam addObject:[[Player alloc] initWithName:@"Gibralter" LastName:@"Maker" Position:@"C"]];
    [AwayTeam addObject:[[Player alloc] initWithName:@"Obtulla" LastName:@"Muhammad" Position:@"LF"]];
    [AwayTeam addObject:[[Player alloc] initWithName:@"Dekker" LastName:@"Austin" Position:@"SS"]];
    [AwayTeam addObject:[[Player alloc] initWithName:@"Grevious" LastName:@"Clark" Position:@"RF"]];
    [AwayTeam addObject:[[Player alloc] initWithName:@"Jim" LastName:@"Plunkett" Position:@"P"]];
}

@end