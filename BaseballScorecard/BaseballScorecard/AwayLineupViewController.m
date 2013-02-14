//
//  AwayLineupViewController.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/13/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "AwayLineupViewController.h"
#import "BaseballViewController.h"

@interface AwayLineupViewController ()

@end

@implementation AwayLineupViewController

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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"Return"]) {
        BaseballViewController *newtemp = [[BaseballViewController alloc] init];
        newtemp.temp = @"ThisString";
        NSLog(@"tempString: %@", newtemp.temp);
    }
}

@end
