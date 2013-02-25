//
//  BaseballViewController.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/9/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "BaseballViewController.h"
#import "GameDataController.h"
#import <QuartzCore/QuartzCore.h>

@implementation BaseballViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [self SetLabels];
    [self ShowMainMenu];
    [self CallLog];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PitchedBall:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    [s PitchedBall];
    [self Refresh];
    [self CallLog];
    }

- (IBAction)PitchedStrike:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    [s PitchedStrike];
    [self Refresh];
    [self CallLog];
}

- (IBAction)HitBall:(id)sender {
    [self ShowSubMenu];
}

- (IBAction)HitSingle:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    
    [s HitSingle];
    [self HideAllMenu];
    [self Refresh];
    [self CallLog];
    [self RunnerAdvancing];
}

- (IBAction)HitDouble:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    
    [s HitDouble];
    [self HideAllMenu];
    [self Refresh];
    [self CallLog];
    [self RunnerAdvancing];
}

- (IBAction)HitTriple:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    [s HitTriple];
    [self HideAllMenu];
    [self Refresh];
    [self CallLog];
    [self RunnerAdvancing];
}

- (IBAction)HitHomeRun:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    [s HitHomeRun];
    [self ShowMainMenu];
    [self Refresh];
    [self CallLog];
}

- (IBAction)HitOut:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    [s HitOut];
    [self ShowMainMenu];
    [self Refresh];
    [self CallLog];
}

- (IBAction)RunnerToSecond:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    [s RunnerToSecond];
    [self RunnerAdvancing];
}

- (IBAction)RunnerToThird:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    [s RunnerToThird];
    [self RunnerAdvancing];
}

- (IBAction)RunnerScores:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    [s RunnerScores];
    [self RunnerAdvancing];
}

- (IBAction)RunnerOut:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    [s RunnerOut];
    [self RunnerAdvancing];
}

- (IBAction)RunnerStaysOnBase:(id)sender {
}

- (IBAction)ThrowPitch:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Main Menu"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Ball", @"Strike", @"Hit", nil];
    actionSheet.tag = 0;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    GameDataController* s = [GameDataController sharedInstance];
    
    switch ( actionSheet.tag )
    {
        case 0: /* MainMenuActionSheet */
        {
            switch ( buttonIndex )
            {
                case 0: /* Ball button*/
                    [s PitchedBall];
                    [self Refresh];
                    [self CallLog];
                    break;
                case 1: /* Strike button */
                    [s PitchedStrike];
                    [self Refresh];
                    [self CallLog];
                    break;
                case 2: /* Hit button */
                    [self ShowSubMenu];
                    break;
            }
        }
            break;
        case 1: /* SubMenuActionSheet */
            switch ( buttonIndex )
            {
                case 0: /* Single button*/
                    [s HitSingle];
                    [self HideAllMenu];
                    [self Refresh];
                    [self CallLog];
                    [self RunnerAdvancing];
                    break;
                case 1: /* Double button */
                    [s HitDouble];
                    [self HideAllMenu];
                    [self Refresh];
                    [self CallLog];
                    [self RunnerAdvancing];
                    break;
                case 2: /* Triple button */
                    [s HitTriple];
                    [self HideAllMenu];
                    [self Refresh];
                    [self CallLog];
                    [self RunnerAdvancing];
                    break;
                case 3: /* HomeRun button */
                    [s HitHomeRun];
                    [self ShowMainMenu];
                    [self Refresh];
                    [self CallLog];
                    break;
                case 4: /* HitOut button */
                    [s HitOut];
                    [self ShowMainMenu];
                    [self Refresh];
                    [self CallLog];
                    break;
            }
            break;
        case 2: /* RunnerOnThirdActionSheet */
            switch ( buttonIndex )
            {
                case 0: /* Scores button*/
                    [s RunnerScores];
                    [self RunnerAdvancing];
                    break;
                case 1: /* Out button */
                    [s RunnerOut];
                    [self RunnerAdvancing];
                    break;
            }
            break;
        case 3: /* RunnerOnSecondActionSheet */
            switch ( buttonIndex )
            {
            case 0: /* AdvanceToThird button*/
                [s RunnerToThird];
                [self RunnerAdvancing];
                break;
            case 1: /* Score button */
                [s RunnerScores];
                [self RunnerAdvancing];
                break;
            case 2: /* Out button */
                [s RunnerOut];
                [self RunnerAdvancing];
                break;
            }
            break;
        case 4: /* RunnerOnFirstActionSheet */
            switch ( buttonIndex )
        {
            case 0: /* AdvanceToSecond button*/
                [s RunnerToSecond];
                [self RunnerAdvancing];
                break;
            case 1: /* AdvanceToThird button */
                [s RunnerToThird];
                [self RunnerAdvancing];
                break;
            case 2: /* Score button */
                [s RunnerScores];
                [self RunnerAdvancing];
                break;
            case 3: /* Out button */
                [s RunnerOut];
                [self RunnerAdvancing];
                break;
        }
            break;
    }
}

-(void)RunnerAdvancing {
    GameDataController* s = [GameDataController sharedInstance];
    
    if(s.ThirdBase != 0)
    {
        s.tempThird = s.ThirdBase;
        [self RunnerThird];
        /*
        _RunnerAdvancingLabel.text = @"Runner On Third";
        _RunnerAdvancingLabel.hidden = false;
        _RunnerOutLabel.hidden = false;
        _RunnerScoresLabel.hidden = false;
         */
    }
    else if(s.SecondBase != 0)
    {
        s.tempSecond = s.SecondBase;
        [self RunnerSecond];
        /*
        _RunnerAdvancingLabel.text = @"Runner On Second";
        _RunnerAdvancingLabel.hidden = false;
        _RunnerOutLabel.hidden = false;
        _RunnerScoresLabel.hidden = false;
        if(s.TypeofHit != 3)
            _RunnerToThirdLabel.hidden = false;
        */
    }
    else if(s.FirstBase != 0)
    {
        s.tempFirst = s.FirstBase;
        [self RunnerFirst];
        /*
        _RunnerAdvancingLabel.text = @"Runner On First";
        _RunnerAdvancingLabel.hidden = false;
        _RunnerOutLabel.hidden = false;
        _RunnerScoresLabel.hidden = false;
        if(s.TypeofHit != 3)
        {
            _RunnerToThirdLabel.hidden = false; 
            if(s.TypeofHit == 1)
                    _RunnerToSecondLabel.hidden = false; 
        }
        */
        
    }
    else
    {
        if(s.TypeofHit == 1)
        {
            s.ThirdBase = s.tempThird;
            s.SecondBase = s.tempSecond;
            s.FirstBase = s.tempBase;
        }
        else if(s.TypeofHit == 2)
        {
            s.ThirdBase = s.tempThird;
            s.SecondBase = s.tempBase;
        }
        else
        {
            s.ThirdBase = s.tempBase;
        }
        s.tempFirst = s.tempSecond = s.tempThird = 0;
        s.TypeofHit = 0;
        [s BatterHit];
        [self ShowMainMenu];
    }
    
    [self Refresh];
    [self CallLog];
}

-(void)ShowMainMenu {
    
    _HitSingleOutlet.hidden = true;
    _HitDoubleOutlet.hidden = true;
    _HitTripleOutlet.hidden = true;
    _HitHomeRunOutlet.hidden = true;
    _BallButtonOutlet.hidden = false;
    _StrikeButtonOutlet.hidden = false;
    _HitButtonOutlet.hidden = false;
    _HitOutOutlet.hidden = true;
    _RunnerToSecondLabel.hidden = true;
    _RunnerToThirdLabel.hidden = true;
    _RunnerScoresLabel.hidden = true;
    _RunnerOutLabel.hidden = true;
    _RunnerAdvancingLabel.hidden = true;
    _RunnerStaysOnBaseLabel.hidden = true;
     
}

-(void)ShowSubMenu {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Sub Menu"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Single", @"Double", @"Triple", @"Home Run", @"Out", nil];
    actionSheet.tag = 1;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];

    /*
    _HitSingleOutlet.hidden = false;
    _HitDoubleOutlet.hidden = false;
    _HitTripleOutlet.hidden = false;
    _HitHomeRunOutlet.hidden = false;
    _BallButtonOutlet.hidden = true;
    _StrikeButtonOutlet.hidden = true;
    _HitButtonOutlet.hidden = true;
    _HitOutOutlet.hidden = false;
    _RunnerToSecondLabel.hidden = true;
    _RunnerToThirdLabel.hidden = true;
    _RunnerScoresLabel.hidden = true;
    _RunnerOutLabel.hidden = true;
    _RunnerAdvancingLabel.hidden = true;
    _RunnerStaysOnBaseLabel.hidden = true;
     */
}

-(void)RunnerThird {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Runner On Third"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Score", @"Out", nil];
    actionSheet.tag = 2;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

-(void) RunnerSecond {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Runner On Second"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Advance To Third", @"Score", @"Out", nil];
    actionSheet.tag = 3;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

-(void)RunnerFirst {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Runner On First"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Advance To Second", @"Advance To Third", @"Score", @"Out", nil];
    actionSheet.tag = 4;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

-(void)ShowBaseRunnerMenu {
    _HitSingleOutlet.hidden = true;
    _HitDoubleOutlet.hidden = true;
    _HitTripleOutlet.hidden = true;
    _HitHomeRunOutlet.hidden = true;
    _BallButtonOutlet.hidden = true;
    _StrikeButtonOutlet.hidden = true;
    _HitButtonOutlet.hidden = true;
    _HitOutOutlet.hidden = true;;
    _RunnerToSecondLabel.hidden = false;
    _RunnerToThirdLabel.hidden = false;
    _RunnerScoresLabel.hidden = false;
    _RunnerOutLabel.hidden = false;
    _RunnerAdvancingLabel.hidden = true;
    _RunnerStaysOnBaseLabel.hidden = true;
}

-(void)HideAllMenu {
    _HitSingleOutlet.hidden = true;
    _HitDoubleOutlet.hidden = true;
    _HitTripleOutlet.hidden = true;
    _HitHomeRunOutlet.hidden = true;
    _BallButtonOutlet.hidden = true;
    _StrikeButtonOutlet.hidden = true;
    _HitButtonOutlet.hidden = true;
    _HitOutOutlet.hidden = true;;
    _RunnerToSecondLabel.hidden = true;
    _RunnerToThirdLabel.hidden = true;
    _RunnerScoresLabel.hidden = true;
    _RunnerOutLabel.hidden = true;
    _RunnerAdvancingLabel.hidden = true;
    _RunnerStaysOnBaseLabel.hidden = true;
}

-(void)Refresh {
    GameDataController* s = [GameDataController sharedInstance];
    
    _PitchedBallLabel.text = [NSString stringWithFormat:@"Balls: %@ Strikes: %@ Outs: %@", IntToString(s.balls), IntToString(s.strikes), IntToString(s.outs)];
    _NumInningLabel.text = [NSString stringWithFormat:@"%@ %@", s.sideInning, IntToString(s.numInning)];
    _HomeScoreLabel.text = [NSString stringWithFormat:@"Home: %@",IntToString(s.HomeScore)];
    _AwayScoreLabel.text = [NSString stringWithFormat:@"Away: %@",IntToString(s.AwayScore)];
}
-(void)SetLabels {
    _PitchedBallLabel.layer.backgroundColor = (__bridge CGColorRef)([UIColor grayColor]);
    _PitchedBallLabel.layer.shadowColor = (__bridge CGColorRef)([UIColor blackColor]);
    _PitchedBallLabel.layer.cornerRadius = 10;
    _NumInningLabel.layer.cornerRadius = 10;
    _HomeScoreLabel.layer.cornerRadius = 10;
    _AwayScoreLabel.layer.cornerRadius = 10;
}

-(void) CallLog {
    GameDataController* s = [GameDataController sharedInstance];
    
    NSLog(@"AtBat: B:%d, S:%d, O:%d, %@ %@ %@ %d/%d, %d run(s), %d RBI(s), %.3f", s.balls, s.strikes, s.outs, s.tempBase.FirstName, s.tempBase.LastName, s.tempBase.Position, s.tempBase.Hits, s.tempBase.PlateAppearances, s.tempBase.RunsScored, s.tempBase.RBI, s.tempBase.BattingAverage);
    NSLog(@"FirstBase: %@ %@ %@ %d/%d %d run(s), %d RBI(s), %.3f", s.FirstBase.FirstName, s.FirstBase.LastName, s.FirstBase.Position, s.FirstBase.Hits, s.FirstBase.PlateAppearances, s.FirstBase.RunsScored, s.FirstBase.RBI, s.FirstBase.BattingAverage);
    NSLog(@"SecondBase: %@ %@ %@ %d/%d %d run(s), %d RBI(s), %.3f", s.SecondBase.FirstName, s.SecondBase.LastName, s.SecondBase.Position, s.SecondBase.Hits, s.SecondBase.PlateAppearances, s.SecondBase.RunsScored, s.SecondBase.RBI, s.SecondBase.BattingAverage);
    NSLog(@"ThirdBase: %@ %@ %@ %d/%d %d run(s), %d RBI(s), %.3f", s.ThirdBase.FirstName, s.ThirdBase.LastName, s.ThirdBase.Position, s.ThirdBase.Hits, s.ThirdBase.PlateAppearances, s.ThirdBase.RunsScored, s.ThirdBase.RBI, s.ThirdBase.BattingAverage);
}

NSString *IntToString(int p)
{
    NSString *greeting = [[NSString alloc] initWithFormat:@"%d", p];
    return greeting;
}



@end
