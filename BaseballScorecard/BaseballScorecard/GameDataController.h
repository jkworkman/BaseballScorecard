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

@property (nonatomic) int balls;
@property (nonatomic) int strikes;
@property (nonatomic) int outs;
@property (nonatomic) NSString *sideInning;
@property (nonatomic) int numInning;
@property (nonatomic) BOOL isBottomInning;
@property (nonatomic) NSMutableArray *HomeTeam;
@property (nonatomic) NSMutableArray *AwayTeam;
@property (nonatomic) int HomeTeamLineupIndex;
@property (nonatomic) int AwayTeamLineupIndex;
@property (nonatomic) int HomeScore;
@property (nonatomic) int AwayScore;

@property (nonatomic) Player *tempFirst;
@property (nonatomic) Player *tempSecond;
@property (nonatomic) Player *tempThird;
@property (nonatomic) Player *Batter;
@property (nonatomic) Player *FirstBase;
@property (nonatomic) Player *SecondBase;
@property (nonatomic) Player *ThirdBase;
@property (nonatomic) bool checkedfirst;
@property (nonatomic) bool checkedsecond;
@property (nonatomic) bool checkedthird;


@property (nonatomic) int TypeofHit; // 0=empty 1=single 2=double 3=triple



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
