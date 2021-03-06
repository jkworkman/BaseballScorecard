//
//  Bases.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/25/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "Bases.h"

@implementation Bases

@synthesize base;
@synthesize temp;
@synthesize checked;
@synthesize runnerAdvance;

/*
-(id)initWithName:(Player *)b temp:(Player *)t checked:(bool *)c {
    self = [super init];
    if (self) {
        base = b;
        temp = t;
        checked = c;
        return self;
    }
    return nil;
}
*/
-(id)init {
    self = [super init];
    if (self) {
        base = [[Player alloc] initWithName:@"temp" LastName:@"temp" Position:@"temp" PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0];
        temp = [[Player alloc] initWithName:@"temp" LastName:@"temp" Position:@"temp" PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0];
        checked = false;
        runnerAdvance = 0;
        return self;
    }
    return nil;
}

@end
