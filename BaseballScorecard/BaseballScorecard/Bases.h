//
//  Bases.h
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/25/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface Bases : NSObject

@property (nonatomic) Player *base;
@property (nonatomic) Player *temp;
@property (nonatomic) bool checked;

//-(id)initWithName:(Player *)b temp:(Player *)t checked:(bool *)c;
 
@end
