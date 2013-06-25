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
 
    
    CGPoint startingPoint = CGPointMake(0, 58);
    
    
    
    CGPoint topLeftCurvePoint = CGPointMake(0, 0);
    CGPoint topLeftCurveControlPoint = CGPointMake(-5, 29);
    
    
    CGPoint topCurvePoint = CGPointMake(182, 0);
    CGPoint topCurveFirstControlPoint = CGPointMake(30, -90);
    CGPoint topCurveSecondControlPoint = CGPointMake(152, -90);
    
    CGPoint topRightCurvePoint = CGPointMake(182, 58);
    CGPoint topRightCurveControlPoint = CGPointMake(187, 29);
    
    
    CGPoint midRightCurvePoint = CGPointMake(176, 118);
    CGPoint midRightCurveControlPoint = CGPointMake(194, 62);
    
    
    CGPoint lowerRightCurvePoint = CGPointMake(154, 178);
    CGPoint lowerRightControlPoint = CGPointMake(173, 148);
    
    
    
    CGPoint bottomQuadCurvePoint = CGPointMake(28, 178);
    CGPoint bottomQuardCurveControlPoint = CGPointMake(91, 260);
    
    
    
    
    
    CGPoint lowerLeftPoint = CGPointMake(6, 118);
    CGPoint lowerLeftControlPoint = CGPointMake(9, 148);
    
    
    
    CGPoint midLeftPoint = CGPointMake(0, 58);
    CGPoint midLeftControlPoint = CGPointMake(-12, 62);
    
    
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    
    
    [aPath moveToPoint:startingPoint];
    
    [aPath addQuadCurveToPoint:topLeftCurvePoint controlPoint:topLeftCurveControlPoint];
    
    [aPath addCurveToPoint:topCurvePoint controlPoint1:topCurveFirstControlPoint controlPoint2:topCurveSecondControlPoint];
    
    [aPath addQuadCurveToPoint:topRightCurvePoint controlPoint:topRightCurveControlPoint];
    [aPath addQuadCurveToPoint:midRightCurvePoint controlPoint:midRightCurveControlPoint];
    [aPath addQuadCurveToPoint:lowerRightCurvePoint controlPoint:lowerRightControlPoint];
    [aPath addQuadCurveToPoint:bottomQuadCurvePoint controlPoint:bottomQuardCurveControlPoint];
    [aPath addQuadCurveToPoint:lowerLeftPoint controlPoint:lowerLeftControlPoint];
    [aPath addQuadCurveToPoint:midLeftPoint controlPoint:midLeftControlPoint];
    
    
    
    [aPath closePath];
    
    
    
    
    
    [aPath applyTransform:CGAffineTransformMakeScale(0.8, 0.8)];
    
    
    float yOrigin = CGPathGetBoundingBox(aPath.CGPath).origin.y;
    float xOrigin = CGPathGetBoundingBox(aPath.CGPath).origin.x;
    
    [aPath applyTransform:CGAffineTransformMakeTranslation(-xOrigin, -yOrigin)];
    
    
    
    [aPath applyTransform:CGAffineTransformMakeTranslation(self.bounds.size.width/2.0 -CGPathGetBoundingBox(aPath.CGPath).size.width/2.0, self.bounds.size.height/2.0-CGPathGetBoundingBox(aPath.CGPath).size.height/2.0)];
    
    
    
    
    [aPath applyTransform:CGAffineTransformMakeTranslation(0, 30)];
    
    

    
        
    [aPath stroke];
    

    
    
    
}


@end
