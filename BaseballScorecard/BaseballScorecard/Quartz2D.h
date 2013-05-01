//
//  Quartz2D.h
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/18/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Quartz2D : UIView <UIActionSheetDelegate>

- (IBAction)Pitch:(id)sender;
- (IBAction)UndoButton:(id)sender;
- (IBAction)RedoButton:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *HomeScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *AwayScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *PitchCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *InningLabel;
@property (weak, nonatomic) IBOutlet UIButton *PitchButtonLabel;
@property (weak, nonatomic) IBOutlet UIButton *UndoButtonLabel;
@property (weak, nonatomic) IBOutlet UIButton *RedoButtonLabel;
@property (weak, nonatomic) IBOutlet UILabel *SecondBaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *FirstBaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *ThirdBaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *LeftFieldLabel;
@property (weak, nonatomic) IBOutlet UILabel *CenterFieldLabel;
@property (weak, nonatomic) IBOutlet UILabel *RightFieldLabel;
@property (weak, nonatomic) IBOutlet UILabel *ShortstopLabel;
@property (weak, nonatomic) IBOutlet UILabel *SecondFielderLabel;
@property (weak, nonatomic) IBOutlet UILabel *FirstFielderLabel;
@property (weak, nonatomic) IBOutlet UILabel *ThirdFielderLabel;
@property (weak, nonatomic) IBOutlet UILabel *PitcherFielderLabel;
@property (weak, nonatomic) IBOutlet UILabel *CatcherLabel;




-(void)DrawField:(int)x :(int)y;
-(void)DrawHomeRun:(int)x :(int)y;
-(void)DrawSingle:(int)x :(int)y;
-(void)DrawDouble:(int)x :(int)y;
-(void)DrawTriple:(int)x :(int)y;
-(void)DrawFirstToHome:(int)x :(int)y;
-(void)DrawFirstToThird:(int)x :(int)y;
-(void)DrawFirstToSecond:(int)x :(int)y;
-(void)DrawSecondToHome:(int)x :(int)y;
-(void)DrawSecondToThird:(int)x :(int)y;
-(void)DrawThirdToHome:(int)x :(int)y;

-(void)UpdateLabels;

@end
