//
//  HomeLineupViewController.h
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/15/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeLineupViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *HomeTeamName;

@property (weak, nonatomic) IBOutlet UITextField *FirstFirstName;
@property (weak, nonatomic) IBOutlet UITextField *FirstLastName;
@property (weak, nonatomic) IBOutlet UITextField *FirstPosition;
@property (weak, nonatomic) IBOutlet UITextField *SecondFirstName;
@property (weak, nonatomic) IBOutlet UITextField *SecondLastName;
@property (weak, nonatomic) IBOutlet UITextField *SecondPosition;
@property (weak, nonatomic) IBOutlet UITextField *ThirdFirstName;
@property (weak, nonatomic) IBOutlet UITextField *ThirdLastName;
@property (weak, nonatomic) IBOutlet UITextField *ThirdPosition;
@property (weak, nonatomic) IBOutlet UITextField *FourthFirstName;
@property (weak, nonatomic) IBOutlet UITextField *FourthLastName;
@property (weak, nonatomic) IBOutlet UITextField *FourthPosition;
@property (weak, nonatomic) IBOutlet UITextField *FifthFirstName;
@property (weak, nonatomic) IBOutlet UITextField *FifthLastName;
@property (weak, nonatomic) IBOutlet UITextField *FifthPosition;
@property (weak, nonatomic) IBOutlet UITextField *SixthFirstName;
@property (weak, nonatomic) IBOutlet UITextField *SixthLastName;
@property (weak, nonatomic) IBOutlet UITextField *SixthPosition;
@property (weak, nonatomic) IBOutlet UITextField *SeventhFirstName;
@property (weak, nonatomic) IBOutlet UITextField *SeventhLastName;
@property (weak, nonatomic) IBOutlet UITextField *SeventhPosition;
@property (weak, nonatomic) IBOutlet UITextField *EighthFirstName;
@property (weak, nonatomic) IBOutlet UITextField *EighthLastName;
@property (weak, nonatomic) IBOutlet UITextField *EighthPosition;
@property (weak, nonatomic) IBOutlet UITextField *NinthFirstName;
@property (weak, nonatomic) IBOutlet UITextField *NinthLastName;
@property (weak, nonatomic) IBOutlet UITextField *NinthPosition;


- (IBAction)RandomLineupButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *RandomLineupButtonLabel;

- (IBAction)SubmitButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *HomeSubmitLabel;
- (IBAction)UpdateButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *UpdateButtonLabel;


@end
