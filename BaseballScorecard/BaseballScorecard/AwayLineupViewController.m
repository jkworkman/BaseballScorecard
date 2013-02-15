//
//  AwayLineupViewController.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/13/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "AwayLineupViewController.h"
#import "GameDataController.h"

@class GameTabViewController;

@interface AwayLineupViewController ()

@end

@implementation AwayLineupViewController

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


- (IBAction)AwaySubmit:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];

    Player *Leadoff = [[Player alloc] initWithName:_FirstFirstName.text LastName:_FirstLastName.text Position:_FirstPosition.text];
    [s.AwayTeam addObject:Leadoff];
    Player *SecondSpot = [[Player alloc] initWithName:_SecondFirstName.text LastName:_SecondLastName.text Position:_SecondPosition.text];
    [s.AwayTeam addObject:SecondSpot];
    Player *ThirdSpot = [[Player alloc] initWithName:_ThirdFirstName.text LastName:_ThirdLastName.text Position:_ThirdPosition.text];
    [s.AwayTeam addObject:ThirdSpot];
    Player *FourthSpot = [[Player alloc] initWithName:_FourthFirstName.text LastName:_FourthLastName.text Position:_FourthPosition.text];
    [s.AwayTeam addObject:FourthSpot];
    Player *FifthSpot = [[Player alloc] initWithName:_FifthFirstName.text LastName:_FifthLastName.text Position:_FifthPosition.text];
    [s.AwayTeam addObject:FifthSpot];
    Player *SixthSpot = [[Player alloc] initWithName:_SixthFirstName.text LastName:_SixthLastName.text Position:_SixthPosition.text];
    [s.AwayTeam addObject:SixthSpot];
    Player *SeventhSpot = [[Player alloc] initWithName:_SeventhFirstName.text LastName:_SeventhLastName.text Position:_SeventhPosition.text];
    [s.AwayTeam addObject:SeventhSpot];
    Player *EighthSpot = [[Player alloc] initWithName:_EighthFirstName.text LastName:_EighthLastName.text Position:_EighthPosition.text];
    [s.AwayTeam addObject:EighthSpot];
    Player *NinthSpot = [[Player alloc] initWithName:_NinthFirstName.text LastName:_NinthLastName.text Position:_NinthPosition.text];
    [s.AwayTeam addObject:NinthSpot];
}
@end
