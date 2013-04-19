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
    
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:app];
    
    [self RestorePList];
}

-(void)SavePList {
    //**************************Create Plist*************************************
    
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
    NSLog(@"%@", plist);
}
    
-(void)RestorePList {
        
    //***************************Restore Plist************************************************
    
    GameDataController* s = [GameDataController sharedInstance];
    
    NSMutableDictionary *plistRoot = [NSMutableDictionary dictionaryWithCapacity:3];
    NSMutableDictionary *subDict = [NSMutableDictionary dictionaryWithCapacity:3];
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
    plistRoot = propertylist;
    
    subDict = [plistRoot objectForKey:@"GameInfo"];

    s.balls = [[subDict objectForKey:@"Balls"] integerValue];
    s.strikes = [[subDict objectForKey:@"Strikes"] integerValue];
    s.outs = [[subDict objectForKey:@"Outs"] integerValue];
    s.numInning = [[subDict objectForKey:@"NumInning"] integerValue];
    s.sideInning = [subDict objectForKey:@"SideInning"];
    s.HomeScore = [[subDict objectForKey:@"HomeScore"] integerValue];
    s.AwayScore = [[subDict objectForKey:@"AwayScore"] integerValue];
    s.AwayTeamLineupIndex = [[subDict objectForKey:@"ATLI"] integerValue];
    s.HomeTeamLineupIndex = [[subDict objectForKey:@"HTLI"] integerValue];
    
    subDict = [plistRoot objectForKey:@"AwayTeam"];
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
       
        [s.AwayTeam addObject:a];
    }
    
    subDict = [plistRoot objectForKey:@"HomeTeam"];

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
        
        [s.HomeTeam addObject:a];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)MainMenuButton:(id)sender {
    
}





- (void)applicationDidEnterBackground:(NSNotification *)notification {
    NSLog(@"Entering Background");
    
    //[self SavePList];
}
@end
