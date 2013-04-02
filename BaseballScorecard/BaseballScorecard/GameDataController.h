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

-(void)HomePlayerLineup;
-(void)AwayPlayerLineup;

-(void)BatterHit;

@end
