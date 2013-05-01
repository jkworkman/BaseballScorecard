//
//  Quartz2D.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/18/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "Quartz2D.h"
#import "GameDataController.h"
#import "BoxScoreMasterViewController.h"
#import "BaseballViewController.h"
#import <QuartzCore/QuartzCore.h>
#include <math.h>

static inline double radians (double degrees) {return degrees * M_PI/180;}

@implementation Quartz2D

@synthesize HomeScoreLabel;
@synthesize AwayScoreLabel;
@synthesize PitchCountLabel;
@synthesize InningLabel;
@synthesize PitchButtonLabel;
@synthesize UndoButtonLabel;
@synthesize RedoButtonLabel;
@synthesize FirstBaseLabel;
@synthesize SecondBaseLabel;
@synthesize ThirdBaseLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self UpdateLabels];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    for (UIView *subview in [self subviews]) {
        if (subview.tag == 1) {
            [subview removeFromSuperview];
        }
    }
    GameDataController* s = [GameDataController sharedInstance];
    
    FirstBaseLabel.text = NULL;
    SecondBaseLabel.text = NULL;
    ThirdBaseLabel.text = NULL;
    
    int x = 160;
    int y = 375;
    [self DrawField:x :y];
    
    if(s.atbat.runnerAdvance == 1)
        [self DrawSingle:x :y];
    else if(s.atbat.runnerAdvance == 2)
        [self DrawDouble:x :y];
    else if(s.atbat.runnerAdvance == 3)
        [self DrawTriple:x :y];
    else if(s.atbat.runnerAdvance == 4)
        [self DrawHomeRun:x :y];

    if(s.firstbase.runnerAdvance == 1)
        [self DrawFirstToSecond:x :y];
    else if(s.firstbase.runnerAdvance == 2)
        [self DrawFirstToThird:x :y];
    else if(s.firstbase.runnerAdvance == 3)
        [self DrawFirstToHome:x :y];
    else if(s.firstbase.runnerAdvance == 5)
        [self DrawStayOnFirst:x :y];

    if(s.secondbase.runnerAdvance == 1)
        [self DrawSecondToThird:x :y];
    else if(s.secondbase.runnerAdvance == 2)
        [self DrawSecondToHome:x :y];
    else if(s.secondbase.runnerAdvance == 5)
        [self DrawStayOnSecond:x :y];

    if(s.thirdbase.runnerAdvance == 1)
        [self DrawThirdToHome:x :y];
    else if(s.thirdbase.runnerAdvance == 5)
        [self DrawStayOnThird:x :y];
    
    if(s.firstbase.base != NULL)
        FirstBaseLabel.text = [NSString stringWithFormat:@"%@", s.firstbase.base.LastName];
    if(s.secondbase.base != NULL)

        SecondBaseLabel.text = [NSString stringWithFormat:@"%@", s.secondbase.base.LastName];
    if(s.thirdbase.base != NULL)
        ThirdBaseLabel.text = [NSString stringWithFormat:@"%@", s.thirdbase.base.LastName];
    
    s.firstbase.runnerAdvance = s.secondbase.runnerAdvance = s.thirdbase.runnerAdvance = s.atbat.runnerAdvance = 0;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    GameDataController* s = [GameDataController sharedInstance];
    
    switch ( actionSheet.tag )
    {
        case 0: /* MainMenuActionSheet */
        {
            switch ( buttonIndex )
            {
                case 0: /* Ball button*/
                    [s PitchedBall];
                    [self RunnerAdvancing];
                    break;
                case 1: /* Strike button */
                    [s PitchedStrike];
                    [self RunnerAdvancing];
                    break;
                case 2: /* Foul Ball button */
                    if(s.strikes != 2)
                        s.strikes += 1;
                    [self UpdateLabels];
                    break;
                case 3: /* Hit button */
                    [self ShowHitMenu];
                    break;
                case 4: /* Runners button */
                    [self ShowRunnersMenu];
                    break;
            }
        }
            break;
        case 1: /* SubMenuActionSheet */
            switch ( buttonIndex )
        {
            case 0: /* Single button*/
                [s HitSingle];
                [self RunnerAdvancing];
                break;
            case 1: /* Double button */
                [s HitDouble];
                [self RunnerAdvancing];
                break;
            case 2: /* Triple button */
                [s HitTriple];
                [self RunnerAdvancing];
                break;
            case 3: /* HomeRun button */
                [s HitHomeRun];
                [self RunnerAdvancing];
                break;
            case 4: /* HitOut button */
                [s HitOut];
                [self RunnerAdvancing];
                break;
        }
            break;
        case 2: /* RunnerOnThirdActionSheet */
            switch ( buttonIndex )
        {
            case 0: /* Out button*/
                [s RunnerOut];
                [self RunnerAdvancing];
                break;
            case 1: /* Score button */
                s.thirdbase.runnerAdvance = 1;
                [s RunnerScores];
                [self RunnerAdvancing];
                break;
            case 2: /* StayOnBase button */
                s.thirdbase.runnerAdvance = 5;
                [s RunnerStaysOnBase];
                [self RunnerAdvancing];
                break;
        }
            break;
        case 3: /* RunnerOnSecondActionSheet */
            switch ( buttonIndex )
        {
            case 0: /* Out button*/
                [s RunnerOut];
                [self RunnerAdvancing];
                break;
            case 1: /* Score button */
                s.secondbase.runnerAdvance = 2;
                [s RunnerScores];
                [self RunnerAdvancing];
                break;
            case 2: /* AdvanceToThird button */
                s.secondbase.runnerAdvance = 1;
                [s RunnerToThird];
                [self RunnerAdvancing];
                break;
            case 3: /* StayOnBase button */
                s.secondbase.runnerAdvance = 5;
                [s RunnerStaysOnBase];
                [self RunnerAdvancing];
                break;
        }
            break;
        case 4: /* RunnerOnFirstActionSheet */
            switch ( buttonIndex )
        {
            case 0: /* Out button*/
                [s RunnerOut];
                [self RunnerAdvancing];
                break;
            case 1: /* Score button */
                s.firstbase.runnerAdvance = 3;
                [s RunnerScores];
                [self RunnerAdvancing];
                break;
            case 2: /* AdvanceToThird button */
                s.firstbase.runnerAdvance = 2;
                [s RunnerToThird];
                [self RunnerAdvancing];
                break;
            case 3: /* AdvanceToSecond button */
                s.firstbase.runnerAdvance = 1;
                [s RunnerToSecond];
                [self RunnerAdvancing];
                break;
            case 4: /* StayOnBase button */
                s.firstbase.runnerAdvance = 5;
                [s RunnerStaysOnBase];
                [self RunnerAdvancing];
                break;
        }
            break;
        case 5: /* RunnersActionSheet */
            switch ( buttonIndex )
        {
            case 0: /* RunnerOnFirst button*/
                s.whichRunner = 1;
                [self ShowStealMenu];
                break;
            case 1: /* RunnerOnSecond button */
                s.whichRunner = 2;
                [self ShowStealMenu];
                break;
            case 2: /* RunnerOnThird button */
                s.whichRunner = 3;
                [self ShowStealMenu];
                break;
        }
            break;
        case 6: /* RunnersActionSheet */
            switch ( buttonIndex )
        {
            case 0: /* RunnerOnSecond button*/
                s.whichRunner = 2;
                [self ShowStealMenu];
                break;
            case 1: /* RunnerOnThird button */
                s.whichRunner = 3;
                [self ShowStealMenu];
                break;
        }
            break;
        case 7: /* RunnersActionSheet */
            switch ( buttonIndex )
        {
            case 0: /* RunnerOnThird button*/
                s.whichRunner = 3;
                [self ShowStealMenu];
                break;
        }
            break;
        case 8: /*SB/CS Actionsheet*/
            switch ( buttonIndex )
        {
            case 0: /*Picked Off*/
                [s RunnerPickedOff];
                [self RunnerAdvancing];
                break;
            case 1: /*SB button*/
                [s RunnerSteals];
                [self RunnerAdvancing];
                break;
            case 2: /*CS button*/
                [s RunnerPickedOff];
                [self RunnerAdvancing];
                break;
        }
            break;
    }
}
/*--------------------------------------------------------------------------------*/
-(void)RunnerAdvancing {
    
    GameDataController* s = [GameDataController sharedInstance];

    if(s.firstbase.base != NULL && s.firstbase.checked == false)
        [self RunnerOnFirstMenu];
    else if(s.secondbase.base != NULL && s.secondbase.checked == false)
        [self RunnerOnSecondMenu];
    else if(s.thirdbase.base != NULL && s.thirdbase.checked == false)
        [self RunnerOnThirdMenu];
    else
    {
        [self setNeedsDisplay];
        //UndoButtonLabel.hidden = false;
        s.firstbase.base = s.firstbase.temp;
        s.secondbase.base = s.secondbase.temp;
        s.thirdbase.base = s.thirdbase.temp;
        s.firstbase.checked = s.secondbase.checked = s.thirdbase.checked = false;
        s.firstbase.temp = s.secondbase.temp = s.thirdbase.temp = NULL;
        
        if(s.TypeofHit != 5)
        {
            s.balls = 0;
            s.strikes = 0;
            [s BatterHit];
        }
        s.TypeofHit = 0;
        
        [self UpdateLabels];
        [self Log];
        
        if(s.numInning >=2 && s.HomeScore != s.AwayScore)
        {
            [self GameEnded];
        }
    }
}
/*--------------------------------------------------------------------------------*/
-(void)ShowPitchCountMenu {
    
    GameDataController* s = [GameDataController sharedInstance];
    
    if(s.firstbase.base != NULL || s.secondbase.base != NULL || s.thirdbase.base != NULL)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Pitch Menu"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Ball", @"Strike", @"Foul Ball", @"Ball in Play", @"Runners", nil];
        actionSheet.tag = 0;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Pitch Menu"
                                      delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Ball", @"Strike", @"Foul Ball", @"Ball in Play", nil];
        actionSheet.tag = 0;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
        
}

-(void) ShowRunnersMenu {

    GameDataController* s = [GameDataController sharedInstance];
    
    if(s.firstbase.base != NULL && s.secondbase.base != NULL && s.thirdbase.base != NULL)
    {
        s.firstbase.runnerAdvance = 5;
        s.secondbase.runnerAdvance = 5;
        s.thirdbase.runnerAdvance = 5;
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runners Menu"
                                      delegate:self
                                      cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Runner On First", @"Runner On Second", @"Runner On Third", nil];
        actionSheet.tag = 5;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    else if(s.firstbase.base != NULL && s.secondbase.base != NULL)
    {
        s.firstbase.runnerAdvance = 5;
        s.secondbase.runnerAdvance = 5;
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runners Menu"
                                      delegate:self
                                      cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Runner On First", @"Runner On Second", nil];
        actionSheet.tag = 5;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    else if(s.firstbase.base != NULL)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runners Menu"
                                      delegate:self
                                      cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Runner On First", nil];
        actionSheet.tag = 5;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    else if(s.secondbase.base != NULL && s.thirdbase.base != NULL)
    {
        s.secondbase.runnerAdvance = 5;
        s.thirdbase.runnerAdvance = 5;
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runners Menu"
                                      delegate:self
                                      cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Runner On Second", @"Runner On Third", nil];
        actionSheet.tag = 6;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    else if(s.secondbase.base != NULL)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runners Menu"
                                      delegate:self
                                      cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Runner On Second", nil];
        actionSheet.tag = 6;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    else if(s.thirdbase.base != NULL)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runners Menu"
                                      delegate:self
                                      cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Runner On Third", nil];
        actionSheet.tag = 7;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
}
-(void)ShowStealMenu {
    
    GameDataController* s = [GameDataController sharedInstance];
    
    if((s.whichRunner == 1 && s.secondbase.base == NULL) || (s.whichRunner == 2 && s.thirdbase.base == NULL) || (s.whichRunner == 3))
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Runners Menu"
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Picked Off", @"Steals Base", @"Caught Stealing", nil];
        actionSheet.tag = 8;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runners Menu"
                                      delegate:self
                                      cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Picked Off", nil];
        actionSheet.tag = 8;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    
}
/*--------------------------------------------------------------------------------*/
-(void)ShowHitMenu {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Ball in Play"
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Single", @"Double", @"Triple", @"Home Run", @"Out", nil];
    actionSheet.tag = 1;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    
}
/*--------------------------------------------------------------------------------*/
-(void)RunnerOnThirdMenu {
    
    GameDataController* s = [GameDataController sharedInstance];
    
    if(s.TypeofHit != 3 && s.thirdbase.temp == 0 && s.firstbase.runnerAdvance != 3 && s.secondbase.runnerAdvance != 2)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runner On Third"
                                      delegate:self
                                      cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Out", @"Score", @"Stay On Base", nil];
        actionSheet.tag = 2;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runner On Third"
                                      delegate:self
                                      cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Out", @"Score", nil];
        actionSheet.tag = 2;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
}
/*--------------------------------------------------------------------------------*/
-(void) RunnerOnSecondMenu {
    
    GameDataController* s = [GameDataController sharedInstance];
    
    if(s.TypeofHit == 1 && s.secondbase.temp == NULL && s.thirdbase.temp == NULL && s.firstbase.runnerAdvance != 3 && s.firstbase.runnerAdvance != 2)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runner On Second"
                                      delegate:self
                                      cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Out", @"Score", @"Advance To Third", @"Stay On Base", nil];
        actionSheet.tag = 3;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    else if(s.TypeofHit != 3 && s.thirdbase.temp == NULL && s.firstbase.runnerAdvance != 3 && s.firstbase.runnerAdvance != 2)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runner On Second"
                                      delegate:self
                                      cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Out", @"Score", @"Advance To Third", nil];
        actionSheet.tag = 3;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runner On Second"
                                      delegate:self
                                      cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Out", @"Score", nil];
        actionSheet.tag = 3;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
}
/*--------------------------------------------------------------------------------*/
-(void) RunnerOnFirstMenu {
    
    GameDataController* s = [GameDataController sharedInstance];
    
    if(s.TypeofHit == 5)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runner On First"
                                      delegate:self
                                      cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Out", @"Score", @"Advance To Third", @"Advance To Second", @"Stay On Base", nil];
        actionSheet.tag = 4;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    else if(s.TypeofHit == 1)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runner On First"
                                      delegate:self
                                      cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Out", @"Score", @"Advance To Third", @"Advance To Second", nil];
        actionSheet.tag = 4;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    else if(s.TypeofHit == 2)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runner On First"
                                      delegate:self
                                      cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Out", @"Score", @"Advance To Third", nil];
        actionSheet.tag = 4;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Runner On First"
                                      delegate:self
                                      cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Out", @"Score", nil];
        actionSheet.tag = 4;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
}


-(void)DrawHomeRun:(int)x :(int)y {
    
    
    //Prepare the animation - we use keyframe animation for animations of this complexity
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //Set some variables on the animation
    pathAnimation.calculationMode = kCAAnimationPaced;
    //We want the animation to persist - not so important in this case - but kept for clarity
    //If we animated something from left to right - and we wanted it to stay in the new position,
    //then we would need these parameters
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.duration = 4.0;
    //Lets loop continuously for the demonstration
    //pathAnimation.repeatCount = 1000;
    
    //Setup the path for the animation - this is very similar as the code the draw the line
    //instead of drawing to the graphics context, instead we draw lines on a CGPathRef
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, x, y-20);

    CGPathAddLineToPoint(curvedPath, NULL, x+100, y-124);
    CGPathAddLineToPoint(curvedPath, NULL, x, y-228);
    CGPathAddLineToPoint(curvedPath, NULL, x-100, y-124);
    CGPathAddLineToPoint(curvedPath, NULL, x, y-20);
    //Now we have the path, we tell the animation we want to use this path - then we release the path
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    //We will now draw a circle at the start of the path which we will animate to follow the path
    //We use the same technique as before to draw to a bitmap context and then eventually create
    //a UIImageView which we add to our view
    UIGraphicsBeginImageContext(CGSizeMake(25,25));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //Set context variables
    CGContextSetLineWidth(ctx, 1.5);
    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    //Draw a circle - and paint it with a different outline (white) and fill color (green)
    CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, 22, 22));
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *circleView = [[UIImageView alloc] initWithImage:circle];
    circleView = [[UIImageView alloc] initWithImage:circle];
    circleView.frame = CGRectMake(1, 1, 27, 27);
    circleView.tag = 1;
    [self addSubview:circleView];
    
    //Add the animation to the circleView - once you add the animation to the layer, the animation starts
    //[circleView.layer addAnimation:pathAnimation forKey:@"HomeRun"];
    
    [UIView animateWithDuration:4.0f animations:^
    { 
        circleView.alpha=4.0f;
        [circleView.layer addAnimation:pathAnimation forKey:@"HomeRun"];
    }
                     completion:^(BOOL finished)
    {
        [circleView removeFromSuperview];
    }];
}

-(void)DrawSingle:(int)x :(int)y {
    
    //Prepare the animation - we use keyframe animation for animations of this complexity
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //Set some variables on the animation
    pathAnimation.calculationMode = kCAAnimationPaced;
    //We want the animation to persist - not so important in this case - but kept for clarity
    //If we animated something from left to right - and we wanted it to stay in the new position,
    //then we would need these parameters
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 1.0;
    //Lets loop continuously for the demonstration
    //pathAnimation.repeatCount = 1000;
    
    //Setup the path for the animation - this is very similar as the code the draw the line
    //instead of drawing to the graphics context, instead we draw lines on a CGPathRef
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, x, y-20);
    
    CGPathAddLineToPoint(curvedPath, NULL, x+100, y-124);
    //CGPathAddLineToPoint(curvedPath, NULL, x, y-228);
    //CGPathAddLineToPoint(curvedPath, NULL, x-100, y-124);
    //CGPathAddLineToPoint(curvedPath, NULL, x, y-20);
    //Now we have the path, we tell the animation we want to use this path - then we release the path
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    //We will now draw a circle at the start of the path which we will animate to follow the path
    //We use the same technique as before to draw to a bitmap context and then eventually create
    //a UIImageView which we add to our view
    UIGraphicsBeginImageContext(CGSizeMake(25,25));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //Set context variables
    CGContextSetLineWidth(ctx, 1.5);
    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    //Draw a circle - and paint it with a different outline (white) and fill color (green)
    CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, 22, 22));
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *circleView = [[UIImageView alloc] initWithImage:circle];
    circleView.frame = CGRectMake(1, 1, 27, 27);
    circleView.tag = 1;
    [self addSubview:circleView];
    
    //Add the animation to the circleView - once you add the animation to the layer, the animation starts
    [circleView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];
    
}

-(void)DrawDouble:(int)x :(int)y {
    
    //Prepare the animation - we use keyframe animation for animations of this complexity
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //Set some variables on the animation
    pathAnimation.calculationMode = kCAAnimationPaced;
    //We want the animation to persist - not so important in this case - but kept for clarity
    //If we animated something from left to right - and we wanted it to stay in the new position,
    //then we would need these parameters
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 2.0;
    //Lets loop continuously for the demonstration
    //pathAnimation.repeatCount = 1000;
    
    //Setup the path for the animation - this is very similar as the code the draw the line
    //instead of drawing to the graphics context, instead we draw lines on a CGPathRef
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, x, y-20);
    
    CGPathAddLineToPoint(curvedPath, NULL, x+100, y-124);
    CGPathAddLineToPoint(curvedPath, NULL, x, y-228);
    //CGPathAddLineToPoint(curvedPath, NULL, x-100, y-124);
    //CGPathAddLineToPoint(curvedPath, NULL, x, y-20);
    //Now we have the path, we tell the animation we want to use this path - then we release the path
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    //We will now draw a circle at the start of the path which we will animate to follow the path
    //We use the same technique as before to draw to a bitmap context and then eventually create
    //a UIImageView which we add to our view
    UIGraphicsBeginImageContext(CGSizeMake(25,25));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //Set context variables
    CGContextSetLineWidth(ctx, 1.5);
    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    //Draw a circle - and paint it with a different outline (white) and fill color (green)
    CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, 22, 22));
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *circleView = [[UIImageView alloc] initWithImage:circle];
    circleView.frame = CGRectMake(1, 1, 27, 27);
    circleView.tag = 1;
    [self addSubview:circleView];
    
    //Add the animation to the circleView - once you add the animation to the layer, the animation starts
    [circleView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];
    
}

-(void)DrawTriple:(int)x :(int)y {
    
    //Prepare the animation - we use keyframe animation for animations of this complexity
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //Set some variables on the animation
    pathAnimation.calculationMode = kCAAnimationPaced;
    //We want the animation to persist - not so important in this case - but kept for clarity
    //If we animated something from left to right - and we wanted it to stay in the new position,
    //then we would need these parameters
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 3.0;
    //Lets loop continuously for the demonstration
    //pathAnimation.repeatCount = 1000;
    
    //Setup the path for the animation - this is very similar as the code the draw the line
    //instead of drawing to the graphics context, instead we draw lines on a CGPathRef
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, x, y-20);
    
    CGPathAddLineToPoint(curvedPath, NULL, x+100, y-124);
    CGPathAddLineToPoint(curvedPath, NULL, x, y-228);
    CGPathAddLineToPoint(curvedPath, NULL, x-100, y-124);
    //CGPathAddLineToPoint(curvedPath, NULL, x, y-20);
    //Now we have the path, we tell the animation we want to use this path - then we release the path
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    //We will now draw a circle at the start of the path which we will animate to follow the path
    //We use the same technique as before to draw to a bitmap context and then eventually create
    //a UIImageView which we add to our view
    UIGraphicsBeginImageContext(CGSizeMake(25,25));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //Set context variables
    CGContextSetLineWidth(ctx, 1.5);
    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    //Draw a circle - and paint it with a different outline (white) and fill color (green)
    CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, 22, 22));
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *circleView = [[UIImageView alloc] initWithImage:circle];
    circleView.frame = CGRectMake(1, 1, 27, 27);
    circleView.tag = 1;
    [self addSubview:circleView];
    
    //Add the animation to the circleView - once you add the animation to the layer, the animation starts
    [circleView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];
    
}

-(void)DrawFirstToHome:(int)x :(int)y {
    
    //Prepare the animation - we use keyframe animation for animations of this complexity
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //Set some variables on the animation
    pathAnimation.calculationMode = kCAAnimationPaced;
    //We want the animation to persist - not so important in this case - but kept for clarity
    //If we animated something from left to right - and we wanted it to stay in the new position,
    //then we would need these parameters
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.duration = 3.0;
    //Lets loop continuously for the demonstration
    //pathAnimation.repeatCount = 1000;
    
    //Setup the path for the animation - this is very similar as the code the draw the line
    //instead of drawing to the graphics context, instead we draw lines on a CGPathRef
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, x+100, y-124);
    
    CGPathAddLineToPoint(curvedPath, NULL, x, y-228);
    CGPathAddLineToPoint(curvedPath, NULL, x-100, y-124);
    CGPathAddLineToPoint(curvedPath, NULL, x, y-20);
    //Now we have the path, we tell the animation we want to use this path - then we release the path
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    //We will now draw a circle at the start of the path which we will animate to follow the path
    //We use the same technique as before to draw to a bitmap context and then eventually create
    //a UIImageView which we add to our view
    UIGraphicsBeginImageContext(CGSizeMake(25,25));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //Set context variables
    CGContextSetLineWidth(ctx, 1.5);
    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    //Draw a circle - and paint it with a different outline (white) and fill color (green)
    CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, 22, 22));
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *circleView = [[UIImageView alloc] initWithImage:circle];
    circleView.frame = CGRectMake(1, 1, 27, 27);
    circleView.tag = 1;
    [self addSubview:circleView];
    
    //Add the animation to the circleView - once you add the animation to the layer, the animation starts
    [UIView animateWithDuration:3.0f animations:^
     {
         circleView.alpha=3.0f;
         [circleView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];
     }
                     completion:^(BOOL finished)
     {
         [circleView removeFromSuperview];
     }];
    
}

-(void)DrawFirstToThird:(int)x :(int)y {
    
    //Prepare the animation - we use keyframe animation for animations of this complexity
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //Set some variables on the animation
    pathAnimation.calculationMode = kCAAnimationPaced;
    //We want the animation to persist - not so important in this case - but kept for clarity
    //If we animated something from left to right - and we wanted it to stay in the new position,
    //then we would need these parameters
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 2.0;
    //Lets loop continuously for the demonstration
    //pathAnimation.repeatCount = 1000;
    
    //Setup the path for the animation - this is very similar as the code the draw the line
    //instead of drawing to the graphics context, instead we draw lines on a CGPathRef
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, x+100, y-124);
    
    CGPathAddLineToPoint(curvedPath, NULL, x, y-228);
    CGPathAddLineToPoint(curvedPath, NULL, x-100, y-124);
    //CGPathAddLineToPoint(curvedPath, NULL, x, y-20);
    //Now we have the path, we tell the animation we want to use this path - then we release the path
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    //We will now draw a circle at the start of the path which we will animate to follow the path
    //We use the same technique as before to draw to a bitmap context and then eventually create
    //a UIImageView which we add to our view
    UIGraphicsBeginImageContext(CGSizeMake(25,25));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //Set context variables
    CGContextSetLineWidth(ctx, 1.5);
    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    //Draw a circle - and paint it with a different outline (white) and fill color (green)
    CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, 22, 22));
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *circleView = [[UIImageView alloc] initWithImage:circle];
    circleView.frame = CGRectMake(1, 1, 27, 27);
    circleView.tag = 1;
    [self addSubview:circleView];
    
    //Add the animation to the circleView - once you add the animation to the layer, the animation starts
    [circleView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];
    
}

-(void)DrawFirstToSecond:(int)x :(int)y {
    
    //Prepare the animation - we use keyframe animation for animations of this complexity
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //Set some variables on the animation
    pathAnimation.calculationMode = kCAAnimationPaced;
    //We want the animation to persist - not so important in this case - but kept for clarity
    //If we animated something from left to right - and we wanted it to stay in the new position,
    //then we would need these parameters
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 1.0;
    //Lets loop continuously for the demonstration
    //pathAnimation.repeatCount = 1000;
    
    //Setup the path for the animation - this is very similar as the code the draw the line
    //instead of drawing to the graphics context, instead we draw lines on a CGPathRef
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, x+100, y-124);
    
    CGPathAddLineToPoint(curvedPath, NULL, x, y-228);
    //CGPathAddLineToPoint(curvedPath, NULL, x-100, y-124);
    //CGPathAddLineToPoint(curvedPath, NULL, x, y-20);
    //Now we have the path, we tell the animation we want to use this path - then we release the path
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    //We will now draw a circle at the start of the path which we will animate to follow the path
    //We use the same technique as before to draw to a bitmap context and then eventually create
    //a UIImageView which we add to our view
    UIGraphicsBeginImageContext(CGSizeMake(25,25));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //Set context variables
    CGContextSetLineWidth(ctx, 1.5);
    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    //Draw a circle - and paint it with a different outline (white) and fill color (green)
    CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, 22, 22));
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *circleView = [[UIImageView alloc] initWithImage:circle];
    circleView.frame = CGRectMake(1, 1, 27, 27);
    circleView.tag = 1;
    [self addSubview:circleView];
    
    //Add the animation to the circleView - once you add the animation to the layer, the animation starts
    [circleView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];
    
}

-(void)DrawSecondToHome:(int)x :(int)y {
    
    //Prepare the animation - we use keyframe animation for animations of this complexity
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //Set some variables on the animation
    pathAnimation.calculationMode = kCAAnimationPaced;
    //We want the animation to persist - not so important in this case - but kept for clarity
    //If we animated something from left to right - and we wanted it to stay in the new position,
    //then we would need these parameters
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.duration = 2.0;
    //Lets loop continuously for the demonstration
    //pathAnimation.repeatCount = 1000;
    
    //Setup the path for the animation - this is very similar as the code the draw the line
    //instead of drawing to the graphics context, instead we draw lines on a CGPathRef
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, x, y-228);
    
    CGPathAddLineToPoint(curvedPath, NULL, x-100, y-124);
    CGPathAddLineToPoint(curvedPath, NULL, x, y-20);
    //Now we have the path, we tell the animation we want to use this path - then we release the path
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    //We will now draw a circle at the start of the path which we will animate to follow the path
    //We use the same technique as before to draw to a bitmap context and then eventually create
    //a UIImageView which we add to our view
    UIGraphicsBeginImageContext(CGSizeMake(25,25));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //Set context variables
    CGContextSetLineWidth(ctx, 1.5);
    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    //Draw a circle - and paint it with a different outline (white) and fill color (green)
    CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, 22, 22));
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *circleView = [[UIImageView alloc] initWithImage:circle];
    circleView.frame = CGRectMake(1, 1, 27, 27);
    circleView.tag = 1;
    [self addSubview:circleView];
    
    //Add the animation to the circleView - once you add the animation to the layer, the animation starts
    [UIView animateWithDuration:2.0f animations:^
     {
         circleView.alpha=2.0f;
         [circleView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];
     }
                     completion:^(BOOL finished)
     {
         [circleView removeFromSuperview];
     }];
    
}

-(void)DrawSecondToThird:(int)x :(int)y {
    
    //Prepare the animation - we use keyframe animation for animations of this complexity
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //Set some variables on the animation
    pathAnimation.calculationMode = kCAAnimationPaced;
    //We want the animation to persist - not so important in this case - but kept for clarity
    //If we animated something from left to right - and we wanted it to stay in the new position,
    //then we would need these parameters
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 1.0;
    //Lets loop continuously for the demonstration
    //pathAnimation.repeatCount = 1000;
    
    //Setup the path for the animation - this is very similar as the code the draw the line
    //instead of drawing to the graphics context, instead we draw lines on a CGPathRef
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, x, y-228);
    
    CGPathAddLineToPoint(curvedPath, NULL, x-100, y-124);
    //CGPathAddLineToPoint(curvedPath, NULL, x, y-20);
    //Now we have the path, we tell the animation we want to use this path - then we release the path
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    //We will now draw a circle at the start of the path which we will animate to follow the path
    //We use the same technique as before to draw to a bitmap context and then eventually create
    //a UIImageView which we add to our view
    UIGraphicsBeginImageContext(CGSizeMake(25,25));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //Set context variables
    CGContextSetLineWidth(ctx, 1.5);
    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    //Draw a circle - and paint it with a different outline (white) and fill color (green)
    CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, 22, 22));
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *circleView = [[UIImageView alloc] initWithImage:circle];
    circleView.frame = CGRectMake(1, 1, 27, 27);
    circleView.tag = 1;
    [self addSubview:circleView];
    
    //Add the animation to the circleView - once you add the animation to the layer, the animation starts
    [circleView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];
    
}

-(void)DrawThirdToHome:(int)x :(int)y {
    
    //Prepare the animation - we use keyframe animation for animations of this complexity
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //Set some variables on the animation
    pathAnimation.calculationMode = kCAAnimationPaced;
    //We want the animation to persist - not so important in this case - but kept for clarity
    //If we animated something from left to right - and we wanted it to stay in the new position,
    //then we would need these parameters
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.duration = 1.0;
    //Lets loop continuously for the demonstration
    //pathAnimation.repeatCount = 1000;
    
    //Setup the path for the animation - this is very similar as the code the draw the line
    //instead of drawing to the graphics context, instead we draw lines on a CGPathRef
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, x-100, y-124);
    
    CGPathAddLineToPoint(curvedPath, NULL, x, y-20);
    //Now we have the path, we tell the animation we want to use this path - then we release the path
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    //We will now draw a circle at the start of the path which we will animate to follow the path
    //We use the same technique as before to draw to a bitmap context and then eventually create
    //a UIImageView which we add to our view
    UIGraphicsBeginImageContext(CGSizeMake(25,25));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //Set context variables
    CGContextSetLineWidth(ctx, 1.5);
    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    //Draw a circle - and paint it with a different outline (white) and fill color (green)
    CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, 22, 22));
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *circleView = [[UIImageView alloc] initWithImage:circle];
    circleView.frame = CGRectMake(1, 1, 27, 27);
    circleView.tag = 1;
    [self addSubview:circleView];
    
    //Add the animation to the circleView - once you add the animation to the layer, the animation starts
    [UIView animateWithDuration:1.0f animations:^
     {
         circleView.alpha=2.0f;
         [circleView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];
     }
                     completion:^(BOOL finished)
     {
         [circleView removeFromSuperview];
     }];
    
}

-(void)DrawStayOnFirst:(int)x :(int)y {
    //Prepare the animation - we use keyframe animation for animations of this complexity
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //Set some variables on the animation
    pathAnimation.calculationMode = kCAAnimationPaced;
    //We want the animation to persist - not so important in this case - but kept for clarity
    //If we animated something from left to right - and we wanted it to stay in the new position,
    //then we would need these parameters
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = .1;
    //Lets loop continuously for the demonstration
    //pathAnimation.repeatCount = 1000;
    
    //Setup the path for the animation - this is very similar as the code the draw the line
    //instead of drawing to the graphics context, instead we draw lines on a CGPathRef
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, x+100, y-123);
    
    CGPathAddLineToPoint(curvedPath, NULL, x+100, y-124);
    //CGPathAddLineToPoint(curvedPath, NULL, x-100, y-124);
    //CGPathAddLineToPoint(curvedPath, NULL, x, y-20);
    //Now we have the path, we tell the animation we want to use this path - then we release the path
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    //We will now draw a circle at the start of the path which we will animate to follow the path
    //We use the same technique as before to draw to a bitmap context and then eventually create
    //a UIImageView which we add to our view
    UIGraphicsBeginImageContext(CGSizeMake(25,25));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //Set context variables
    CGContextSetLineWidth(ctx, 1.5);
    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    //Draw a circle - and paint it with a different outline (white) and fill color (green)
    CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, 22, 22));
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *circleView = [[UIImageView alloc] initWithImage:circle];
    circleView.frame = CGRectMake(1, 1, 27, 27);
    circleView.tag = 1;
    [self addSubview:circleView];
    
    //Add the animation to the circleView - once you add the animation to the layer, the animation starts
    [circleView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];
}

-(void)DrawStayOnSecond:(int)x :(int)y {
    //Prepare the animation - we use keyframe animation for animations of this complexity
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //Set some variables on the animation
    pathAnimation.calculationMode = kCAAnimationPaced;
    //We want the animation to persist - not so important in this case - but kept for clarity
    //If we animated something from left to right - and we wanted it to stay in the new position,
    //then we would need these parameters
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = .1;
    //Lets loop continuously for the demonstration
    //pathAnimation.repeatCount = 1000;
    
    //Setup the path for the animation - this is very similar as the code the draw the line
    //instead of drawing to the graphics context, instead we draw lines on a CGPathRef
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, x, y-227);
    
    CGPathAddLineToPoint(curvedPath, NULL, x, y-228);
    //CGPathAddLineToPoint(curvedPath, NULL, x-100, y-124);
    //CGPathAddLineToPoint(curvedPath, NULL, x, y-20);
    //Now we have the path, we tell the animation we want to use this path - then we release the path
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    //We will now draw a circle at the start of the path which we will animate to follow the path
    //We use the same technique as before to draw to a bitmap context and then eventually create
    //a UIImageView which we add to our view
    UIGraphicsBeginImageContext(CGSizeMake(25,25));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //Set context variables
    CGContextSetLineWidth(ctx, 1.5);
    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    //Draw a circle - and paint it with a different outline (white) and fill color (green)
    CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, 22, 22));
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *circleView = [[UIImageView alloc] initWithImage:circle];
    circleView.frame = CGRectMake(1, 1, 27, 27);
    circleView.tag = 1;
    [self addSubview:circleView];
    
    //Add the animation to the circleView - once you add the animation to the layer, the animation starts
    [circleView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];
}

-(void)DrawStayOnThird:(int)x :(int)y {
    //Prepare the animation - we use keyframe animation for animations of this complexity
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //Set some variables on the animation
    pathAnimation.calculationMode = kCAAnimationPaced;
    //We want the animation to persist - not so important in this case - but kept for clarity
    //If we animated something from left to right - and we wanted it to stay in the new position,
    //then we would need these parameters
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = .1;
    //Lets loop continuously for the demonstration
    //pathAnimation.repeatCount = 1000;
    
    //Setup the path for the animation - this is very similar as the code the draw the line
    //instead of drawing to the graphics context, instead we draw lines on a CGPathRef
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, x-100, y-123);
    
    CGPathAddLineToPoint(curvedPath, NULL, x-100, y-124);
    //CGPathAddLineToPoint(curvedPath, NULL, x-100, y-124);
    //CGPathAddLineToPoint(curvedPath, NULL, x, y-20);
    //Now we have the path, we tell the animation we want to use this path - then we release the path
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    //We will now draw a circle at the start of the path which we will animate to follow the path
    //We use the same technique as before to draw to a bitmap context and then eventually create
    //a UIImageView which we add to our view
    UIGraphicsBeginImageContext(CGSizeMake(25,25));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //Set context variables
    CGContextSetLineWidth(ctx, 1.5);
    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    //Draw a circle - and paint it with a different outline (white) and fill color (green)
    CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, 22, 22));
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *circleView = [[UIImageView alloc] initWithImage:circle];
    circleView.frame = CGRectMake(1, 1, 27, 27);
    circleView.tag = 1;
    [self addSubview:circleView];
    
    //Add the animation to the circleView - once you add the animation to the layer, the animation starts
    [circleView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];
}

- (IBAction)Pitch:(id)sender {
    
    GameDataController* s = [GameDataController sharedInstance];
    
    if(s.HomeLineupSubmitted == false && s.AwayLineupSubmitted == false)
    {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"Home and Away lineups must be submitted before game can start."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert show];
    }
    else
    {
    [self SetUndos];
    [self ShowPitchCountMenu];
    }
}

- (IBAction)UndoButton:(id)sender {
    
    GameDataController* s = [GameDataController sharedInstance];
    //***********************redo*******************************
    s.redoballs = s.balls;
    s.redostrikes = s.strikes;
    s.redoouts = s.outs;
    s.redosideInning = s.sideInning;
    s.redonumInning = s.numInning;
    s.redoisBottomInning = s.isBottomInning;
    s.redoHomeScore = s.HomeScore;
    s.redoAwayScore = s.AwayScore;
    s.redoHomeTeamLineupIndex = s.HomeTeamLineupIndex;
    s.redoAwayTeamLineupIndex = s.AwayTeamLineupIndex;
    s.redoatbat.base = s.atbat.base;
    s.redofirstbase.base = s.firstbase.base;
    s.redosecondbase.base = s.secondbase.base;
    s.redothirdbase.base = s.thirdbase.base;
    //**********************************************************
    
    s.balls = s.undoballs;
    s.strikes = s.undostrikes;
    s.outs = s.undoouts;
    s.sideInning = s.undosideInning;
    s.numInning = s.undonumInning;
    s.isBottomInning = s.undoisBottomInning;
    s.HomeScore = s.undoHomeScore;
    s.AwayScore = s.undoAwayScore;
    s.HomeTeamLineupIndex = s.undoHomeTeamLineupIndex;
    s.AwayTeamLineupIndex = s.undoAwayTeamLineupIndex;
    
    s.atbat.base = s.undoatbat.base;
    s.firstbase.base = s.undofirstbase.base;
    s.secondbase.base = s.undosecondbase.base;
    s.thirdbase.base = s.undothirdbase.base;
    /*
    [s.AwayTeam replaceObjectAtIndex:0 withObject:[s.undoAwayTeam objectAtIndex:0]];
    [s.AwayTeam replaceObjectAtIndex:1 withObject:[s.undoAwayTeam objectAtIndex:1]];
    [s.AwayTeam replaceObjectAtIndex:2 withObject:[s.undoAwayTeam objectAtIndex:2]];
    [s.AwayTeam replaceObjectAtIndex:3 withObject:[s.undoAwayTeam objectAtIndex:3]];
    [s.AwayTeam replaceObjectAtIndex:4 withObject:[s.undoAwayTeam objectAtIndex:4]];
    [s.AwayTeam replaceObjectAtIndex:5 withObject:[s.undoAwayTeam objectAtIndex:5]];
    [s.AwayTeam replaceObjectAtIndex:6 withObject:[s.undoAwayTeam objectAtIndex:6]];
    [s.AwayTeam replaceObjectAtIndex:7 withObject:[s.undoAwayTeam objectAtIndex:7]];
    [s.AwayTeam replaceObjectAtIndex:8 withObject:[s.undoAwayTeam objectAtIndex:8]];
    
    [s.HomeTeam replaceObjectAtIndex:0 withObject:[s.undoHomeTeam objectAtIndex:0]];
    [s.HomeTeam replaceObjectAtIndex:1 withObject:[s.undoHomeTeam objectAtIndex:1]];
    [s.HomeTeam replaceObjectAtIndex:2 withObject:[s.undoHomeTeam objectAtIndex:2]];
    [s.HomeTeam replaceObjectAtIndex:3 withObject:[s.undoHomeTeam objectAtIndex:3]];
    [s.HomeTeam replaceObjectAtIndex:4 withObject:[s.undoHomeTeam objectAtIndex:4]];
    [s.HomeTeam replaceObjectAtIndex:5 withObject:[s.undoHomeTeam objectAtIndex:5]];
    [s.HomeTeam replaceObjectAtIndex:6 withObject:[s.undoHomeTeam objectAtIndex:6]];
    [s.HomeTeam replaceObjectAtIndex:7 withObject:[s.undoHomeTeam objectAtIndex:7]];
    [s.HomeTeam replaceObjectAtIndex:8 withObject:[s.undoHomeTeam objectAtIndex:8]];
    */

    if(s.firstbase.base != NULL)
        s.firstbase.runnerAdvance = 5;
    if(s.secondbase.base != NULL)
        s.secondbase.runnerAdvance = 5;
    if(s.thirdbase.base != NULL)
        s.thirdbase.runnerAdvance = 5;
    /*
    RedoButtonLabel.hidden = false;
    UndoButtonLabel.hidden = true;
    */
    UndoButtonLabel.enabled = false;
    RedoButtonLabel.enabled = true;
    
    [self UpdateLabels];
    [self Log];
    [self setNeedsDisplay];
}

-(void)SetUndos {
    
    GameDataController* s = [GameDataController sharedInstance];
    
    s.undoballs = s.balls;
    s.undostrikes = s.strikes;
    s.undoouts = s.outs;
    s.undosideInning = s.sideInning;
    s.undonumInning = s.numInning;
    s.undoisBottomInning = s.isBottomInning;
    s.undoHomeScore = s.HomeScore;
    s.undoAwayScore = s.AwayScore;
    s.undoHomeTeamLineupIndex = s.HomeTeamLineupIndex;
    s.undoAwayTeamLineupIndex = s.AwayTeamLineupIndex;
    
    s.undoatbat.base = s.atbat.base;
    s.undofirstbase.base = s.firstbase.base;
    s.undosecondbase.base = s.secondbase.base;
    s.undothirdbase.base = s.thirdbase.base;
    /*
    [s.undoAwayTeam replaceObjectAtIndex:0 withObject:[s.AwayTeam objectAtIndex:0]];
    [s.undoAwayTeam replaceObjectAtIndex:1 withObject:[s.AwayTeam objectAtIndex:1]];
    [s.undoAwayTeam replaceObjectAtIndex:2 withObject:[s.AwayTeam objectAtIndex:2]];
    [s.undoAwayTeam replaceObjectAtIndex:3 withObject:[s.AwayTeam objectAtIndex:3]];
    [s.undoAwayTeam replaceObjectAtIndex:4 withObject:[s.AwayTeam objectAtIndex:4]];
    [s.undoAwayTeam replaceObjectAtIndex:5 withObject:[s.AwayTeam objectAtIndex:5]];
    [s.undoAwayTeam replaceObjectAtIndex:6 withObject:[s.AwayTeam objectAtIndex:6]];
    [s.undoAwayTeam replaceObjectAtIndex:7 withObject:[s.AwayTeam objectAtIndex:7]];
    [s.undoAwayTeam replaceObjectAtIndex:8 withObject:[s.AwayTeam objectAtIndex:8]];
    
    [s.undoHomeTeam replaceObjectAtIndex:0 withObject:[s.HomeTeam objectAtIndex:0]];
    [s.undoHomeTeam replaceObjectAtIndex:1 withObject:[s.HomeTeam objectAtIndex:1]];
    [s.undoHomeTeam replaceObjectAtIndex:2 withObject:[s.HomeTeam objectAtIndex:2]];
    [s.undoHomeTeam replaceObjectAtIndex:3 withObject:[s.HomeTeam objectAtIndex:3]];
    [s.undoHomeTeam replaceObjectAtIndex:4 withObject:[s.HomeTeam objectAtIndex:4]];
    [s.undoHomeTeam replaceObjectAtIndex:5 withObject:[s.HomeTeam objectAtIndex:5]];
    [s.undoHomeTeam replaceObjectAtIndex:6 withObject:[s.HomeTeam objectAtIndex:6]];
    [s.undoHomeTeam replaceObjectAtIndex:7 withObject:[s.HomeTeam objectAtIndex:7]];
    [s.undoHomeTeam replaceObjectAtIndex:8 withObject:[s.HomeTeam objectAtIndex:8]];
     */
}

- (IBAction)RedoButton:(id)sender {
    
    GameDataController* s = [GameDataController sharedInstance];
    
    s.balls = s.redoballs;
    s.strikes = s.redostrikes;
    s.outs = s.redoouts;
    s.sideInning = s.redosideInning;
    s.numInning = s.redonumInning;
    s.isBottomInning = s.redoisBottomInning;
    s.HomeScore = s.redoHomeScore;
    s.AwayScore = s.redoAwayScore;
    s.HomeTeamLineupIndex = s.redoHomeTeamLineupIndex;
    s.AwayTeamLineupIndex = s.redoAwayTeamLineupIndex;
    
    s.atbat.base = s.redoatbat.base;
    s.firstbase.base = s.redofirstbase.base;
    s.secondbase.base = s.redosecondbase.base;
    s.thirdbase.base = s.redothirdbase.base;
    
    if(s.firstbase.base != NULL)
        s.firstbase.runnerAdvance = 5;
    if(s.secondbase.base != NULL)
        s.secondbase.runnerAdvance = 5;
    if(s.thirdbase.base != NULL)
        s.thirdbase.runnerAdvance = 5;
    /*
    UndoButtonLabel.hidden = false;
    RedoButtonLabel.hidden = true;
    */
    UndoButtonLabel.enabled = true;
    RedoButtonLabel.enabled = false;
    
    [self UpdateLabels];
    [self Log];
    [self setNeedsDisplay];
}

-(void)Log {
    GameDataController* s = [GameDataController sharedInstance];
    
    NSLog(@"B:%d, S:%d, O:%d, Hscore:%d, Ascore:%d, NumInning:%d, SideInning:%@, IsBottomInning:%d, Hindex:%d, Aindex:%d", s.balls, s.strikes, s.outs, s.HomeScore, s.AwayScore, s.numInning, s.sideInning, s.isBottomInning, s.HomeTeamLineupIndex, s.AwayTeamLineupIndex);
    
    
    NSLog(@"AtBat: B:%d, S:%d, O:%d, %@ %@ %@ %d/%d, %d run(s), %d RBI(s), %d SB, %.3f", s.balls, s.strikes, s.outs, s.atbat.base.FirstName, s.atbat.base.LastName, s.atbat.base.Position, s.atbat.base.Hits, s.atbat.base.PlateAppearances, s.atbat.base.RunsScored, s.atbat.base.RBI, s.atbat.base.StolenBases, s.atbat.base.BattingAverage);
    NSLog(@"FirstBase: %@ %@ %@ %d/%d %d run(s), %d RBI(s), %d SB, %.3f", s.firstbase.base.FirstName, s.firstbase.base.LastName, s.firstbase.base.Position, s.firstbase.base.Hits, s.firstbase.base.PlateAppearances, s.firstbase.base.RunsScored, s.firstbase.base.RBI, s.firstbase.base.StolenBases, s.firstbase.base.BattingAverage);
    NSLog(@"SecondBase: %@ %@ %@ %d/%d %d run(s), %d RBI(s), %d SB, %.3f", s.secondbase.base.FirstName, s.secondbase.base.LastName, s.secondbase.base.Position, s.secondbase.base.Hits, s.secondbase.base.PlateAppearances, s.secondbase.base.RunsScored, s.secondbase.base.RBI, s.secondbase.base.StolenBases, s.secondbase.base.BattingAverage);
    NSLog(@"ThirdBase: %@ %@ %@ %d/%d %d run(s), %d RBI(s), %d SB, %.3f", s.thirdbase.base.FirstName, s.thirdbase.base.LastName, s.thirdbase.base.Position, s.thirdbase.base.Hits, s.thirdbase.base.PlateAppearances, s.thirdbase.base.RunsScored, s.thirdbase.base.RBI, s.thirdbase.base.StolenBases, s.thirdbase.base.BattingAverage);
}

-(void)UpdateLabels {
    GameDataController* s = [GameDataController sharedInstance];
    
    HomeScoreLabel.adjustsFontSizeToFitWidth = YES;
    HomeScoreLabel.adjustsLetterSpacingToFitWidth = YES;
    AwayScoreLabel.adjustsLetterSpacingToFitWidth = YES;
    AwayScoreLabel.adjustsFontSizeToFitWidth = YES;
    PitchCountLabel.adjustsFontSizeToFitWidth = YES;
    PitchCountLabel.adjustsLetterSpacingToFitWidth = YES;
    InningLabel.adjustsLetterSpacingToFitWidth = YES;
    InningLabel.adjustsFontSizeToFitWidth = YES;
    
    PitchCountLabel.text = [NSString stringWithFormat:@"Balls: %@ Strikes: %@ Outs: %@", Convert(s.balls), Convert(s.strikes), Convert(s.outs)];
    HomeScoreLabel.text = [NSString stringWithFormat:@"%@: %@",s.HomeTeamName, Convert(s.HomeScore)];
    AwayScoreLabel.text = [NSString stringWithFormat:@"%@: %@",s.AwayTeamName, Convert(s.AwayScore)];
    InningLabel.text = [NSString stringWithFormat:@"%@ %@ ", s.sideInning, Convert(s.numInning)];
}

NSString *Convert(int p)
{
    NSString *greeting = [[NSString alloc] initWithFormat:@"%d", p];
    return greeting;
}

-(void)DrawField:(int)x :(int)y {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2.0);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    CGContextMoveToPoint(context, x,y);
    CGContextAddLineToPoint(context, x-145,y-150);
    CGContextAddLineToPoint(context, x-145,y-300);
    CGContextAddLineToPoint(context, x+145,y-300);
    CGContextAddLineToPoint(context, x+145,y-150);
    CGContextClosePath(context);
    CGContextSetRGBFillColor (context, 0, .5, 0, 1);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
    CGContextMoveToPoint(context, x,y);
    CGContextAddLineToPoint(context, x-120,y-124);
    CGContextAddLineToPoint(context, x, y-248);
    CGContextAddLineToPoint(context, x+120, y-124);
    CGContextSetRGBFillColor (context, .66, .44, 0, 1);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
    CGContextMoveToPoint(context, x,y);
    CGContextAddLineToPoint(context, x-20,y-20);
    CGContextAddLineToPoint(context, x, y-40);
    CGContextAddLineToPoint(context, x+20,y-20);
    CGContextClosePath(context);
    CGContextSetRGBFillColor (context, 1, 1, 1, 1);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
    CGContextMoveToPoint(context, x-100,y-104);
    CGContextAddLineToPoint(context, x-120,y-124);
    CGContextAddLineToPoint(context, x-100,y-144);
    CGContextAddLineToPoint(context, x-80,y-124);
    CGContextClosePath(context);
    CGContextSetRGBFillColor (context, 1, 1, 1, 1);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
    CGContextMoveToPoint(context, x, y-208);
    CGContextAddLineToPoint(context, x-20,y-228);
    CGContextAddLineToPoint(context, x,y-248);
    CGContextAddLineToPoint(context, x+20,y-228);
    CGContextClosePath(context);
    CGContextSetRGBFillColor (context, 1, 1, 1, 1);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
    CGContextMoveToPoint(context, x+100,y-104);
    CGContextAddLineToPoint(context, x+80,y-124);
    CGContextAddLineToPoint(context, x+100,y-144);
    CGContextAddLineToPoint(context, x+120,y-124);
    CGContextClosePath(context);
    CGContextSetRGBFillColor (context, 1, 1, 1, 1);
    CGContextDrawPath(context, kCGPathEOFillStroke);
}

-(void)GameEnded {
    
    GameDataController* s = [GameDataController sharedInstance];
    Player *a = [[Player alloc] init];
    
    [s.FinalGameArray addObject:AwayScoreLabel.text];
    [s.FinalGameArray addObject:HomeScoreLabel.text];
    
    for(int i=0;i<9;i++) {
        a = [s.AwayTeam objectAtIndex:i];
        
        [s.FinalGameArray addObject:[NSString stringWithFormat: @"%@", a.FirstName]];
        [s.FinalGameArray addObject:[NSString stringWithFormat: @"%@", a.LastName]];
        [s.FinalGameArray addObject:[NSString stringWithFormat: @"%@", a.Position]];
        NSString *temp = [NSString stringWithFormat: @"%d/%d", a.Hits, a.PlateAppearances];
        [s.FinalGameArray addObject:temp];
        [s.FinalGameArray addObject:[NSString stringWithFormat: @"%d", a.RunsScored]];
        [s.FinalGameArray addObject:[NSString stringWithFormat: @"%d", a.HR]];
        [s.FinalGameArray addObject:[NSString stringWithFormat: @"%d", a.RBI]];
        [s.FinalGameArray addObject:[NSString stringWithFormat: @"%d", a.StolenBases]];
        temp = [NSString stringWithFormat: @"%.3f", a.BattingAverage];
        [s.FinalGameArray addObject:temp];
    }
    for(int i=0;i<9;i++) {
        a = [s.HomeTeam objectAtIndex:i];
        [s.FinalGameArray addObject:[NSString stringWithFormat: @"%@", a.FirstName]];
        [s.FinalGameArray addObject:[NSString stringWithFormat: @"%@", a.LastName]];
        [s.FinalGameArray addObject:[NSString stringWithFormat: @"%@", a.Position]];
        NSString *temp = [NSString stringWithFormat: @"%d/%d", a.Hits, a.PlateAppearances];
        [s.FinalGameArray addObject:temp];
        [s.FinalGameArray addObject:[NSString stringWithFormat: @"%d", a.RunsScored]];
        [s.FinalGameArray addObject:[NSString stringWithFormat: @"%d", a.HR]];
        [s.FinalGameArray addObject:[NSString stringWithFormat: @"%d", a.RBI]];
        [s.FinalGameArray addObject:[NSString stringWithFormat: @"%d", a.StolenBases]];
        temp = [NSString stringWithFormat: @"%.3f", a.BattingAverage];
        [s.FinalGameArray addObject:temp];
    }
    
    [s.BoxScoreList addObject:s.FinalGameArray];
    s.FinalGameArray = NULL;
    
    NSLog(@"%@", s.BoxScoreList);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                    message:@"The game is over and has been logged in your box scores.  Please return to home page."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert show];
    PitchButtonLabel.hidden = true;
}

@end
