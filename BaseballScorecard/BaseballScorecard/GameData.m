//
//  GameData.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/9/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "GameData.h"

@implementation GameData

-(id)initWithName:(int)balls strikes:(int)strikes
{
        self = [super init];
        if (self) {
            _balls = balls;
            _strikes = strikes;
            return self;
        }
        return nil;
}
@end
