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
#import "MainMenuViewController.h"

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
    
    GameDataController* s = [GameDataController sharedInstance];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if(s.GameInProgress == false)
        [self StartNewGame];
    
    /*
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:app];
    
    [self LoadFromPlist];
    */
}
/*--------------------------------------------------------------------------------*/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*--------------------------------------------------------------------------------*/


- (IBAction)HomeButton:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

-(void)StartNewGame {
    GameDataController* s = [GameDataController sharedInstance];
    
    s.HomeTeam = [[NSMutableArray alloc] initWithCapacity:9];
    s.AwayTeam = [[NSMutableArray alloc] initWithCapacity:9];
    s.FinalGameArray = [[NSMutableArray alloc] init];
    s.firstbase = [[Bases alloc] init];
    s.secondbase = [[Bases alloc] init];
    s.thirdbase = [[Bases alloc] init];
    s.atbat = [[Bases alloc] init];
    
    s.firstbase.base = s.secondbase.base = s.thirdbase.base = s.atbat.base = s.firstbase.temp = s.secondbase.temp = s.thirdbase.temp = s.atbat.temp = NULL;
    
    s.balls = s.strikes = s.outs = s.HomeScore = s.AwayScore = s.HomeTeamLineupIndex = s.AwayTeamLineupIndex = s.TypeofHit = 0;
    s.firstbase.runnerAdvance = s.secondbase.runnerAdvance = s.thirdbase.runnerAdvance = s.atbat.runnerAdvance = 0;
    s.isBottomInning = false;
    s.numInning = 1;
    s.sideInning = @"Top";
    
    [s AwayPlayerLineup];
    [s HomePlayerLineup];
    
    s.atbat.base = [s.AwayTeam objectAtIndex:s.AwayTeamLineupIndex];
}

-(void)LoadFromPlist {
    GameDataController* s = [GameDataController sharedInstance];
    
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
    /*
    NSMutableArray *homeLineupArray = [[NSMutableArray alloc] init];
    for(NSInteger i=0;i<9;i++){
        
        Player *tempPlayer = [HomeTeam objectAtIndex:i];
        
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        
        [tempArray addObject:tempPlayer.FirstName];
        [tempArray addObject:tempPlayer.LastName];
        [tempArray addObject:tempPlayer.Position];
        [tempArray addObject:[NSNumber numberWithInt:tempPlayer.PlateAppearances]];
        [tempArray addObject:[NSNumber numberWithInt:tempPlayer.Hits]];
        [tempArray addObject:[NSNumber numberWithInt:tempPlayer.RunsScored]];
        [tempArray addObject:[NSNumber numberWithInt:tempPlayer.RBI]];
        [tempArray addObject:[NSNumber numberWithInt:tempPlayer.BattingAverage]];
        [tempArray addObject:[NSNumber numberWithInt:tempPlayer.HR]];
        
        [[homeLineupArray addObject:tempArray];
    }
        
    NSLog(@"home: %@", homeLineupArray);
     */
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

@end
