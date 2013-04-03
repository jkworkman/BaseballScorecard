//
//  BoxScoreDetailViewController.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 3/13/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "BoxScoreDetailViewController.h"

@interface BoxScoreDetailViewController ()

@end

@implementation BoxScoreDetailViewController

@synthesize tempLabel;
@synthesize tempstring;

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

    tempLabel.text = tempstring;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
