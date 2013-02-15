//
//  GameTabViewController.h
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/14/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameDataController.h"

@interface GameTabViewController : UITabBarController

@property (strong, nonatomic) GameDataController *dataController;

@end
