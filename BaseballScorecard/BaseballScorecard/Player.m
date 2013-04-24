//
//  Player.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/11/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize FirstName;
@synthesize LastName;
@synthesize Position;
@synthesize PlateAppearances;
@synthesize Hits;
@synthesize RunsScored;
@synthesize RBI;
@synthesize BattingAverage;
@synthesize HR;
@synthesize StolenBases;

-(id)initWithName:(NSString *)fname LastName:(NSString *)lname Position:(NSString *)position PlateAppearances:(NSInteger)pa Hits:(NSInteger)h RunsScored:(NSInteger)rs RBI:(NSInteger)rbi BattingAverage:(CGFloat)ba HR:(NSInteger)hr StolenBases:(NSInteger)sb
{
    self = [super init];
    if (self) {
        FirstName = fname;
        LastName = lname;
        Position = position;
        PlateAppearances = pa;
        Hits = h;
        RunsScored = rs;
        RBI = rbi;
        BattingAverage = ba;
        HR = hr;
        StolenBases = sb;
        return self;
    }
    return nil;
}

@end
