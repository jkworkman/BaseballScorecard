//
//  BoxScoreDetailViewController.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 3/13/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "BoxScoreDetailViewController.h"
#import "GameDataController.h"

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
    
    UILabel* a = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    a.text = r;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
