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

    [s.AwayTeam addObject:[[Player alloc] initWithName:_FirstFirstName.text LastName:_FirstLastName.text Position:_FirstPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
    [s.AwayTeam addObject:[[Player alloc] initWithName:_SecondFirstName.text LastName:_SecondLastName.text Position:_SecondPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
    [s.AwayTeam addObject:[[Player alloc] initWithName:_ThirdFirstName.text LastName:_ThirdLastName.text Position:_ThirdPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
    [s.AwayTeam addObject:[[Player alloc] initWithName:_FourthFirstName.text LastName:_FourthLastName.text Position:_FourthPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
    [s.AwayTeam addObject:[[Player alloc] initWithName:_FifthFirstName.text LastName:_FifthLastName.text Position:_FifthPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
    [s.AwayTeam addObject:[[Player alloc] initWithName:_SixthFirstName.text LastName:_SixthLastName.text Position:_SixthPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
    [s.AwayTeam addObject:[[Player alloc] initWithName:_SeventhFirstName.text LastName:_SeventhLastName.text Position:_SeventhPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
    [s.AwayTeam addObject:[[Player alloc] initWithName:_EighthFirstName.text LastName:_EighthLastName.text Position:_EighthPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
    [s.AwayTeam addObject:[[Player alloc] initWithName:_NinthFirstName.text LastName:_NinthLastName.text Position:_NinthPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
}
@end
