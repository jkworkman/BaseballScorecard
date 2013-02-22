//
//  Player.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/11/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "Player.h"

@implementation Player

-(id)initWithName:(NSString *)fname LastName:(NSString *)lname Position:(NSString *)position
{
    self = [super init];
    if (self) {
        _FirstName = fname;
        _LastName = lname;
        _Position = position;
        _PlateAppearances = 0;
        _Hits = 0;
        _RunsScored = 0;
        _RBI = 0;
        _BattingAverage = 0.0;
        return self;
    }
    return nil;
}

@end
