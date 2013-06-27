//
//  OverlayView.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 2/24/13.
//
//

#import "OverlayView.h"
#import "UIBezierPath-Points.h"
#import <QuartzCore/QuartzCore.h>

@interface OverlayView ()

@property (retain) UIColor *fillColor;
@property (retain) UIBezierPath *punchedOutPath;

@end

@implementation OverlayView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = NO;
        
        
        NSLog(@"OverlayView Frame: %@",NSStringFromCGRect(self.frame));
        NSLog(@"OverlayView Bounds:%@",NSStringFromCGRect(self.bounds));
        
        
        
        CAShapeLayer *backgroundLayer = [self createTransparentBackground];
        [self.layer addSublayer:backgroundLayer];

        CAShapeLayer *faceLayer = [self createFaceOutline];
        [self.layer addSublayer:faceLayer];
        
        CAShapeLayer *topLine = [self createTopVerticalLine];
        [self.layer addSublayer:topLine];
        
        CAShapeLayer *bottomLine = [self createBottomVerticalLine];
        [self.layer addSublayer:bottomLine];
        
        CAShapeLayer *leftLine = [self createMidLeftLine];
        [self.layer addSublayer:leftLine];
        
        CAShapeLayer *rightLine = [self createMidRightLine];
        [self.layer addSublayer:rightLine];
        
    }
    return self;
}



-(CAShapeLayer *)createTopVerticalLine {
    
    UIBezierPath *facePath = [self drawFacePath];
    
    CGRect boundingBoxPath = CGPathGetPathBoundingBox(facePath.CGPath);
    CGPoint topPoint = CGPointMake(CGRectGetMidX(boundingBoxPath), CGRectGetMinY(boundingBoxPath)-2);

    UIBezierPath *line = [UIBezierPath bezierPath];
    [line moveToPoint:CGPointMake(160, 44)];
    [line addLineToPoint:topPoint];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = line.CGPath;
    shapeLayer.strokeColor = [UIColor colorWithWhite:1.000 alpha:0.800].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.shadowColor = [UIColor blackColor].CGColor;
    shapeLayer.shadowOpacity = 1.0;
    shapeLayer.shadowOffset = CGSizeMake(0, 0);
    shapeLayer.shadowRadius = 3.0;
    shapeLayer.lineWidth = 4.0;
    
    return shapeLayer;
    
    
}

-(CAShapeLayer *)createBottomVerticalLine {
    
    UIBezierPath *facePath = [self drawFacePath];
    
    CGRect boundingBoxPath = CGPathGetPathBoundingBox(facePath.CGPath);
    CGPoint bottomPoint = CGPointMake(CGRectGetMidX(boundingBoxPath), CGRectGetMaxY(boundingBoxPath)+2);
    
    UIBezierPath *line = [UIBezierPath bezierPath];
    [line moveToPoint:bottomPoint];
    [line addLineToPoint:CGPointMake(bottomPoint.x, bottomPoint.y + 70)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = line.CGPath;
    shapeLayer.strokeColor = [UIColor colorWithWhite:1.000 alpha:0.800].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.shadowColor = [UIColor blackColor].CGColor;
    shapeLayer.shadowOpacity = 1.0;
    shapeLayer.shadowOffset = CGSizeMake(0, 0);
    shapeLayer.shadowRadius = 3.0;
    shapeLayer.lineWidth = 4.0;
    
    return shapeLayer;
    
    
}


-(CAShapeLayer *)createMidLeftLine {
    
    UIBezierPath *facePath = [self drawFacePath];
    
    CGRect boundingBoxPath = CGPathGetPathBoundingBox(facePath.CGPath);
    CGPoint leftPoint = CGPointMake(CGRectGetMinX(boundingBoxPath)-2, CGRectGetMidY(boundingBoxPath));
    
    UIBezierPath *line = [UIBezierPath bezierPath];
    [line moveToPoint:leftPoint];
    
    
    [line addLineToPoint:CGPointMake(leftPoint.x - 66, leftPoint.y)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = line.CGPath;
    shapeLayer.strokeColor = [UIColor colorWithWhite:1.000 alpha:0.800].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.shadowColor = [UIColor blackColor].CGColor;
    shapeLayer.shadowOpacity = 1.0;
    shapeLayer.shadowOffset = CGSizeMake(0, 0);
    shapeLayer.shadowRadius = 3.0;
    shapeLayer.lineWidth = 4.0;
    
    return shapeLayer;
    
    
}

-(CAShapeLayer *)createMidRightLine {
    
    UIBezierPath *facePath = [self drawFacePath];
    
    CGRect boundingBoxPath = CGPathGetPathBoundingBox(facePath.CGPath);
   CGPoint rightPoint = CGPointMake(CGRectGetMaxX(boundingBoxPath)+2, CGRectGetMidY(boundingBoxPath));
    
    UIBezierPath *line = [UIBezierPath bezierPath];
    [line moveToPoint:rightPoint];
    
    
    [line addLineToPoint:CGPointMake(rightPoint.x + 66, rightPoint.y)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = line.CGPath;
    shapeLayer.strokeColor = [UIColor colorWithWhite:1.000 alpha:0.800].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.shadowColor = [UIColor blackColor].CGColor;
    shapeLayer.shadowOpacity = 1.0;
    shapeLayer.shadowOffset = CGSizeMake(0, 0);
    shapeLayer.shadowRadius = 3.0;
    shapeLayer.lineWidth = 4.0;
    
    return shapeLayer;
    
    
}


-(CAShapeLayer *)createTransparentBackground {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) cornerRadius:0];
    
    UIBezierPath *circlePath = [self drawFacePath];
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor colorWithWhite:0.000 alpha:0.750].CGColor;
    fillLayer.opacity = 0.5;
    
    return fillLayer;
    
}


-(CAShapeLayer *)createFaceOutline {
    
    
    UIBezierPath *facePath = [self drawFacePath];
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = facePath.CGPath;
    shapeLayer.strokeColor = [UIColor colorWithWhite:1.000 alpha:0.800].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.shadowColor = [UIColor blackColor].CGColor;
    shapeLayer.shadowOpacity = 1.0;
    shapeLayer.shadowOffset = CGSizeMake(0, 0);
    shapeLayer.shadowRadius = 3.0;
    shapeLayer.lineWidth = 4.0;
    
    return shapeLayer;
    
    
}


-(UIBezierPath *)drawFacePath {
    
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
    
    
    
    
    
    [aPath applyTransform:CGAffineTransformMakeScale(0.9, 0.9)];
    
    
    float yOrigin = CGPathGetBoundingBox(aPath.CGPath).origin.y;
    float xOrigin = CGPathGetBoundingBox(aPath.CGPath).origin.x;
    
    [aPath applyTransform:CGAffineTransformMakeTranslation(-xOrigin, -yOrigin)];
    
    
    
    [aPath applyTransform:CGAffineTransformMakeTranslation(self.bounds.size.width/2.0 -CGPathGetBoundingBox(aPath.CGPath).size.width/2.0, self.bounds.size.height/2.0-CGPathGetBoundingBox(aPath.CGPath).size.height/2.0)];
    
    
    
    
    [aPath applyTransform:CGAffineTransformMakeTranslation(0, 30)];
    
    
    
    
    
    return aPath;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


//
//- (void)drawRect:(CGRect)rect
//{
////    self.fillColor = [UIColor blackColor];
//////    [[self fillColor] set];
////    
////    UIRectFill(rect);
////    
////    CGContextRef ctx = UIGraphicsGetCurrentContext();
////    CGContextSetBlendMode(ctx, kCGBlendModeDestinationOut);
////    
////    self.punchedOutPath = [self drawFacePath];
////    
////    
////    [self.punchedOutPath stroke];
////    
////    
////    [[self punchedOutPath] fill];
////    
////    CGContextSetBlendMode(ctx, kCGBlendModeNormal);
////   
////    self.alpha = 0.5;
//    
//    UIBezierPath *facePath = [self drawFacePath];
//    UIBezierPath *outerPath = [facePath bezierPathByReversingPath];
//    [[UIColor orangeColor]setFill];
//    [facePath fill];
//    [facePath stroke];
//    
//}



@end
