//
//  BoxScoreDetailViewController.h
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 3/13/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "BoxScoreDetailView.h"
#import <UIKit/UIKit.h>

@interface BoxScoreDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (nonatomic) NSInteger tempInt;

-(UIView*)LabelProperties:(NSInteger)x :(NSInteger)y :(NSInteger)w :(NSInteger)h :(NSString *)text;

@end
