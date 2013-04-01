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
@end
