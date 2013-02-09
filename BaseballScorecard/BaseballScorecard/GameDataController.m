//
//  GameDataController.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/9/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "GameDataController.h"



@implementation GameDataController

-(id)init {
    self = [super init];
    if (self) {
        _balls = 0;
        _strikes = 0;
        _outs = 0;
        _sideInning = @"Top";
        _numInning = 1;
        _isBottomInning = false;
    }
    return nil;
}

-(void)PitchedBall {
    _balls += 1;
    
    if(_balls == 4)
    {
        _balls = 0;
        _strikes = 0;
    }
}

@end
