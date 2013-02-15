//
//  GameTabViewController.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/14/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "GameTabViewController.h"

@interface GameTabViewController ()

@end

@implementation GameTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dataController = [[GameDataController alloc] init];
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

@end
