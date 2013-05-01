//
//  BoxScoreDetailViewController.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 3/13/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "BoxScoreDetailViewController.h"
#import "GameDataController.h"
#import "BoxScoreDetailView.h"

@interface BoxScoreDetailViewController ()

@end

@implementation BoxScoreDetailViewController

@synthesize tempLabel;
@synthesize tempInt;

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
    NSMutableArray *t = [[NSMutableArray alloc] init];
    t = [s.BoxScoreList objectAtIndex:tempInt];
    NSString *r = [NSString stringWithFormat: @"%@ %@", [t objectAtIndex:0], [t objectAtIndex:1]];
    tempLabel.text = r;
}
-(void)loadView
{
    BoxScoreDetailView* a = [[BoxScoreDetailView alloc] init];
    
    GameDataController* s = [GameDataController sharedInstance];
    NSMutableArray *t = [[NSMutableArray alloc] init];
    t = [s.BoxScoreList objectAtIndex:tempInt];

    self.view = a;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [a addSubview:[self LabelProperties:100 :25 :100 :15 :[NSString stringWithFormat: @"%@ %@", [t objectAtIndex:0], [t objectAtIndex:1]]]];
    
    [a addSubview:[self LabelProperties:50 :45 :40 :15 :@"Name"]];
    [a addSubview:[self LabelProperties:125 :45 :25 :15 :@"P"]];
    [a addSubview:[self LabelProperties:150 :45 :30 :15 :@"H/AB"]];
    [a addSubview:[self LabelProperties:180 :45 :30 :15 :@"Runs"]];
    [a addSubview:[self LabelProperties:210 :45 :25 :15 :@"HR"]];
    [a addSubview:[self LabelProperties:235 :45 :25 :15 :@"RBI"]];
    [a addSubview:[self LabelProperties:260 :45 :25 :15 :@"SB"]];
    [a addSubview:[self LabelProperties:285 :45 :25 :15 :@"BA"]];
    
    int x = 5;
    int y = 60;
    int z = 2;
    
    for(int i=0;i<9;i++)
    {
        for(int j=0;j<2;j++)
        {
            [a addSubview:[self LabelProperties:x :y :60 :15 :[NSString stringWithFormat: @"%@",[t objectAtIndex:z]]]];
            x += 60;
            z += 1;
        }
        [a addSubview:[self LabelProperties:x :y :25 :15 :[NSString stringWithFormat: @"%@",[t objectAtIndex:z]]]];
        x += 25;
        z += 1;
        for(int j=0;j<2;j++)
        {
            [a addSubview:[self LabelProperties:x :y :30 :15 :[NSString stringWithFormat: @"%@",[t objectAtIndex:z]]]];
            x += 30;
            z += 1;
        }
        for(int j=0;j<4;j++)
        {
            [a addSubview:[self LabelProperties:x :y :25 :15 :[NSString stringWithFormat: @"%@",[t objectAtIndex:z]]]];
            x += 25;
            z += 1;
        }
        x = 5;
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
    
    x = 5;
    y = 240;
    for(int i=0;i<9;i++)
    {
        for(int j=0;j<2;j++)
        {
            [a addSubview:[self LabelProperties:x :y :60 :15 :[NSString stringWithFormat: @"%@",[t objectAtIndex:z]]]];
            x += 60;
            z += 1;
        }
        [a addSubview:[self LabelProperties:x :y :25 :15 :[NSString stringWithFormat: @"%@",[t objectAtIndex:z]]]];
        x += 25;
        z += 1;
        for(int j=0;j<2;j++)
        {
            [a addSubview:[self LabelProperties:x :y :30 :15 :[NSString stringWithFormat: @"%@",[t objectAtIndex:z]]]];
            x += 30;
            z += 1;
        }
        for(int j=0;j<4;j++)
        {
            [a addSubview:[self LabelProperties:x :y :25 :15 :[NSString stringWithFormat: @"%@",[t objectAtIndex:z]]]];
            x += 25;
            z += 1;
        }
        x = 5;
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
