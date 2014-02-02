//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Krystle on 2/1/14.
//  Copyright (c) 2014 Krystle Kidd. All rights reserved.
//

#import "HypnosisView.h"

@implementation HypnosisView

@synthesize circleColor;


-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        //All HypnosisViews start with a clear bakground color
        [self setBackgroundColor:[UIColor clearColor]];
        [self setCircleColor:[UIColor lightGrayColor]];
    }
    return self;
}


-(void)drawRect:(CGRect)dirtyRect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect bounds = [self bounds];
    
    //Figure out the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0 ;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    //The radius of the circle should be nearly as big as the view
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    //The thickness of the line should be 10 points wide
    CGContextSetLineWidth(ctx, 10);
    [[self circleColor] setStroke];
    
    //The color of the line should be grey (red/green/blue = 0.6, alpha = 1.0)
    [[UIColor lightGrayColor] setStroke];
    
    //Draw concentric circles from the outside in
    for(float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        //Add a path to the context
        CGContextAddArc(ctx, center.x, center.y, currentRadius, 0.0, M_PI, YES);
        
        //Preform drawing instruction; remoces path
        CGContextStrokePath(ctx);
    }
    //Create a string
    NSString *text = @"You are getting sleepy";
    //Get a font to draw it in
    UIFont *font = [UIFont boldSystemFontOfSize:28];
    
    CGRect textRect;
    
    //How big is this string when drawn in this font?
    textRect.size = [text sizeWithFont: font];
    
    //put that string in the center of the view
    textRect.origin.x = center.x - textRect.size.width/2.0;
    textRect.origin.y = center.y - textRect.size.height/2.0;
    
    //Set the fill color of the current context to black
    [[UIColor blackColor] setFill];
    
    //The shadow will move 4 points to the right and 3 points down from the text
    CGSize offset = CGSizeMake(4,3);
    
    //The shadow will be dark grey
    CGColorRef color = [[UIColor darkGrayColor] CGColor];
    
    //Set the shadow with these parameters all subsequent drawing will be shadowed
    CGContextSetShadowWithColor(ctx, offset, 2.0, color);
    
    //Draw the string
    [text drawInRect:textRect withFont: font];
}

-(BOOL) canBecomeFirstResponder
{
    return YES;
}

-(void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake){
        NSLog(@"Device started shaking!");
        [self setCircleColor:[UIColor redColor]];
    }
}

-(void) setCircleColor:(UIColor *)clr
{
    circleColor = clr;
    [self setNeedsDisplay];
}

@end
