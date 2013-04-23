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
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    /*
    s.HomeTeam = [[NSMutableArray alloc] initWithCapacity:9];
    s.AwayTeam = [[NSMutableArray alloc] initWithCapacity:9];
    s.BoxScoreList = [[NSMutableArray alloc] init];
    s.FinalGameArray = [[NSMutableArray alloc] init];
    s.firstbase = [[Bases alloc] init];
    s.secondbase = [[Bases alloc] init];
    s.thirdbase = [[Bases alloc] init];
    s.atbat = [[Bases alloc] init];
    */
    
    //[self LoadFromPlist];

}

/*--------------------------------------------------------------------------------*/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*--------------------------------------------------------------------------------*/


- (IBAction)HomeButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)StartNewGame {
    /*
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
     */
}

-(void)LoadFromPlist {
    /*
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
    //***************************Restore Plist************************************************
    
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
    else
        NSLog(@"Plist restored successfully");
    /*
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
    */
    
    
    
    //NSMutableDictionary *plistRoot = [NSMutableDictionary dictionaryWithCapacity:3];
    NSMutableDictionary *subDict = [NSMutableDictionary dictionaryWithCapacity:3];

    //plistRoot = propertylist;
    
    subDict = [temp objectForKey:@"GameInfo"];
    //subDict = [plistRoot objectForKey:@"GameInfo"];
    
    s.balls = [[subDict objectForKey:@"Balls"] integerValue];
    s.strikes = [[subDict objectForKey:@"Strikes"] integerValue];
    s.outs = [[subDict objectForKey:@"Outs"] integerValue];
    s.numInning = [[subDict objectForKey:@"NumInning"] integerValue];
    s.sideInning = [subDict objectForKey:@"SideInning"];
    s.HomeScore = [[subDict objectForKey:@"HomeScore"] integerValue];
    s.AwayScore = [[subDict objectForKey:@"AwayScore"] integerValue];
    s.AwayTeamLineupIndex = [[subDict objectForKey:@"ATLI"] integerValue];
    s.HomeTeamLineupIndex = [[subDict objectForKey:@"HTLI"] integerValue];
    
    subDict = [temp objectForKey:@"AwayTeam"];
    //subDict = [plistRoot objectForKey:@"AwayTeam"];
    NSLog(@"%@", subDict);
    for(int i=0;i<9;i++)
    {
        Player *a = [[Player alloc] init];
        NSDictionary *b = [subDict objectForKey:[NSString stringWithFormat: @"Batter%d", i]];
        
        a.FirstName = [b objectForKey:@"Fname"];
        a.LastName = [b objectForKey:@"Lname"];
        a.Position = [b objectForKey:@"Position"];
        a.PlateAppearances = [[b objectForKey:@"PA"] integerValue];
        a.Hits = [[b objectForKey:@"Hits"] integerValue];
        a.RunsScored = [[b objectForKey:@"Runs"] integerValue];
        a.RBI = [[b objectForKey:@"RBI"] integerValue];
        a.HR = [[b objectForKey:@"HR"] integerValue];
        a.BattingAverage = [[b objectForKey:@"BA"] integerValue];
        
        //[s.AwayTeam addObject:a];
        
        [s.AwayTeam insertObject:a atIndex:i];
    }
    
    subDict = [temp objectForKey:@"HomeTeam"];
    //subDict = [plistRoot objectForKey:@"HomeTeam"];
    
    for(int i=0;i<9;i++)
    {
        Player *a = [[Player alloc] init];
        NSDictionary *b = [subDict objectForKey:[NSString stringWithFormat: @"Batter%d", i]];
        
        a.FirstName = [b objectForKey:@"Fname"];
        a.LastName = [b objectForKey:@"Lname"];
        a.Position = [b objectForKey:@"Position"];
        a.PlateAppearances = [[b objectForKey:@"PA"] integerValue];
        a.Hits = [[b objectForKey:@"Hits"] integerValue];
        a.RunsScored = [[b objectForKey:@"Runs"] integerValue];
        a.RBI = [[b objectForKey:@"RBI"] integerValue];
        a.HR = [[b objectForKey:@"HR"] integerValue];
        a.BattingAverage = [[b objectForKey:@"BA"] integerValue];
        
        //[s.HomeTeam addObject:a];
        
        [s.HomeTeam insertObject:a atIndex:i];
    }

}

-(void)SavePlist {
    //**************************Create Plist*************************************
    
    NSLog(@"Entering Background");
    
    GameDataController* s = [GameDataController sharedInstance];
    
    NSMutableDictionary *root = [NSMutableDictionary dictionaryWithCapacity:3];
    NSDictionary *innerDict;
    NSMutableDictionary *hLineup = [NSMutableDictionary dictionaryWithCapacity:9];
    NSMutableDictionary *aLineup = [NSMutableDictionary dictionaryWithCapacity:9];
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
        [aLineup setObject:player forKey:[NSString stringWithFormat: @"Batter%d", i]];
    }
    
    [root setObject:aLineup forKey:@"AwayTeam"];
    
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
        [hLineup setObject:player forKey:[NSString stringWithFormat: @"Batter%d", i]];
    }
    
    [root setObject:hLineup forKey:@"HomeTeam"];
    
    
    //****************************Save Plist*************************************************
    /*
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
     */
    //******************************
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    // get documents path
    NSString *documentsPath = [paths objectAtIndex:0];
    // get the path to our Data/plist file
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"GameDataPlist.plist"];
    NSString *error;
    // create NSData from dictionary
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:root format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
    
    // check is plistData exists
    if(plistData)
    {
        // write plistData to our Data.plist file
        [plistData writeToFile:plistPath atomically:YES];
        NSLog(@"Plist saved successfully");
    }
    else
    {
        NSLog(@"Error in saveData: %@", error);
    }

}

- (void)applicationDidEnterBackground:(NSNotification *)notification {
    
    /*
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
                               [NSArray arrayWithObjects:  atli, htli, awayscore, homescore, isbottominning, numinning, inning, outs, strike, ball, nil]
                                                          forKeys:[NSArray arrayWithObjects: @"AwayTeamLineupIndex", @"HomeTeamLineupIndex", @"AwayScore", @"HomeScore", @"IsBottomInning", @"SideInning", @"NumInning", @"Outs", @"Strikes", @"Balls", nil]];
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&error];
    if(plistData) {
        [plistData writeToFile:plistPath atomically:YES];
    }
    
    [self SavePlist];
    */
}

@end
