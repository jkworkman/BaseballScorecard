//
//  AwayLineupViewController.h
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/13/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "GameTabViewController.h"

@interface AwayLineupViewController : UIViewController <UITextFieldDelegate>



@property (strong, nonatomic) GameTabViewController *Lineup;

@property (weak, nonatomic) IBOutlet UITextField *FirstFirstName;
@property (weak, nonatomic) IBOutlet UIButton *LineupSubmit;

- (IBAction)AwaySubmit:(id)sender;


@end
