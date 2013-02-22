//
//  Player.h
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/11/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic) NSString *FirstName;
@property (nonatomic) NSString *LastName;
@property (nonatomic) NSString *Position;
@property (nonatomic) int PlateAppearances;
@property (nonatomic) int Hits;
@property (nonatomic) int RunsScored;
@property (nonatomic) int RBI;
@property (nonatomic) float BattingAverage;

-(id)initWithName:(NSString *)fname LastName:(NSString *)lname Position:(NSString *)position;

@end
