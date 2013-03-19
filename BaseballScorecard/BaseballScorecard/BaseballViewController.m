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
    
    NSString *a1fname = [temp objectForKey:@"a1fname"];
    NSString *a1lname = [temp objectForKey:@"a1lname"];
    NSString *a1pos = [temp objectForKey:@"a1pos"];
    NSInteger a1pa = [[temp objectForKey:@"a1pa"] integerValue];
    NSInteger a1h = [[temp objectForKey:@"a1h"] integerValue];
    NSInteger a1rs = [[temp objectForKey:@"a1rs"] integerValue];
    NSInteger a1rbi = [[temp objectForKey:@"a1rbi"] integerValue];
    CGFloat a1ba = [[temp objectForKey:@"a1ba"] floatValue];
    NSInteger a1hr = [[temp objectForKey:@"a1hr"] integerValue];
    
    NSString *a2fname = [temp objectForKey:@"a2fname"];
    NSString *a2lname = [temp objectForKey:@"a2lname"];
    NSString *a2pos = [temp objectForKey:@"a2pos"];
    NSInteger a2pa = [[temp objectForKey:@"a2pa"] integerValue];
    NSInteger a2h = [[temp objectForKey:@"a2h"] integerValue];
    NSInteger a2rs = [[temp objectForKey:@"a2rs"] integerValue];
    NSInteger a2rbi = [[temp objectForKey:@"a2rbi"] integerValue];
    CGFloat a2ba = [[temp objectForKey:@"a2ba"] floatValue];
    NSInteger a2hr = [[temp objectForKey:@"a2hr"] integerValue];
    
    NSString *a3fname = [temp objectForKey:@"a3fname"];
    NSString *a3lname = [temp objectForKey:@"a3lname"];
    NSString *a3pos = [temp objectForKey:@"a3pos"];
    NSInteger a3pa = [[temp objectForKey:@"a3pa"] integerValue];
    NSInteger a3h = [[temp objectForKey:@"a3h"] integerValue];
    NSInteger a3rs = [[temp objectForKey:@"a3rs"] integerValue];
    NSInteger a3rbi = [[temp objectForKey:@"a3rbi"] integerValue];
    CGFloat a3ba = [[temp objectForKey:@"a3ba"] floatValue];
    NSInteger a3hr = [[temp objectForKey:@"a3hr"] integerValue];
    
    NSString *a4fname = [temp objectForKey:@"a4fname"];
    NSString *a4lname = [temp objectForKey:@"a4lname"];
    NSString *a4pos = [temp objectForKey:@"a4pos"];
    NSInteger a4pa = [[temp objectForKey:@"a4pa"] integerValue];
    NSInteger a4h = [[temp objectForKey:@"a4h"] integerValue];
    NSInteger a4rs = [[temp objectForKey:@"a4rs"] integerValue];
    NSInteger a4rbi = [[temp objectForKey:@"a4rbi"] integerValue];
    CGFloat a4ba = [[temp objectForKey:@"a4ba"] floatValue];
    NSInteger a4hr = [[temp objectForKey:@"a4hr"] integerValue];
    
    NSString *a5fname = [temp objectForKey:@"a5fname"];
    NSString *a5lname = [temp objectForKey:@"a5lname"];
    NSString *a5pos = [temp objectForKey:@"a5pos"];
    NSInteger a5pa = [[temp objectForKey:@"a5pa"] integerValue];
    NSInteger a5h = [[temp objectForKey:@"a5h"] integerValue];
    NSInteger a5rs = [[temp objectForKey:@"a5rs"] integerValue];
    NSInteger a5rbi = [[temp objectForKey:@"a5rbi"] integerValue];
    CGFloat a5ba = [[temp objectForKey:@"a5ba"] floatValue];
    NSInteger a5hr = [[temp objectForKey:@"a5hr"] integerValue];
    
    NSString *a6fname = [temp objectForKey:@"a6fname"];
    NSString *a6lname = [temp objectForKey:@"a6lname"];
    NSString *a6pos = [temp objectForKey:@"a6pos"];
    NSInteger a6pa = [[temp objectForKey:@"a6pa"] integerValue];
    NSInteger a6h = [[temp objectForKey:@"a6h"] integerValue];
    NSInteger a6rs = [[temp objectForKey:@"a6rs"] integerValue];
    NSInteger a6rbi = [[temp objectForKey:@"a6rbi"] integerValue];
    CGFloat a6ba = [[temp objectForKey:@"a6ba"] floatValue];
    NSInteger a6hr = [[temp objectForKey:@"a6hr"] integerValue];
    
    NSString *a7fname = [temp objectForKey:@"a7fname"];
    NSString *a7lname = [temp objectForKey:@"a7lname"];
    NSString *a7pos = [temp objectForKey:@"a7pos"];
    NSInteger a7pa = [[temp objectForKey:@"a7pa"] integerValue];
    NSInteger a7h = [[temp objectForKey:@"a7h"] integerValue];
    NSInteger a7rs = [[temp objectForKey:@"a7rs"] integerValue];
    NSInteger a7rbi = [[temp objectForKey:@"a7rbi"] integerValue];
    CGFloat a7ba = [[temp objectForKey:@"a7ba"] floatValue];
    NSInteger a7hr = [[temp objectForKey:@"a7hr"] integerValue];
    
    NSString *a8fname = [temp objectForKey:@"a8fname"];
    NSString *a8lname = [temp objectForKey:@"a8lname"];
    NSString *a8pos = [temp objectForKey:@"a8pos"];
    NSInteger a8pa = [[temp objectForKey:@"a8pa"] integerValue];
    NSInteger a8h = [[temp objectForKey:@"a8h"] integerValue];
    NSInteger a8rs = [[temp objectForKey:@"a8rs"] integerValue];
    NSInteger a8rbi = [[temp objectForKey:@"a8rbi"] integerValue];
    CGFloat a8ba = [[temp objectForKey:@"a8ba"] floatValue];
    NSInteger a8hr = [[temp objectForKey:@"a8hr"] integerValue];
    
    NSString *a9fname = [temp objectForKey:@"a9fname"];
    NSString *a9lname = [temp objectForKey:@"a9lname"];
    NSString *a9pos = [temp objectForKey:@"a9pos"];
    NSInteger a9pa = [[temp objectForKey:@"a9pa"] integerValue];
    NSInteger a9h = [[temp objectForKey:@"a9h"] integerValue];
    NSInteger a9rs = [[temp objectForKey:@"a9rs"] integerValue];
    NSInteger a9rbi = [[temp objectForKey:@"a9rbi"] integerValue];
    CGFloat a9ba = [[temp objectForKey:@"a9ba"] floatValue];
    NSInteger a9hr = [[temp objectForKey:@"a9hr"] integerValue];
    
    s.AwayTeam = [[NSMutableArray alloc] initWithCapacity:9];
    
    [s.AwayTeam addObject:[[Player alloc] initWithName:a1fname LastName:a1lname Position:a1pos PlateAppearances:a1pa Hits:a1h RunsScored:a1rs RBI:a1rbi BattingAverage:a1ba HR:a1hr]];
    [s.AwayTeam addObject:[[Player alloc] initWithName:a2fname LastName:a2lname Position:a2pos PlateAppearances:a2pa Hits:a2h RunsScored:a2rs RBI:a2rbi BattingAverage:a2ba HR:a2hr]];
    [s.AwayTeam addObject:[[Player alloc] initWithName:a3fname LastName:a3lname Position:a3pos PlateAppearances:a3pa Hits:a3h RunsScored:a3rs RBI:a3rbi BattingAverage:a3ba HR:a3hr]];
    [s.AwayTeam addObject:[[Player alloc] initWithName:a4fname LastName:a4lname Position:a4pos PlateAppearances:a4pa Hits:a4h RunsScored:a4rs RBI:a4rbi BattingAverage:a4ba HR:a4hr]];
    [s.AwayTeam addObject:[[Player alloc] initWithName:a5fname LastName:a5lname Position:a5pos PlateAppearances:a5pa Hits:a5h RunsScored:a5rs RBI:a5rbi BattingAverage:a5ba HR:a5hr]];
    [s.AwayTeam addObject:[[Player alloc] initWithName:a6fname LastName:a6lname Position:a6pos PlateAppearances:a6pa Hits:a6h RunsScored:a6rs RBI:a6rbi BattingAverage:a6ba HR:a6hr]];
    [s.AwayTeam addObject:[[Player alloc] initWithName:a7fname LastName:a7lname Position:a7pos PlateAppearances:a7pa Hits:a7h RunsScored:a7rs RBI:a7rbi BattingAverage:a7ba HR:a7hr]];
    [s.AwayTeam addObject:[[Player alloc] initWithName:a8fname LastName:a8lname Position:a8pos PlateAppearances:a8pa Hits:a8h RunsScored:a8rs RBI:a8rbi BattingAverage:a8ba HR:a8hr]];
    [s.AwayTeam addObject:[[Player alloc] initWithName:a9fname LastName:a9lname Position:a9pos PlateAppearances:a9pa Hits:a9h RunsScored:a9rs RBI:a9rbi BattingAverage:a9ba HR:a9hr]];
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
                               [NSArray arrayWithObjects: atli, htli, awayscore, homescore, isbottominning, numinning, inning, outs, strike, ball, nil]
                                                          forKeys:[NSArray arrayWithObjects: @"AwayTeamLineupIndex", @"HomeTeamLineupIndex", @"AwayScore", @"HomeScore", @"IsBottomInning", @"SideInning", @"NumInning", @"Outs", @"Strikes", @"Balls", nil]];
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
