//
//  MainMenuViewController.h
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 4/1/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UIViewController
- (IBAction)MainMenuButton:(id)sender;
- (IBAction)ResumeGameButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ResumeGameLabel;


@end
