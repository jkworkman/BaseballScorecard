//
//  AwayLineupViewController.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/13/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "AwayLineupViewController.h"
#import "BaseballViewController.h"

@class GameTabViewController;

@interface AwayLineupViewController ()

@end

@implementation AwayLineupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _Lineup = [[GameTabViewController alloc] init];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)AwaySubmit:(id)sender {
    /*
    _game.dataController.temp = _FirstFirstName.text;
     */
    _Lineup.dataController.temp = _FirstFirstName.text;
    NSLog(@"Temp Variable: %@" , _FirstFirstName.text);
}
@end
