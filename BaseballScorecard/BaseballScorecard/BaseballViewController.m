//
//  BaseballViewController.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/9/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "BaseballViewController.h"
#import "GameDataController.h"
#import "Quartz2D.h"

@implementation BaseballViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}
/*--------------------------------------------------------------------------------*/
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self LoadFromPlist];
    
    [self Refresh];
}
/*--------------------------------------------------------------------------------*/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*--------------------------------------------------------------------------------*/
- (IBAction)ThrowPitch:(id)sender {
    
    [self CallLog];
    [self ShowPitchCountMenu];
}
/*--------------------------------------------------------------------------------*/
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
                    break;
                case 1: /* Strike button */
                    [s PitchedStrike];
                    break;
                case 2: /* Hit button */
                    [self ShowHitMenu];
                    break;
            }
        }
            break;
        case 1: /* SubMenuActionSheet */
            switch ( buttonIndex )
            {
                case 0: /* Single button*/
                    [s HitSingle];
                    //s.BatterAdvance = 1;
                    [self RunnerAdvancing];
                    break;
                case 1: /* Double button */
                    [s HitDouble];
                    //s.BatterAdvance = 2;
                    [self RunnerAdvancing];
                    break;
                case 2: /* Triple button */
                    [s HitTriple];
                    //s.BatterAdvance = 3;
                    [self RunnerAdvancing];
                    break;
                case 3: /* HomeRun button */
                    [s HitHomeRun];
                    break;
                case 4: /* HitOut button */
                    [s HitOut];
                    break;
            }
            break;
        case 2: /* RunnerOnThirdActionSheet */
            switch ( buttonIndex )
            {
                case 0: /* Out button*/
                    [s RunnerOut];
                    [self RunnerAdvancing];
                    break;
                case 1: /* Score button */
                    [s RunnerScores];
                    //s.ThirdBaseAdvance = 1;
                    [self RunnerAdvancing];
                    break;
                case 2: /* StayOnBase button */
                    [s RunnerStaysOnBase];
                    [self RunnerAdvancing];
                    break;
            }
            break;
        case 3: /* RunnerOnSecondActionSheet */
            switch ( buttonIndex )
            {
            case 0: /* Out button*/
                [s RunnerOut];
                [self RunnerAdvancing];
                break;
            case 1: /* Score button */
                [s RunnerScores];
                [self RunnerAdvancing];
                break;
            case 2: /* AdvanceToThird button */
                [s RunnerToThird];
                //s.SecondBaseAdvance = 1;
                [self RunnerAdvancing];
                break;
            case 3: /* StayOnBase button */
                [s RunnerStaysOnBase];
                //s.SecondBaseAdvance = 2;
                [self RunnerAdvancing];
                break;
            }
            break;
        case 4: /* RunnerOnFirstActionSheet */
            switch ( buttonIndex )
        {
            case 0: /* Out button*/
                [s RunnerOut];
                [self RunnerAdvancing];
                break;
            case 1: /* Score button */
                [s RunnerScores];
                //s.FirstBaseAdvance = 3;
                [self RunnerAdvancing];
                break;
            case 2: /* AdvanceToThird button */
                [s RunnerToThird];
                //s.FirstBaseAdvance = 2;
                [self RunnerAdvancing];
                break;
            case 3: /* AdvanceToSecond button */
                [s RunnerToSecond];
                //s.FirstBaseAdvance = 1;
                [self RunnerAdvancing];
                break;
        }
            break;
    }
    [self Refresh];
    [self CallLog];
}
/*--------------------------------------------------------------------------------*/
-(void)RunnerAdvancing {
    
    GameDataController* s = [GameDataController sharedInstance];
    
    if(s.FirstBase != NULL && s.checkedfirst == false)
        [self RunnerOnFirstMenu];
    else if(s.SecondBase != NULL && s.checkedsecond == false)
        [self RunnerOnSecondMenu];
    else if(s.ThirdBase != NULL && s.checkedthird == false)
        [self RunnerOnThirdMenu];
    else
    {
        s.FirstBase = s.tempFirst;
        s.SecondBase = s.tempSecond;
        s.ThirdBase = s.tempThird;
        s.checkedfirst = s.checkedsecond = s.checkedthird = false;
        s.tempFirst = s.tempSecond = s.tempThird = s.Batter = NULL;
        s.TypeofHit = s.BatterAdvance = s.FirstBaseAdvance = s.SecondBaseAdvance = s.ThirdBaseAdvance = 0;
        [s BatterHit];
    }
}
/*--------------------------------------------------------------------------------*/
-(void)ShowPitchCountMenu {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Main Menu"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Ball", @"Strike", @"Hit", nil];
    actionSheet.tag = 0;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}
/*--------------------------------------------------------------------------------*/
-(void)ShowHitMenu {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Sub Menu"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Single", @"Double", @"Triple", @"Home Run", @"Out", nil];
    actionSheet.tag = 1;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];

}
/*--------------------------------------------------------------------------------*/
-(void)RunnerOnThirdMenu {
    
    GameDataController* s = [GameDataController sharedInstance];
    
    if(s.TypeofHit != 3 && s.tempThird == 0)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runner On Third"
                                      delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Out", @"Score", @"StayOnBase", nil];
        actionSheet.tag = 2;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runner On Third"
                                      delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Out", @"Score", nil];
        actionSheet.tag = 2;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    /*
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Runner On Third"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Score", @"Out", nil];
    actionSheet.tag = 2;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
     */
}
/*--------------------------------------------------------------------------------*/
-(void) RunnerOnSecondMenu {
    
    GameDataController* s = [GameDataController sharedInstance];
    
    if(s.TypeofHit == 1 && s.tempSecond == NULL && s.tempThird == NULL)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runner On Second"
                                      delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Out", @"Score", @"AdvanceToThird", @"StayOnBase", nil];
        actionSheet.tag = 3;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    else if(s.TypeofHit != 3 && s.tempThird == NULL)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runner On Second"
                                      delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Out", @"Score", @"AdvanceToThird", nil];
        actionSheet.tag = 3;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runner On Second"
                                      delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Out", @"Score", nil];
        actionSheet.tag = 3;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    
    
    
    /*
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Runner On Second"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Out", @"Advance To Third", @"Score", nil];
    actionSheet.tag = 3;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
*/
}
/*--------------------------------------------------------------------------------*/
-(void) RunnerOnFirstMenu {
    
    GameDataController* s = [GameDataController sharedInstance];
    
    if(s.TypeofHit == 1)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runner On First"
                                      delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Out", @"Score", @"AdvanceToThird", @"AdvanceToSecond", nil];
        actionSheet.tag = 4;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    else if(s.TypeofHit == 2)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runner On First"
                                      delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Out", @"Score", @"AdvanceToThird", nil];
        actionSheet.tag = 4;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runner On First"
                                      delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Out", @"Score", nil];
        actionSheet.tag = 4;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    
    /*
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Runner On First"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Out", @"Advance To Second", @"Advance To Third", @"Score", nil];
    actionSheet.tag = 4;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
     */
}
/*--------------------------------------------------------------------------------*/
-(void)Refresh {
    GameDataController* s = [GameDataController sharedInstance];
    
    _PitchedBallLabel.text = [NSString stringWithFormat:@"Balls: %@ Strikes: %@ Outs: %@", IntToString(s.balls), IntToString(s.strikes), IntToString(s.outs)];
    _NumInningLabel.text = [NSString stringWithFormat:@"%@ %@", s.sideInning, IntToString(s.numInning)];
    _HomeScoreLabel.text = [NSString stringWithFormat:@"Home: %@",IntToString(s.HomeScore)];
    _AwayScoreLabel.text = [NSString stringWithFormat:@"Away: %@",IntToString(s.AwayScore)];
}
/*--------------------------------------------------------------------------------*/
-(void) CallLog {
    GameDataController* s = [GameDataController sharedInstance];
    
    NSLog(@"B:%d, S:%d, O:%d, Hscore:%d, Ascore:%d, NumInning:%d, SideInning:%@, IsBottomInning:%d, Hindex:%d, Aindex:%d", s.balls, s.strikes, s.outs, s.HomeScore, s.AwayScore, s.numInning, s.sideInning, s.isBottomInning, s.HomeTeamLineupIndex, s.AwayTeamLineupIndex);
    
    
    NSLog(@"AtBat: B:%d, S:%d, O:%d, %@ %@ %@ %d/%d, %d run(s), %d RBI(s), %.3f", s.balls, s.strikes, s.outs, s.Batter.FirstName, s.Batter.LastName, s.Batter.Position, s.Batter.Hits, s.Batter.PlateAppearances, s.Batter.RunsScored, s.Batter.RBI, s.Batter.BattingAverage);
    NSLog(@"FirstBase: %@ %@ %@ %d/%d %d run(s), %d RBI(s), %.3f", s.FirstBase.FirstName, s.FirstBase.LastName, s.FirstBase.Position, s.FirstBase.Hits, s.FirstBase.PlateAppearances, s.FirstBase.RunsScored, s.FirstBase.RBI, s.FirstBase.BattingAverage);
    NSLog(@"SecondBase: %@ %@ %@ %d/%d %d run(s), %d RBI(s), %.3f", s.SecondBase.FirstName, s.SecondBase.LastName, s.SecondBase.Position, s.SecondBase.Hits, s.SecondBase.PlateAppearances, s.SecondBase.RunsScored, s.SecondBase.RBI, s.SecondBase.BattingAverage);
    NSLog(@"ThirdBase: %@ %@ %@ %d/%d %d run(s), %d RBI(s), %.3f", s.ThirdBase.FirstName, s.ThirdBase.LastName, s.ThirdBase.Position, s.ThirdBase.Hits, s.ThirdBase.PlateAppearances, s.ThirdBase.RunsScored, s.ThirdBase.RBI, s.ThirdBase.BattingAverage);
     
}

-(void)LoadFromPlist {
    GameDataController* s = [GameDataController sharedInstance];
    
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:app];
    
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"GameDataPlist.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"GameDataPlist" ofType:@"plist"];
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    if (!temp) {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    
    s.outs = [[temp objectForKey:@"Outs"] integerValue];
    s.strikes = [[temp objectForKey:@"Strikes"] integerValue];
    s.balls = [[temp objectForKey:@"Balls"] integerValue];
    s.numInning = [[temp objectForKey:@"NumInning"] integerValue];
    s.sideInning = [temp objectForKey:@"SideInning"];
    s.isBottomInning = [[temp objectForKey:@"IsBottomInning"] boolValue];
    s.HomeScore = [[temp objectForKey:@"HomeScore"] integerValue];
    s.AwayScore = [[temp objectForKey:@"AwayScore"] integerValue];
    s.HomeTeamLineupIndex = [[temp objectForKey:@"HomeTeamLineupIndex"] integerValue];
    s.AwayTeamLineupIndex = [[temp objectForKey:@"AwayTeamLineupIndex"] integerValue];
    
    //s.HomeTeam = [NSMutableArray arrayWithArray:[temp objectForKey:@"HomeTeam"]];
    //s.AwayTeam = [NSMutableArray arrayWithArray:[temp objectForKey:@"AwayTeam"]];
}

- (void)applicationDidEnterBackground:(NSNotification *)notification {
    NSLog(@"Entering Background");
    // get paths from root direcory
    GameDataController* s = [GameDataController sharedInstance];
    
    NSNumber *inning = [NSNumber numberWithInt:s.numInning];
    NSNumber *ball = [NSNumber numberWithInt:s.balls];
    NSNumber *strike = [NSNumber numberWithInt:s.strikes];
    NSNumber *outs = [NSNumber numberWithInt:s.outs];
    NSString *numinning = s.sideInning;
    NSNumber *isbottominning = [NSNumber numberWithBool:s.isBottomInning];
    NSNumber *homescore = [NSNumber numberWithInt:s.HomeScore];
    NSNumber *awayscore = [NSNumber numberWithInt:s.AwayScore];
    NSNumber *htli = [NSNumber numberWithInt:s.HomeTeamLineupIndex];
    NSNumber *atli = [NSNumber numberWithInt:s.AwayTeamLineupIndex];
    
    NSString *error;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"GameDataPlist.plist"];
    NSDictionary *plistDict = [NSDictionary dictionaryWithObjects:
                               [NSArray arrayWithObjects: /*s.AwayTeam, s.HomeTeam,*/ atli, htli, awayscore, homescore, isbottominning, numinning, inning, outs, strike, ball, nil]
                                                          forKeys:[NSArray arrayWithObjects: /*@"AwayTeam", @"HomeTeam",*/ @"AwayTeamLineupIndex", @"HomeTeamLineupIndex", @"AwayScore", @"HomeScore", @"IsBottomInning", @"SideInning", @"NumInning", @"Outs", @"Strikes", @"Balls", nil]];
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&error];
    if(plistData) {
        [plistData writeToFile:plistPath atomically:YES];
    }
}

NSString *IntToString(int p)
{
    NSString *greeting = [[NSString alloc] initWithFormat:@"%d", p];
    return greeting;
}



@end
