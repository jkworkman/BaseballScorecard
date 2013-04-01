//
//  BaseballViewController.h
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/9/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameDataController.h"
#import "Quartz2D.h"

@class GameDataController;

@interface BaseballViewController : UIViewController <UIActionSheetDelegate>

- (IBAction)HomeButton:(id)sender;

-(void)StartNewGame;
-(void)LoadFromPlist;

@end
