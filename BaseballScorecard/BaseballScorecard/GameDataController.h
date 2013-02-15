//
//  GameDataController.h
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/9/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

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
@property (nonatomic) Player *FirstBase;
@property (nonatomic) Player *SecondBase;
@property (nonatomic) Player *ThirdBase;
@property (nonatomic) int HomeScore;
@property (nonatomic) int AwayScore;

@property Player *Leadoff;
@property Player *SecondSpot;
@property Player *ThirdSpot;
@property Player *FourthSpot;
@property Player *FifthSpot;
@property Player *SixthSpot;
@property Player *SeventhSpot;
@property Player *EighthSpot;
@property Player *NinthSpot;

+ (id)sharedInstance;

-(id)init;
-(void)PitchedBall;
-(void)PitchedStrike;
-(void)HitSingle;
-(void)HitDouble;
-(void)HitTriple;
-(void)HitHomeRun;
-(void)HitOut;

-(void)HomePlayerLineup;
-(void)AwayPlayerLineup;

@end
