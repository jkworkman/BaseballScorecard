//
//  BaseballViewController.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/9/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "BaseballViewController.h"

@interface BaseballViewController ()

@property (nonatomic) int balls;
@property (nonatomic) int strikes;
@end

@implementation BaseballViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PitchedBall:(id)sender {
    _balls += 1;
}

- (IBAction)PitchedStrike:(id)sender {
    _strikes += 1;
}
@end
