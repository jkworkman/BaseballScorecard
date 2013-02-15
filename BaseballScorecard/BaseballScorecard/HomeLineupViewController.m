//
//  HomeLineupViewController.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/15/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "HomeLineupViewController.h"
#import "GameDataController.h"

@interface HomeLineupViewController ()

@end

@implementation HomeLineupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)SubmitButton:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    
    Player *Leadoff = [[Player alloc] initWithName:_FirstFirstName.text LastName:_FirstLastName.text Position:_FirstPosition.text];
    [s.HomeTeam addObject:Leadoff];
    Player *SecondSpot = [[Player alloc] initWithName:_SecondFirstName.text LastName:_SecondLastName.text Position:_SecondPosition.text];
    [s.HomeTeam addObject:SecondSpot];
    Player *ThirdSpot = [[Player alloc] initWithName:_ThirdFirstName.text LastName:_ThirdLastName.text Position:_ThirdPosition.text];
    [s.HomeTeam addObject:ThirdSpot];
    Player *FourthSpot = [[Player alloc] initWithName:_FourthFirstName.text LastName:_FourthLastName.text Position:_FourthPosition.text];
    [s.HomeTeam addObject:FourthSpot];
    Player *FifthSpot = [[Player alloc] initWithName:_FifthFirstName.text LastName:_FifthLastName.text Position:_FifthPosition.text];
    [s.HomeTeam addObject:FifthSpot];
    Player *SixthSpot = [[Player alloc] initWithName:_SixthFirstName.text LastName:_SixthLastName.text Position:_SixthPosition.text];
    [s.HomeTeam addObject:SixthSpot];
    Player *SeventhSpot = [[Player alloc] initWithName:_SeventhFirstName.text LastName:_SeventhLastName.text Position:_SeventhPosition.text];
    [s.HomeTeam addObject:SeventhSpot];
    Player *EighthSpot = [[Player alloc] initWithName:_EighthFirstName.text LastName:_EighthLastName.text Position:_EighthPosition.text];
    [s.HomeTeam addObject:EighthSpot];
    Player *NinthSpot = [[Player alloc] initWithName:_NinthFirstName.text LastName:_NinthLastName.text Position:_NinthPosition.text];
    [s.HomeTeam addObject:NinthSpot];
}
@end
