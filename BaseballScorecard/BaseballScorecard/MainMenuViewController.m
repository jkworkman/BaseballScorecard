//
//  MainMenuViewController.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 4/1/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "MainMenuViewController.h"
#import "GameDataController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

@synthesize ResumeGameLabel;

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
    
    GameDataController* s = [GameDataController sharedInstance];
    
    [self StartGame];
    //**************************Create Plist*************************************
    NSMutableDictionary *root = [NSMutableDictionary dictionaryWithCapacity:3];
    NSDictionary *innerDict;
    NSMutableDictionary *Lineup = [NSMutableDictionary dictionaryWithCapacity:9];
    NSMutableDictionary *player = [NSMutableDictionary dictionaryWithCapacity:1];
    
    NSNumber *balls = [NSNumber numberWithInt:s.balls];
    NSNumber *strikes = [NSNumber numberWithInt:s.strikes];
    NSNumber *outs = [NSNumber numberWithInt:s.balls];
    NSNumber *numInning = [NSNumber numberWithInt:s.numInning];
    NSString *sideInning = s.sideInning;
    NSNumber *homeScore = [NSNumber numberWithInt:s.HomeScore];
    NSNumber *awayScore = [NSNumber numberWithInt:s.AwayScore];
    NSNumber *htli = [NSNumber numberWithInt:s.HomeTeamLineupIndex];
    NSNumber *atli = [NSNumber numberWithInt:s.AwayTeamLineupIndex];
    
    innerDict = [NSDictionary dictionaryWithObjects:
                 [NSArray arrayWithObjects: balls, strikes, outs, numInning, sideInning, homeScore, awayScore, htli, atli, nil]
                    forKeys:[NSArray arrayWithObjects:@"Balls", @"Strikes", @"Outs", @"NumInning", @"SideInning", @"HomeScore", @"AwayScore", @"HTLI", @"ATLI", nil]];
    
    [root setObject:innerDict forKey:@"GameInfo"];
    
    for(int i=0;i<9;i++)
    {
        Player *temp = [s.AwayTeam objectAtIndex:i];
        NSString *fname = temp.FirstName;
        NSString *lname = temp.LastName;
        NSString *position = temp.Position;
        NSNumber *pa = [NSNumber numberWithInt:temp.PlateAppearances];
        NSNumber *hits = [NSNumber numberWithInt:temp.Hits];
        NSNumber *runs = [NSNumber numberWithInt:temp.RunsScored];
        NSNumber *rbi = [NSNumber numberWithInt:temp.RBI];
        NSNumber *hr = [NSNumber numberWithInt:temp.HR];
        NSNumber *ba = [NSNumber numberWithInt:temp.BattingAverage];
    
        player = [NSDictionary dictionaryWithObjects:
                 [NSArray arrayWithObjects: fname, lname, position, pa, hits, runs, rbi, hr, ba, nil]
                        forKeys:[NSArray arrayWithObjects:@"Fname", @"Lname", @"Position", @"PA", @"Hits", @"Runs", @"RBI", @"HR", @"BA", nil]];
        [Lineup setObject:player forKey:[NSString stringWithFormat: @"Batter%d", i]];
    }
    
    [root setObject:Lineup forKey:@"AwayLineup"];
    
    for(int i=0;i<9;i++)
    {
        Player *temp = [s.HomeTeam objectAtIndex:i];
        NSString *fname = temp.FirstName;
        NSString *lname = temp.LastName;
        NSString *position = temp.Position;
        NSNumber *pa = [NSNumber numberWithInt:temp.PlateAppearances];
        NSNumber *hits = [NSNumber numberWithInt:temp.Hits];
        NSNumber *runs = [NSNumber numberWithInt:temp.RunsScored];
        NSNumber *rbi = [NSNumber numberWithInt:temp.RBI];
        NSNumber *hr = [NSNumber numberWithInt:temp.HR];
        NSNumber *ba = [NSNumber numberWithInt:temp.BattingAverage];
        
        player = [NSDictionary dictionaryWithObjects:
                  [NSArray arrayWithObjects: fname, lname, position, pa, hits, runs, rbi, hr, ba, nil]
                                             forKeys:[NSArray arrayWithObjects:@"Fname", @"Lname", @"Position", @"PA", @"Hits", @"Runs", @"RBI", @"HR", @"BA", nil]];
        [Lineup setObject:player forKey:[NSString stringWithFormat: @"Batter%d", i]];
    }
    
    [root setObject:Lineup forKey:@"HomeLineup"];
    //NSLog(@"%@", root);
    
    //****************************Save Plist*************************************************
    
    id plist = root;       // Assume this property list exists.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"GameDataPlist" ofType:@"plist"];
    NSData *xmlData;
    NSString *error;
    
    xmlData = [NSPropertyListSerialization dataFromPropertyList:plist
                                                         format:NSPropertyListXMLFormat_v1_0
                                               errorDescription:&error];
    if(xmlData) {
        NSLog(@"No error creating XML data.");
        [xmlData writeToFile:path atomically:YES];
    }
    else {
        NSLog(@"Error creating XML data");
    }
    //NSLog(@"%@", plist);
    
    //***************************Restore Plist************************************************
    
    NSString *restorepath = [[NSBundle mainBundle] pathForResource:@"GameDataPlist" ofType:@"plist"];
    NSData *plistData = [NSData dataWithContentsOfFile:restorepath];
    NSString *errors;
    NSPropertyListFormat format;
    id propertylist;
    
    propertylist = [NSPropertyListSerialization propertyListFromData:plistData
                                             mutabilityOption:NSPropertyListImmutable
                                                       format:&format
                                             errorDescription:&errors];
    if(!propertylist)
        NSLog(@"Error restoring plist: %@", errors);
    else
        NSLog(@"Plist restored Successfully");
    //NSLog(@"%@", propertylist);
    root = propertylist;
    NSLog(@"%@", root);
    //****************************************************************************************
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)MainMenuButton:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    
    s.GameInProgress = false;
}

- (IBAction)ResumeGameButton:(id)sender {
    GameDataController* s = [GameDataController sharedInstance];
    
    s.GameInProgress = true;
}

-(void)StartGame {
    GameDataController* s = [GameDataController sharedInstance];
    
    s.HomeTeam = [[NSMutableArray alloc] initWithCapacity:9];
    s.AwayTeam = [[NSMutableArray alloc] initWithCapacity:9];
    s.BoxScoreList = [[NSMutableArray alloc] init];
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
@end
