//
//  StatsViewController.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 5/1/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "StatsViewController.h"
#import "StatsView.h"
#import "GameDataController.h"
#import "Player.h"

@interface StatsViewController ()

@end

@implementation StatsViewController

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

-(void)viewWillAppear:(BOOL)animated
{
    StatsView* a = [[StatsView alloc] init];
    
    GameDataController* s = [GameDataController sharedInstance];
    Player *t = [[Player alloc] init];
    
    self.view = a;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [a addSubview:[self LabelProperties:100 :25 :100 :15 :[NSString stringWithFormat: @"%@: %d %@: %d", s.AwayTeamName, s.AwayScore, s.HomeTeamName, s.HomeScore]]];
    
    [a addSubview:[self LabelProperties:50 :45 :40 :15 :@"Name"]];
    [a addSubview:[self LabelProperties:125 :45 :25 :15 :@"P"]];
    [a addSubview:[self LabelProperties:150 :45 :30 :15 :@"H/AB"]];
    [a addSubview:[self LabelProperties:180 :45 :30 :15 :@"Runs"]];
    [a addSubview:[self LabelProperties:210 :45 :25 :15 :@"HR"]];
    [a addSubview:[self LabelProperties:235 :45 :25 :15 :@"RBI"]];
    [a addSubview:[self LabelProperties:260 :45 :25 :15 :@"SB"]];
    [a addSubview:[self LabelProperties:285 :45 :25 :15 :@"BA"]];
    
    int y = 60;

    
    for(int i=0;i<9;i++)
    {
        t = [s.AwayTeam objectAtIndex:i];
        [a addSubview:[self LabelProperties:5 :y :60 :15 :[NSString stringWithFormat: @"%@",t.FirstName]]];
        [a addSubview:[self LabelProperties:65 :y :60 :15 :[NSString stringWithFormat: @"%@",t.LastName]]];
        [a addSubview:[self LabelProperties:125 :y :25 :15 :[NSString stringWithFormat: @"%@",t.Position]]];
        [a addSubview:[self LabelProperties:150 :y :30 :15 :[NSString stringWithFormat: @"%d/%d",t.Hits, t.PlateAppearances]]];
        [a addSubview:[self LabelProperties:180 :y :30 :15 :[NSString stringWithFormat: @"%d",t.RunsScored]]];
        [a addSubview:[self LabelProperties:210 :y :25 :15 :[NSString stringWithFormat: @"%d",t.HR]]];
        [a addSubview:[self LabelProperties:235 :y :25 :15 :[NSString stringWithFormat: @"%d",t.RBI]]];
        [a addSubview:[self LabelProperties:260 :y :25 :15 :[NSString stringWithFormat: @"%d",t.StolenBases]]];
        [a addSubview:[self LabelProperties:285 :y :25 :15 :[NSString stringWithFormat: @"%.3f",t.BattingAverage]]];
        y += 15;
    }
    
    
    [a addSubview:[self LabelProperties:50 :225 :40 :15 :@"Name"]];
    [a addSubview:[self LabelProperties:125 :225 :25 :15 :@"P"]];
    [a addSubview:[self LabelProperties:150 :225 :30 :15 :@"H/AB"]];
    [a addSubview:[self LabelProperties:180 :225 :30 :15 :@"Runs"]];
    [a addSubview:[self LabelProperties:210 :225 :25 :15 :@"HR"]];
    [a addSubview:[self LabelProperties:235 :225 :25 :15 :@"RBI"]];
    [a addSubview:[self LabelProperties:260 :225 :25 :15 :@"SB"]];
    [a addSubview:[self LabelProperties:285 :225 :25 :15 :@"BA"]];
    
    y = 240;
    
    
    for(int i=0;i<9;i++)
    {
        t = [s.HomeTeam objectAtIndex:i];
        [a addSubview:[self LabelProperties:5 :y :60 :15 :[NSString stringWithFormat: @"%@",t.FirstName]]];
        [a addSubview:[self LabelProperties:65 :y :60 :15 :[NSString stringWithFormat: @"%@",t.LastName]]];
        [a addSubview:[self LabelProperties:125 :y :25 :15 :[NSString stringWithFormat: @"%@",t.Position]]];
        [a addSubview:[self LabelProperties:150 :y :30 :15 :[NSString stringWithFormat: @"%d/%d",t.Hits, t.PlateAppearances]]];
        [a addSubview:[self LabelProperties:180 :y :30 :15 :[NSString stringWithFormat: @"%d",t.RunsScored]]];
        [a addSubview:[self LabelProperties:210 :y :25 :15 :[NSString stringWithFormat: @"%d",t.HR]]];
        [a addSubview:[self LabelProperties:235 :y :25 :15 :[NSString stringWithFormat: @"%d",t.RBI]]];
        [a addSubview:[self LabelProperties:260 :y :25 :15 :[NSString stringWithFormat: @"%d",t.StolenBases]]];
        [a addSubview:[self LabelProperties:285 :y :25 :15 :[NSString stringWithFormat: @"%.3f",t.BattingAverage]]];
        y += 15;
    }
    
}

-(UIView*)LabelProperties:(NSInteger)x :(NSInteger)y :(NSInteger)w :(NSInteger)h :(NSString *)text{
    UILabel* z = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [z setFont:[UIFont fontWithName:@"American Typewriter" size:10]];
    z.text = text;
    z.textAlignment = NSTextAlignmentCenter;
    z.adjustsFontSizeToFitWidth = YES;
    return z;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
