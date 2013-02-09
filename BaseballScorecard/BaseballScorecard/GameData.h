//
//  GameData.h
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/9/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameData : NSObject

@property (nonatomic) int balls;
@property (nonatomic) int strikes;

-(id)initWithName:(int)balls strikes:(int)strikes;

@end
