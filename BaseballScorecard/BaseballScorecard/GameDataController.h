//
//  GameDataController.h
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/9/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameData.h"

@interface GameDataController : NSObject

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

-(id)init;
-(void)PitchedBall;
-(void)PitchedStrike;
-(void)HitSingle;
-(void)HitDouble;
-(void)HitTriple;
-(void)HitHomeRun;
-(void)HitOut;

@end
