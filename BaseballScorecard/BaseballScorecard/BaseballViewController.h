//
//  BaseballViewController.h
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/9/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseballViewController : UIViewController
- (IBAction)PitchedBall:(id)sender;
- (IBAction)PitchedStrike:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *PitchedBallLabel;
@property (weak, nonatomic) IBOutlet UILabel *PitchedStrikeLabel;
@property (weak, nonatomic) IBOutlet UILabel *RecordedOutLabel;
@property (weak, nonatomic) IBOutlet UILabel *SideInningLabel;
@property (weak, nonatomic) IBOutlet UILabel *NumInningLabel;

@end
