//
//  GameDataController.h
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/9/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Bases.h"

@interface GameDataController : NSObject

@property (nonatomic) NSInteger balls;
@property (nonatomic) NSInteger strikes;
@property (nonatomic) NSInteger outs;
@property (nonatomic) NSString *sideInning;
@property (nonatomic) NSInteger numInning;
@property (nonatomic) BOOL isBottomInning;
@property (nonatomic) NSMutableArray *HomeTeam;
@property (nonatomic) NSMutableArray *AwayTeam;
@property (nonatomic) NSInteger HomeTeamLineupIndex;
@property (nonatomic) NSInteger AwayTeamLineupIndex;
@property (nonatomic) NSInteger HomeScore;
@property (nonatomic) NSInteger AwayScore;
@property (nonatomic) Bases *firstbase;
@property (nonatomic) Bases *secondbase;
@property (nonatomic) Bases *thirdbase;
@property (nonatomic) Bases *atbat;
@property (nonatomic) NSInteger TypeofHit; // 0=empty 1=single 2=double 3=triple
@property (nonatomic) BOOL GameInProgress;
@property (nonatomic) NSMutableArray *FinalGameArray;
@property (nonatomic) NSMutableArray *BoxScoreList;
@property (nonatomic) NSInteger whichRunner;
@property (nonatomic) NSString *HomeTeamName;
@property (nonatomic) NSString *AwayTeamName;
@property (nonatomic) BOOL HomeLineupSubmitted;
@property (nonatomic) BOOL AwayLineupSubmitted;

@property (nonatomic) NSInteger undoballs;
@property (nonatomic) NSInteger undostrikes;
@property (nonatomic) NSInteger undoouts;
@property (nonatomic) NSString *undosideInning;
@property (nonatomic) NSInteger undonumInning;
@property (nonatomic) BOOL undoisBottomInning;
@property (nonatomic) NSMutableArray *undoHomeTeam;
@property (nonatomic) NSMutableArray *undoAwayTeam;
@property (nonatomic) NSInteger undoHomeTeamLineupIndex;
@property (nonatomic) NSInteger undoAwayTeamLineupIndex;
@property (nonatomic) NSInteger undoHomeScore;
@property (nonatomic) NSInteger undoAwayScore;
@property (nonatomic) Bases *undofirstbase;
@property (nonatomic) Bases *undosecondbase;
@property (nonatomic) Bases *undothirdbase;
@property (nonatomic) Bases *undoatbat;

@property (nonatomic) NSInteger redoballs;
@property (nonatomic) NSInteger redostrikes;
@property (nonatomic) NSInteger redoouts;
@property (nonatomic) NSString *redosideInning;
@property (nonatomic) NSInteger redonumInning;
@property (nonatomic) BOOL redoisBottomInning;
@property (nonatomic) NSMutableArray *redoHomeTeam;
@property (nonatomic) NSMutableArray *redoAwayTeam;
@property (nonatomic) NSInteger redoHomeTeamLineupIndex;
@property (nonatomic) NSInteger redoAwayTeamLineupIndex;
@property (nonatomic) NSInteger redoHomeScore;
@property (nonatomic) NSInteger redoAwayScore;
@property (nonatomic) Bases *redofirstbase;
@property (nonatomic) Bases *redosecondbase;
@property (nonatomic) Bases *redothirdbase;
@property (nonatomic) Bases *redoatbat;

+ (id)sharedInstance;

-(id)init;
-(void)PitchedBall;
-(void)PitchedStrike;
-(void)HitSingle;
-(void)HitDouble;
-(void)HitTriple;
-(void)HitHomeRun;
-(void)HitOut;

-(void)RunnerScores;
-(void)RunnerToThird;
-(void)RunnerToSecond;
-(void)RunnerOut;
-(void)RunnerStaysOnBase;

-(void)RunnerSteals;
-(void)RunnerPickedOff;

-(void)HomePlayerLineup;
-(void)AwayPlayerLineup;

-(void)BatterHit;

-(void)initilizeGame;

@end
