//
//  Quartz2D.m
//  BaseballScorecard
//
//  Created by JACOB WORKMAN on 2/18/13.
//  Copyright (c) 2013 JACOB WORKMAN. All rights reserved.
//

#import "Quartz2D.h"
#import <QuartzCore/QuartzCore.h>
#include <math.h>

static inline double radians (double degrees) {return degrees * M_PI/180;}

@implementation Quartz2D

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    int x = 160;
    int y = 375;
    [self DrawField:x :y];
    [self DrawBaseRunners:x :y];

}

-(void)DrawBaseRunners:(int)x :(int)y {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(context, CGRectMake(x-10, y-10, 20, -20));
    
    CGContextSetRGBFillColor (context, .8, .3, .7, 1);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
    //Prepare the animation - we use keyframe animation for animations of this complexity
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //Set some variables on the animation
    pathAnimation.calculationMode = kCAAnimationPaced;
    //We want the animation to persist - not so important in this case - but kept for clarity
    //If we animated something from left to right - and we wanted it to stay in the new position,
    //then we would need these parameters
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 4.0;
    //Lets loop continuously for the demonstration
    //pathAnimation.repeatCount = 1000;
    
    //Setup the path for the animation - this is very similar as the code the draw the line
    //instead of drawing to the graphics context, instead we draw lines on a CGPathRef
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, x, y);

    CGPathAddLineToPoint(curvedPath, NULL, x+120, y-124);
    CGPathAddLineToPoint(curvedPath, NULL, x, y-248);
    CGPathAddLineToPoint(curvedPath, NULL, x-120, y-124);
    CGPathAddLineToPoint(curvedPath, NULL, x, y);
    //Now we have the path, we tell the animation we want to use this path - then we release the path
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    //We will now draw a circle at the start of the path which we will animate to follow the path
    //We use the same technique as before to draw to a bitmap context and then eventually create
    //a UIImageView which we add to our view
    UIGraphicsBeginImageContext(CGSizeMake(20,20));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //Set context variables
    CGContextSetLineWidth(ctx, 1.5);
    CGContextSetFillColorWithColor(ctx, [UIColor greenColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    //Draw a circle - and paint it with a different outline (white) and fill color (green)
    CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, 18, 18));
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *circleView = [[UIImageView alloc] initWithImage:circle];
    circleView.frame = CGRectMake(1, 1, 20, 20);
    [self addSubview:circleView];
    
    //Add the animation to the circleView - once you add the animation to the layer, the animation starts
    [circleView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];
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



@end
