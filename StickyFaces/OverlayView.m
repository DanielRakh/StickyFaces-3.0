//
//  OverlayView.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 2/24/13.
//
//

#import "OverlayView.h"
#import "UIBezierPath-Points.h"


@implementation OverlayView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = NO;
        
        
        NSLog(@"OverlayView Frame: %@",NSStringFromCGRect(self.frame));
        NSLog(@"OverlayView Bounds:%@",NSStringFromCGRect(self.bounds));
    }
    return self;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
 
    
    UIBezierPath *verticalLine = [UIBezierPath bezierPath];
    [verticalLine moveToPoint:CGPointMake(self.bounds.size.width/2.0, 0)];
    [verticalLine addLineToPoint:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height)];
    verticalLine.lineWidth = 2.0;
    [verticalLine stroke];
    
    UIBezierPath *horizontalLine = [UIBezierPath bezierPath];
    [horizontalLine moveToPoint:CGPointMake(0, self.bounds.size.height/2.0)];
    [horizontalLine addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height/2.0)];
    horizontalLine.lineWidth = 2.0;
    [horizontalLine stroke];
    
    
    UIBezierPath *square = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 50, 50)];
    [square stroke];

    
    CGPoint zeroPoint = CGPointMake(0, 0);
    
    CGPoint topCurvePoint = CGPointMake(182, 0);
    CGPoint topCurveFirstControlPoint = CGPointMake(30, -90);
    CGPoint topCurveSecondControlPoint = CGPointMake(154, -90);
    
    CGPoint topRightPoint = CGPointMake(180, 60);
    CGPoint topRightControlPoint = CGPointMake(185, 40);
    
    CGPoint midRightPoint = CGPointMake(176, 118);
    CGPoint midRightControlPoint = CGPointMake(194, 62);
    
    CGPoint lowerRightPoint = CGPointMake(154, 178);
    CGPoint lowerRightControlPoint = CGPointMake(173, 148);
    
    
    CGPoint bottomQuadCurvePoint = CGPointMake(28, 178);
    CGPoint bottomQuardCurveControlPoint = CGPointMake(91, 280);
    
    
    CGPoint lowerLeftPoint = CGPointMake(6, 118);
    CGPoint lowerLeftControlPoint = CGPointMake(9, 148);
    
    
    CGPoint midLeftPoint = CGPointMake(2, 60);
    CGPoint midLeftControlPoint = CGPointMake(-12, 62);
    
    CGPoint topLeftPoint = CGPointMake(0, 0);
    CGPoint topLeftControlPoint = CGPointMake(-3, 40);
    
    
    
    NSLog(@"Overlay TopCurvePoint is (%f,%f)",topCurvePoint.x,topCurvePoint.y);

    
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    
    [aPath moveToPoint:zeroPoint];
    [aPath addCurveToPoint:topCurvePoint controlPoint1:topCurveFirstControlPoint controlPoint2:topCurveSecondControlPoint];
    [aPath addQuadCurveToPoint:topRightPoint controlPoint:topRightControlPoint];
    [aPath addQuadCurveToPoint:midRightPoint controlPoint:midRightControlPoint];
    [aPath addQuadCurveToPoint:lowerRightPoint controlPoint:lowerRightControlPoint];
    [aPath addQuadCurveToPoint:bottomQuadCurvePoint controlPoint:bottomQuardCurveControlPoint];
    [aPath addQuadCurveToPoint:lowerLeftPoint controlPoint:lowerLeftControlPoint];
    [aPath addQuadCurveToPoint:midLeftPoint controlPoint:midLeftControlPoint];
    [aPath addQuadCurveToPoint:topLeftPoint controlPoint:topLeftControlPoint];
    
    [aPath closePath];
    
    [aPath applyTransform:CGAffineTransformMakeScale(0.9, 0.9)];


    
    float yOrigin = CGPathGetBoundingBox(aPath.CGPath).origin.y;
    float xOrigin = CGPathGetBoundingBox(aPath.CGPath).origin.x;
    
    [aPath applyTransform:CGAffineTransformMakeTranslation(-xOrigin, -yOrigin)];
 
    
    [aPath applyTransform:CGAffineTransformMakeTranslation(self.bounds.size.width/2.0 -CGPathGetBoundingBox(aPath.CGPath).size.width/2.0, self.bounds.size.height/2.0-CGPathGetBoundingBox(aPath.CGPath).size.height/2.0)];
    
    [aPath applyTransform:CGAffineTransformMakeTranslation(0, 30)];
    
        
    [aPath stroke];
    
    NSArray *pointsArray = aPath.bezierElements;

    
    NSLog(@"Transformed Overlay TopCurvePoint is %@",                               [[pointsArray objectAtIndex:7]objectAtIndex:2]);

    
    
    CGRect pathBoundingBox = CGPathGetBoundingBox(aPath.CGPath);
    
        
    UIBezierPath *bezPath = [UIBezierPath bezierPathWithRect:pathBoundingBox];
    [[UIColor redColor]setStroke];
    bezPath.lineWidth = 3.0;
    [bezPath stroke];
    

    

    
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 56, 320,371)];
    
    [[UIColor blueColor]setStroke];
    rectPath.lineWidth = 2.0;
    [rectPath stroke];
    
    
    
    
}


@end
