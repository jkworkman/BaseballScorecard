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

-(id)initWithName:(NSString *)fname LastName:(NSString *)lname Position:(NSString *)position
{
    self = [super init];
    if (self) {
        FirstName = fname;
        LastName = lname;
        Position = position;
        PlateAppearances = 0;
        Hits = 0;
        RunsScored = 0;
        RBI = 0;
        BattingAverage = 0.0;
        return self;
    }
    return nil;
}

@end
