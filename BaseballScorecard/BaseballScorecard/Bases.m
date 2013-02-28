//
//  Bases.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/25/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "Bases.h"

@implementation Bases

-(id)init
{
    self = [super init];
    if (self) {
        _base = NULL;
        _temp = NULL;
        _checked = false;
        _animateposition = 0;
        return self;
    }
    return nil;
}

@end
