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
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    int x = 160;
    int y = 375;
    [self DrawField:context :x :y];

}

-(void)DrawField:(CGContextRef)context :(int)x :(int)y {
    
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
