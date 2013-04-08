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
    
    [a addSubview:[self LabelProperties:20 :30 :@"Name"]];
    [a addSubview:[self LabelProperties:100 :30 :@"Position"]];
    [a addSubview:[self LabelProperties:140 :30 :@"Hits"]];
    [a addSubview:[self LabelProperties:180 :30 :@"Runs"]];
    [a addSubview:[self LabelProperties:220 :30 :@"HR"]];
    [a addSubview:[self LabelProperties:260 :30 :@"RBI"]];
    [a addSubview:[self LabelProperties:300 :30 :@"BA"]];
    
    int x = 20;
    int y = 60;
    int z = 2;
    
    for(int i=0;i<9;i++)
    {
        for(int j=0;j<9;j++)
        {
            [a addSubview:[self LabelProperties:x :y :[NSString stringWithFormat: @"%@",[t objectAtIndex:z]]]];
            x += 40;
            z += 1;
        }
        x = 20;
        y += 15;
    }

}

-(UIView*)LabelProperties:(NSInteger)x :(NSInteger)y :(NSString *)text {
    UILabel* z = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 40, 15)];
    [z setFont:[UIFont fontWithName:@"American Typewriter" size:8]];
    z.text = text;
    z.adjustsFontSizeToFitWidth = YES;
    return z;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
