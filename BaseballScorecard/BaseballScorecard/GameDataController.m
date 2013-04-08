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
@synthesize firstbase;
@synthesize secondbase;
@synthesize thirdbase;
@synthesize atbat;
@synthesize BoxScoreList;
@synthesize FinalGameArray;

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
            if(thirdbase.base != NULL)
                AwayScore += 1;
        }
        else
        {
            if(thirdbase.base != NULL)
                HomeScore += 1;
        }
        
        thirdbase.base = secondbase.base;
        secondbase.base = firstbase.base;
        firstbase.base = atbat.base;
         
        [self BatterHit];
         
    }
}
/*--------------------------------------------------------------------------------*/
-(void)PitchedStrike {
    strikes += 1;
    TypeofHit = 5;
    if(thirdbase.base != NULL)
    {
        thirdbase.checked = true;
        thirdbase.runnerAdvance = 5;
        thirdbase.temp = thirdbase.base;

    }
    if(secondbase.base != NULL)
    {
        secondbase.checked = true;
        secondbase.runnerAdvance = 5;
        secondbase.temp = secondbase.base;
    }
    if(firstbase.base != NULL)
    {
        firstbase.checked = true;
        firstbase.runnerAdvance = 5;
        firstbase.temp = firstbase.base;
    }

    if(strikes == 3)
    {
        outs += 1;
        strikes = 0;
        balls = 0;
        atbat.base.PlateAppearances += 1;
        TypeofHit = 0;
    }
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
        atbat.runnerAdvance = firstbase.runnerAdvance = secondbase.runnerAdvance = thirdbase.runnerAdvance = 0;
        firstbase.base = secondbase.base = thirdbase.base = firstbase.temp = secondbase.temp = thirdbase.temp = NULL;
    }
}
/*--------------------------------------------------------------------------------*/
-(void)HitSingle {
    atbat.runnerAdvance = 1;
    atbat.base.PlateAppearances += 1;
    atbat.base.Hits += 1;
    TypeofHit = 1;
    atbat.base.BattingAverage = (float)atbat.base.Hits / (float)atbat.base.PlateAppearances;
    firstbase.temp = atbat.base;
}
/*--------------------------------------------------------------------------------*/
-(void)HitDouble {
    atbat.runnerAdvance = 2;
    atbat.base.PlateAppearances += 1;
    atbat.base.Hits += 1;
    TypeofHit = 2;
    atbat.base.BattingAverage = (float)atbat.base.Hits / (float)atbat.base.PlateAppearances;
    secondbase.temp = atbat.base;
}
/*--------------------------------------------------------------------------------*/
-(void)HitTriple {
    atbat.runnerAdvance = 3;
    atbat.base.PlateAppearances += 1;
    atbat.base.Hits += 1;
    TypeofHit = 3;
    atbat.base.BattingAverage = (float)atbat.base.Hits / (float)atbat.base.PlateAppearances;
    thirdbase.temp = atbat.base;
}
/*--------------------------------------------------------------------------------*/
-(void)HitHomeRun {
    
    int x = 0;
    x += 1; //the run for the batter
    if(thirdbase.base != NULL)
    {
        thirdbase.checked = true;
        thirdbase.runnerAdvance = 1;
        thirdbase.base.RunsScored += 1;
        x += 1;
    }
    if(secondbase.base != NULL)
    {
        secondbase.checked = true;
        secondbase.runnerAdvance = 2;
        secondbase.base.RunsScored += 1;
        x += 1;
    }
    if(firstbase.base != NULL)
    {
        firstbase.checked = true;
        firstbase.runnerAdvance = 3;
        firstbase.base.RunsScored += 1;
        x += 1;
    }
    atbat.runnerAdvance = 4;
    atbat.base.RBI += x;
    atbat.base.PlateAppearances += 1;
    atbat.base.Hits += 1;
    atbat.base.HR += 1;
    atbat.base.RunsScored += 1;
    atbat.base.BattingAverage = (float)atbat.base.Hits / (float)atbat.base.PlateAppearances;

    
    if(!isBottomInning)
        AwayScore += x;
    else
        HomeScore += x;
}
/*--------------------------------------------------------------------------------*/
-(void)HitOut {
    TypeofHit = 5;
    strikes = 0;
    balls = 0;
    outs += 1;
    atbat.base.PlateAppearances += 1;
    if(outs == 3)
    {
        outs = 0;
        if(isBottomInning)
        {
            sideInning = @"Top";
            numInning += 1;
            isBottomInning = false;
            atbat.base = [AwayTeam objectAtIndex:AwayTeamLineupIndex];
        }
        else
        {
            sideInning = @"Bottom";
            isBottomInning = true;
            atbat.base = [HomeTeam objectAtIndex:HomeTeamLineupIndex];
        }
        firstbase.base = secondbase.base = thirdbase.base = NULL;
    }
}
/*--------------------------------------------------------------------------------*/
-(void)RunnerScores {
    if(!isBottomInning)
        AwayScore += 1;
    
    else
        HomeScore += 1;
    
    if(firstbase.base != NULL && firstbase.checked == false)
    {
        firstbase.checked = true;
        firstbase.base.RunsScored += 1;
        atbat.base.RBI += 1;
    }
    else if(secondbase.base != NULL && secondbase.checked == false)
    {
        secondbase.checked = true;
        secondbase.base.RunsScored += 1;
        atbat.base.RBI += 1;
    }
    else if(thirdbase.base != NULL && thirdbase.checked == false)
    {
        thirdbase.checked = true;
        thirdbase.base.RunsScored += 1;
        atbat.base.RBI += 1;
    }
}
/*--------------------------------------------------------------------------------*/
-(void)RunnerToThird {
    
    if(firstbase.base != NULL && firstbase.checked == false)
    {
        thirdbase.temp = firstbase.base;
        firstbase.checked = true;
    }
    else if(secondbase.base != NULL && secondbase.checked == false)
    {
        thirdbase.temp = secondbase.base;
        secondbase.checked = true;
    }
}
/*--------------------------------------------------------------------------------*/
-(void)RunnerToSecond {
    
    secondbase.temp = firstbase.base;
    firstbase.checked = true;
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
        
        firstbase.base = firstbase.temp = secondbase.base = secondbase.temp = thirdbase.base = thirdbase.temp = atbat.base = atbat.temp = NULL;
        firstbase.checked = secondbase.checked = thirdbase.checked = false;
    }
    else
    {
        if(firstbase.base != 0 && firstbase.checked == false)
            firstbase.checked = true;
        else if(secondbase.base != 0 && secondbase.checked == false)
            secondbase.checked = true;
        else if(thirdbase.base != 0 && thirdbase.checked == false)
            thirdbase.checked = true;
    }
}
/*--------------------------------------------------------------------------------*/
-(void)RunnerStaysOnBase {
    if(firstbase.base != NULL && firstbase.checked == false)
    {
        firstbase.temp = firstbase.base;
        firstbase.checked = true;
    }
    if(secondbase.base != NULL && secondbase.checked == false)
    {
        secondbase.temp = secondbase.base;
        secondbase.checked = true;
    }
    else if(thirdbase.base != NULL && thirdbase.checked == false)
    {
        thirdbase.temp = thirdbase.base;
        thirdbase.checked = true;
    }
}
/*--------------------------------------------------------------------------------*/
-(void)BatterHit {
    if(!isBottomInning)
    {

        
        AwayTeamLineupIndex += 1;
        if(AwayTeamLineupIndex == 9)
            AwayTeamLineupIndex = 0;
        
        atbat.base = [AwayTeam objectAtIndex:AwayTeamLineupIndex];
    }
    else
    {

        
        HomeTeamLineupIndex += 1;
        if(HomeTeamLineupIndex == 9)
            HomeTeamLineupIndex = 0;
        
        atbat.base = [HomeTeam objectAtIndex:HomeTeamLineupIndex];
    }
}


/*--------------------------------------------------------------------------------*/
-(void)HomePlayerLineup {
    [HomeTeam addObject:[[Player alloc] initWithName:@"Jake" LastName:@"Workman" Position:@"SS" PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0]];
    [HomeTeam addObject:[[Player alloc] initWithName:@"Lester" LastName:@"Pacquio" Position:@"2B" PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0]];
    [HomeTeam addObject:[[Player alloc] initWithName:@"Jamal" LastName:@"Tinsley" Position:@"1B" PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0]];
    [HomeTeam addObject:[[Player alloc] initWithName:@"Brad" LastName:@"Meester" Position:@"3B" PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0]];
    [HomeTeam addObject:[[Player alloc] initWithName:@"Ziggy" LastName:@"Hood" Position:@"LF" PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0]];
    [HomeTeam addObject:[[Player alloc] initWithName:@"Allen" LastName:@"Ascher" Position:@"RF" PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0]];
    [HomeTeam addObject:[[Player alloc] initWithName:@"Jason" LastName:@"Kipnis" Position:@"CF" PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0]];
    [HomeTeam addObject:[[Player alloc] initWithName:@"Yovanni" LastName:@"Gallardo" Position:@"P" PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0]];
    [HomeTeam addObject:[[Player alloc] initWithName:@"Jurickson" LastName:@"Profar" Position:@"C" PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0]];
}
/*--------------------------------------------------------------------------------*/
-(void)AwayPlayerLineup {
    [AwayTeam addObject:[[Player alloc] initWithName:@"Jeremy" LastName:@"Sandcastle" Position:@"2B" PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0]];
    [AwayTeam addObject:[[Player alloc] initWithName:@"Myles" LastName:@"Leonard" Position:@"1B" PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0]];
    [AwayTeam addObject:[[Player alloc] initWithName:@"Sabby" LastName:@"Piscatelli" Position:@"3B" PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0]];
    [AwayTeam addObject:[[Player alloc] initWithName:@"Garvin" LastName:@"Greene" Position:@"CF" PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0]];
    [AwayTeam addObject:[[Player alloc] initWithName:@"Gibralter" LastName:@"Maker" Position:@"C" PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0]];
    [AwayTeam addObject:[[Player alloc] initWithName:@"Obtulla" LastName:@"Muhammad" Position:@"LF" PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0]];
    [AwayTeam addObject:[[Player alloc] initWithName:@"Dekker" LastName:@"Austin" Position:@"SS" PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0]];
    [AwayTeam addObject:[[Player alloc] initWithName:@"Grevious" LastName:@"Clark" Position:@"RF" PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0]];
    [AwayTeam addObject:[[Player alloc] initWithName:@"Jim" LastName:@"Plunkett" Position:@"P" PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0]];
}


@end