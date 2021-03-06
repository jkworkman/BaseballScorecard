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
@property (nonatomic) NSInteger PlateAppearances;
@property (nonatomic) NSInteger Hits;
@property (nonatomic) NSInteger RunsScored;
@property (nonatomic) NSInteger RBI;
@property (nonatomic) CGFloat BattingAverage;
@property (nonatomic) NSInteger HR;
@property (nonatomic) NSInteger StolenBases;

-(id)initWithName:(NSString *)fname LastName:(NSString *)lname Position:(NSString *)position PlateAppearances:(NSInteger)pa Hits:(NSInteger)h RunsScored:(NSInteger)rs RBI:(NSInteger)rbi BattingAverage:(CGFloat)ba HR:(NSInteger)hr StolenBases:(NSInteger)sb;

@end
