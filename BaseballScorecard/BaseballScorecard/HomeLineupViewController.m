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

- (IBAction)RandomLineupButton:(id)sender {
    _HomeTeamName.text = @"Cubs";
    _FirstFirstName.text = @"David";
    _FirstLastName.text = @"Dejesus";
    _FirstPosition.text = @"RF";
    _SecondFirstName.text = @"Starlin";
    _SecondLastName.text = @"Castro";
    _SecondPosition.text = @"SS";
    _ThirdFirstName.text = @"Anthony";
    _ThirdLastName.text = @"Rizzo";
    _ThirdPosition.text = @"1B";
    _FourthFirstName.text = @"Alfonso";
    _FourthLastName.text = @"Soriano";
    _FourthPosition.text = @"LF";
    _FifthFirstName.text = @"Nate";
    _FifthLastName.text = @"Schierholtz";
    _FifthPosition.text = @"CF";
    _SixthFirstName.text = @"Wellington";
    _SixthLastName.text = @"Castillo";
    _SixthPosition.text = @"C";
    _SeventhFirstName.text = @"Darwin";
    _SeventhLastName.text = @"Barney";
    _SeventhPosition.text = @"2B";
    _EighthFirstName.text = @"Luis";
    _EighthLastName.text = @"Valbuena";
    _EighthPosition.text = @"3B";
    _NinthFirstName.text = @"Matt";
    _NinthLastName.text = @"Garza";
    _NinthPosition.text = @"P";
}

- (IBAction)SubmitButton:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    
    if(!([_FirstFirstName.text isEqualToString:@""] || [_FirstLastName.text isEqualToString:@""] || [_FirstPosition.text isEqualToString:@""] || [_SecondFirstName.text isEqualToString:@""] || [_SecondLastName.text isEqualToString:@""] || [_SecondPosition.text isEqualToString:@""] || [_ThirdFirstName.text isEqualToString:@""] || [_ThirdLastName.text isEqualToString:@""] || [_ThirdPosition.text isEqualToString:@""] || [_FourthFirstName.text isEqualToString:@""] || [_FourthLastName.text isEqualToString:@""] || [_FourthPosition.text isEqualToString:@""] || [_FifthFirstName.text isEqualToString:@""] || [_FifthLastName.text isEqualToString:@""] || [_FifthPosition.text isEqualToString:@""] || [_SixthFirstName.text isEqualToString:@""] || [_SixthLastName.text isEqualToString:@""] || [_SixthPosition.text isEqualToString:@""] || [_SeventhFirstName.text isEqualToString:@""] || [_SeventhLastName.text isEqualToString:@""] || [_SeventhPosition.text isEqualToString:@""] || [_EighthFirstName.text isEqualToString:@""] || [_EighthLastName.text isEqualToString:@""] || [_EighthPosition.text isEqualToString:@""] || [_NinthFirstName.text isEqualToString:@""] || [_NinthLastName.text isEqualToString:@""] || [_NinthPosition.text isEqualToString:@""] || [_HomeTeamName.text isEqualToString:@""]))
    {
    
        s.HomeTeamName = _HomeTeamName.text;
    
        [s.HomeTeam addObject:[[Player alloc] initWithName:_FirstFirstName.text LastName:_FirstLastName.text Position:_FirstPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.HomeTeam addObject:[[Player alloc] initWithName:_SecondFirstName.text LastName:_SecondLastName.text Position:_SecondPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.HomeTeam addObject:[[Player alloc] initWithName:_ThirdFirstName.text LastName:_ThirdLastName.text Position:_ThirdPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.HomeTeam addObject:[[Player alloc] initWithName:_FourthFirstName.text LastName:_FourthLastName.text Position:_FourthPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.HomeTeam addObject:[[Player alloc] initWithName:_FifthFirstName.text LastName:_FifthLastName.text Position:_FifthPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.HomeTeam addObject:[[Player alloc] initWithName:_SixthFirstName.text LastName:_SixthLastName.text Position:_SixthPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.HomeTeam addObject:[[Player alloc] initWithName:_SeventhFirstName.text LastName:_SeventhLastName.text Position:_SeventhPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.HomeTeam addObject:[[Player alloc] initWithName:_EighthFirstName.text LastName:_EighthLastName.text Position:_EighthPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.HomeTeam addObject:[[Player alloc] initWithName:_NinthFirstName.text LastName:_NinthLastName.text Position:_NinthPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        
        [s.undoHomeTeam addObject:[[Player alloc] initWithName:_FirstFirstName.text LastName:_FirstLastName.text Position:_FirstPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.undoHomeTeam addObject:[[Player alloc] initWithName:_SecondFirstName.text LastName:_SecondLastName.text Position:_SecondPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.undoHomeTeam addObject:[[Player alloc] initWithName:_ThirdFirstName.text LastName:_ThirdLastName.text Position:_ThirdPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.undoHomeTeam addObject:[[Player alloc] initWithName:_FourthFirstName.text LastName:_FourthLastName.text Position:_FourthPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.undoHomeTeam addObject:[[Player alloc] initWithName:_FifthFirstName.text LastName:_FifthLastName.text Position:_FifthPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.undoHomeTeam addObject:[[Player alloc] initWithName:_SixthFirstName.text LastName:_SixthLastName.text Position:_SixthPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.undoHomeTeam addObject:[[Player alloc] initWithName:_SeventhFirstName.text LastName:_SeventhLastName.text Position:_SeventhPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.undoHomeTeam addObject:[[Player alloc] initWithName:_EighthFirstName.text LastName:_EighthLastName.text Position:_EighthPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.undoHomeTeam addObject:[[Player alloc] initWithName:_NinthFirstName.text LastName:_NinthLastName.text Position:_NinthPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        
        [s.redoHomeTeam addObject:[[Player alloc] initWithName:_FirstFirstName.text LastName:_FirstLastName.text Position:_FirstPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.redoHomeTeam addObject:[[Player alloc] initWithName:_SecondFirstName.text LastName:_SecondLastName.text Position:_SecondPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.redoHomeTeam addObject:[[Player alloc] initWithName:_ThirdFirstName.text LastName:_ThirdLastName.text Position:_ThirdPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.redoHomeTeam addObject:[[Player alloc] initWithName:_FourthFirstName.text LastName:_FourthLastName.text Position:_FourthPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.redoHomeTeam addObject:[[Player alloc] initWithName:_FifthFirstName.text LastName:_FifthLastName.text Position:_FifthPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.redoHomeTeam addObject:[[Player alloc] initWithName:_SixthFirstName.text LastName:_SixthLastName.text Position:_SixthPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.redoHomeTeam addObject:[[Player alloc] initWithName:_SeventhFirstName.text LastName:_SeventhLastName.text Position:_SeventhPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.redoHomeTeam addObject:[[Player alloc] initWithName:_EighthFirstName.text LastName:_EighthLastName.text Position:_EighthPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        [s.redoHomeTeam addObject:[[Player alloc] initWithName:_NinthFirstName.text LastName:_NinthLastName.text Position:_NinthPosition.text PlateAppearances:0 Hits:0 RunsScored:0 RBI:0 BattingAverage:0.00 HR:0 StolenBases:0]];
        
        s.HomeLineupSubmitted = true;
        _HomeSubmitLabel.hidden = true;
        _RandomLineupButtonLabel.hidden = true;
        _UpdateButtonLabel.hidden = false;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Home Lineup submitted successfully."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"All positions must be filled to submit lineup."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
}
- (IBAction)UpdateButton:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    Player *t = [[Player alloc] init];
    
    t = [s.HomeTeam objectAtIndex:0];
    t.FirstName = _FirstFirstName.text;
    t.LastName = _FirstLastName.text;
    t.Position = _FirstPosition.text;
    t = [s.HomeTeam objectAtIndex:1];
    t.FirstName = _SecondFirstName.text;
    t.LastName = _SecondLastName.text;
    t.Position = _SecondPosition.text;
    t = [s.HomeTeam objectAtIndex:2];
    t.FirstName = _ThirdFirstName.text;
    t.LastName = _ThirdLastName.text;
    t.Position = _ThirdPosition.text;
    t = [s.HomeTeam objectAtIndex:3];
    t.FirstName = _FourthFirstName.text;
    t.LastName = _FourthLastName.text;
    t.Position = _FourthPosition.text;
    t = [s.HomeTeam objectAtIndex:4];
    t.FirstName = _FifthFirstName.text;
    t.LastName = _FifthLastName.text;
    t.Position = _FifthPosition.text;
    t = [s.HomeTeam objectAtIndex:5];
    t.FirstName = _SixthFirstName.text;
    t.LastName = _SixthLastName.text;
    t.Position = _SixthPosition.text;
    t = [s.HomeTeam objectAtIndex:6];
    t.FirstName = _SeventhFirstName.text;
    t.LastName = _SeventhLastName.text;
    t.Position = _SeventhPosition.text;
    t = [s.HomeTeam objectAtIndex:7];
    t.FirstName = _EighthFirstName.text;
    t.LastName = _EighthLastName.text;
    t.Position = _EighthPosition.text;
    t = [s.HomeTeam objectAtIndex:8];
    t.FirstName = _NinthFirstName.text;
    t.LastName = _NinthLastName.text;
    t.Position = _NinthPosition.text;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"Home Lineup updated successfully."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert show];
}
@end
