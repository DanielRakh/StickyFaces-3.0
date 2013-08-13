//
//  Translation.m
//  TranslationTest
//
//  Created by Daniel Rakhamimov on 4/29/13.
//  Copyright (c) 2013 Daniel Rak. All rights reserved.
//

#import "PointsView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIBezierPath-Points.h"



@interface PointsView ()




@property (nonatomic, strong) FacePoint *facePoint;
@property (nonatomic, strong) FacePoint *touchPoint;
@property (nonatomic, strong) FacePoint *leftUpperFacePoint;
@property (nonatomic, strong) FacePoint *rightUpperFacePoint;



@property (nonatomic) CGPoint midPoint;
@property (nonatomic, strong) NSMutableArray *pointsArray;
@property (nonatomic, strong) NSMutableArray *viewArray;

@property (nonatomic) CGPoint topLeftControlPoint;
@property (nonatomic) CGPoint topRightControlPoint;
@property (nonatomic) CGPoint bottomControlPoint;


@property (nonatomic, strong) NSMutableArray *lineArray;
@property (nonatomic, strong) NSMutableArray *facePointArray;
@property (nonatomic, strong) CAShapeLayer *faceLayer;


@end


@implementation PointsView


#pragma mark
#pragma mark -  Initializer Methods

-(void)setUp {
    
    self.backgroundColor = [UIColor clearColor];
    
    
    
    
}


-(id)initWithNewImageView:(UIImageView *)imageView {
    
    self = [super initWithFrame:imageView.frame];
    if (self) {
        
        
        
        [self setUp];
        [self pointForObjectAtIndex];
        [self createPointView];
        
        
        
    }
    
    return self;
    
}

-(id)initWithImageView:(UIImageView *)imageView {
    
    self = [super initWithFrame:imageView.frame];
    if (self) {
        

        
        [self setUp];
        [self pointForObjectAtIndex];
        [self createPointView];
    
        
        
    }
    
    return self;
    
}

-(void)refreshView {
    
    [self setNeedsDisplay];
}




#pragma mark
#pragma mark - Face Point Methods





#pragma mark
#pragma mark -  Face Draw Methods

-(UIBezierPath *)createFacePath {
    
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
    
    
    
    
    
    [aPath applyTransform:CGAffineTransformMakeScale(0.85, 0.85)];
    
    
    float yOrigin = CGPathGetBoundingBox(aPath.CGPath).origin.y;
    float xOrigin = CGPathGetBoundingBox(aPath.CGPath).origin.x;
    
    [aPath applyTransform:CGAffineTransformMakeTranslation(-xOrigin, -yOrigin)];
    
    
    
    [aPath applyTransform:CGAffineTransformMakeTranslation(self.bounds.size.width/2.0 -CGPathGetBoundingBox(aPath.CGPath).size.width/2.0, self.bounds.size.height/2.0-CGPathGetBoundingBox(aPath.CGPath).size.height/2.0)];
    
    
    
    
    [aPath applyTransform:CGAffineTransformMakeTranslation(0, 8)];
    
    
    
    
    
    return aPath;
    
}




- (void)pointForObjectAtIndex {
    
    UIBezierPath *pointPath = [self createFacePath];
    
    NSMutableArray *faceArray = [NSMutableArray arrayWithCapacity:18];
    
    
    
    NSArray *thePointsArray = pointPath.bezierElements;
    
    for (NSArray *bArrray in thePointsArray) {
        
        for (NSValue *value in bArrray) {
            
            if (![value isKindOfClass:[NSNumber class]]) {
                
                [faceArray addObject:value];
                
                
            }
            
            
        }
        
        
    }
    
    
    self.pointsArray = faceArray;
    NSLog(@"SELF.POINTSARRAY:%@",self.pointsArray);
    
}









-(void)createPointView {
    
    NSArray *sortArray = [NSArray arrayWithArray:self.pointsArray];
    
    NSMutableArray *transitionArray = [NSMutableArray arrayWithCapacity:18];
    NSMutableArray *touchArray = [NSMutableArray arrayWithCapacity:18];
    
    
    for (NSValue *value in sortArray) {
        
        self.facePoint = [[FacePoint alloc]initWithFrame:CGRectMake(0, 0, 44, 22)];
        self.facePoint.center = value.CGPointValue;
        self.facePoint.delegate = self;
        
        NSUInteger pointNum = [sortArray indexOfObject:value];
        
        self.facePoint.tag = pointNum + 1;
        
        
        [transitionArray addObject:self.facePoint];
        
        
        
        
        
        
        self.touchPoint = [[FacePoint alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        self.touchPoint.center = self.facePoint.center;
        self.touchPoint.delegate =self;
        self.touchPoint.controlPointView = self.facePoint;
        
        
        [touchArray addObject:self.touchPoint];
        
    }
    
    
    self.lineArray = touchArray;
    self.viewArray = transitionArray;
    
    
    
    [self translateTouchPoint];
    
}



-(void)translateTouchPoint {
    
    
    FacePoint *upperLeftSecondControlPoint = [self.viewArray objectAtIndex:2];
    FacePoint *upperRightSecondControlPoint = [self.viewArray objectAtIndex:5];
    FacePoint *midRightCurveControlPoint = [self.viewArray objectAtIndex:9];
    FacePoint *lowerRightCuveControlPoint = [self.viewArray objectAtIndex:11];
    FacePoint *bottomQuadCurveControlPoint = [self.viewArray objectAtIndex:13];
    FacePoint *lowerLeftCurveControlPoint = [self.viewArray objectAtIndex:15];
    
    
    for (int i = 0; i < self.lineArray.count; i++) {
        
        FacePoint *tPoint = (FacePoint *)[self.lineArray objectAtIndex:i];
        FacePoint *fPoint = (FacePoint *)[self.viewArray objectAtIndex:i];
        
        switch (i) {
            case 1:
                
                tPoint.center = CGPointMake(fPoint.center.x - 30, fPoint.center.y - 30);
                tPoint.secondControlPointView = upperLeftSecondControlPoint;
                [self addSubview:tPoint];
                
                break;
                
                
                
            case 3:
                tPoint.center = CGPointMake(fPoint.center.x - 12, fPoint.center.y);
                [self addSubview:tPoint];

                
                break;
                
            case 4:
                tPoint.center = CGPointMake(fPoint.center.x + 12, fPoint.center.y);
                [self addSubview:tPoint];

                
                break;
                
                
            case 6:
                tPoint.center = CGPointMake(fPoint.center.x +  30, fPoint.center.y - 30);
                tPoint.secondControlPointView = upperRightSecondControlPoint;
                [self addSubview:tPoint];

                break;
                
            case 8:
                tPoint.center = CGPointMake(fPoint.center.x +  20.0, fPoint.center.y);
                [self addSubview:tPoint];

                break;
                
                
                
            case 10:
                tPoint.center = CGPointMake(fPoint.center.x + 30, fPoint.center.y + 10);
                tPoint.secondControlPointView = midRightCurveControlPoint;
                tPoint.thirdControlPointView = lowerRightCuveControlPoint;
                
                [self addSubview:tPoint];
                
                
                break;
                
                
            case 12:
                tPoint.center = CGPointMake(fPoint.center.x, fPoint.center.y);
                [self addSubview:tPoint];
                break;
                
                
            case 14:
                tPoint.center = CGPointMake(fPoint.center.x - 30, fPoint.center.y + 10);
                tPoint.secondControlPointView = bottomQuadCurveControlPoint;
                tPoint.thirdControlPointView = lowerLeftCurveControlPoint;
                
                [self addSubview:tPoint];
                break;
                
            case 16:
                tPoint.center = CGPointMake(fPoint.center.x - 20.0, fPoint.center.y);
                [self addSubview:tPoint];
                break;
                
                
                
            default:
                break;
        }
        
        
    }
}





-(void)repositionPoints {
    
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [self pointForObjectAtIndex];
    [self createPointView];
    
    [self setNeedsDisplay];
    
}









-(UIBezierPath *)findPointOfAttachementWithCubicPath:(UIBezierPath *)cubicPath withStartingPoint:(CGPoint)startingPoint atFirstControlPoint:(CGPoint)firstControlPoint andSecondControlPoint:(CGPoint)secondControlPoint atEndingPoint:(CGPoint)endingPoint withTouchPointAtIndex:(NSUInteger)index  withPercentage:(float)percentage {
    
    UIView *touchPoint = [self.lineArray objectAtIndex:index];
    
    CGPoint attachmenetPoint = [cubicPath findCurveBezierPathPointInBetweenTheStartPoint:startingPoint
                                                                             theEndPoint:endingPoint
                                                                   withFirstControlPoint:firstControlPoint
                                                                   andSecondControlPoint:secondControlPoint       atPercentage:percentage];
    
    
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    [bPath moveToPoint:attachmenetPoint];
    
    [bPath addLineToPoint:touchPoint.center];
    
    bPath.lineWidth = 4.0;
    
    
    return bPath;
    
}



-(UIBezierPath *)findPointOfAttachementWithQuadCurve:(UIBezierPath *)quadPath withStartingPoint:(CGPoint)startingPoint atControlPoint:(CGPoint)controlPoint atEndingPoint:(CGPoint)endingPoint withTouchPointAtIndex:(NSUInteger)index withPercentage:(float)percentage {
    
    UIView *touchPoint = [self.lineArray objectAtIndex:index];
    
    CGPoint attachmenetPoint = [quadPath findQuadBezierPathPointInBetweenTheStartPoint:startingPoint theEndPoint:endingPoint withControlPoint:controlPoint atPercentage:percentage];
    
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    [bPath moveToPoint:attachmenetPoint];
    
    [bPath addLineToPoint:touchPoint.center];
    
    bPath.lineWidth = 4.0;
    
    
    return bPath;
    
    
}


//-(CAShapeLayer *)createTransparentBackgroundWithPath:(UIBezierPath *)bezPath {
//    
//    
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) cornerRadius:0];
//    
//    [path appendPath:bezPath];
//    [path setUsesEvenOddFillRule:YES];
//    
//    CAShapeLayer *fillLayer = [CAShapeLayer layer];
//    fillLayer.path = path.CGPath;
//    fillLayer.fillRule = kCAFillRuleEvenOdd;
//    fillLayer.fillColor = [UIColor whiteColor].CGColor;
//    fillLayer.opacity = 0.25;
//    
//    return fillLayer;
//}


-(CAShapeLayer *)createFaceOutlineWithPath:(UIBezierPath *)bezPath {
    
    
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezPath.CGPath;
    shapeLayer.strokeColor = [UIColor colorWithWhite:1.000 alpha:0.800].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;

    shapeLayer.lineWidth = 4.0;
    
    return shapeLayer;
    
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    UIView *startingPoint = [self.viewArray objectAtIndex:0];
    
    UIView *topLeftCurvePoint = [self.viewArray objectAtIndex:2];
    UIView *topLeftCurveControlPoint = [self.viewArray objectAtIndex:1];
    
    
    UIView *topCurvePoint = [self.viewArray objectAtIndex:5];
    
    UIView *topCurveFirstControlPoint = [self.viewArray objectAtIndex:3];
    
    UIView *topCurveSecondControlPoint = [self.viewArray objectAtIndex:4];
    
    
    UIView *topRightCurvePoint = [self.viewArray objectAtIndex:7];
    UIView *topRightCurveFirstControlPoint = [self.viewArray objectAtIndex:6];
    
    
    UIView *midRightCurvePoint = [self.viewArray objectAtIndex:9];
    UIView *midRightCurveFirstControlPoint = [self.viewArray objectAtIndex:8];
    
    
    UIView *lowerRightCurvePoint = [self.viewArray objectAtIndex:11];
    UIView *lowerRightCurveFirstControlPoint = [self.viewArray objectAtIndex:10];
    
    
    UIView *bottomQuadCurvePoint = [self.viewArray objectAtIndex:13];
    UIView *bottomQuadCurveFirstControlPoint = [self.viewArray objectAtIndex:12];
    
    UIView *lowerLeftCurvePoint = [self.viewArray objectAtIndex:15];
    UIView *lowerLeftCurveFirstControlPoint = [self.viewArray objectAtIndex:14];
    
    UIView *midLeftCurvePoint = [self.viewArray objectAtIndex:17];
    UIView *midLeftCurveFirstControlPoint = [self.viewArray objectAtIndex:16];
    
    
    
    self.aPath = [UIBezierPath bezierPath];
    
    self.aPath.lineWidth = 3.0;
    
    
    [self.aPath moveToPoint:startingPoint.center];
    
    
    
    [self.aPath addQuadCurveToPoint:topLeftCurvePoint.center controlPoint:topLeftCurveControlPoint.center];
    
    
    
    [self.aPath addCurveToPoint:topCurvePoint.center controlPoint1:topCurveFirstControlPoint.center controlPoint2:topCurveSecondControlPoint.center];
    
    
    
    
    
    [self.aPath addQuadCurveToPoint:topRightCurvePoint.center controlPoint:topRightCurveFirstControlPoint.center];
    
    
    
    [self.aPath addQuadCurveToPoint:midRightCurvePoint.center controlPoint:midRightCurveFirstControlPoint.center];
    
    [self.aPath addQuadCurveToPoint:lowerRightCurvePoint.center controlPoint:lowerRightCurveFirstControlPoint.center];
    
    
    [self.aPath addQuadCurveToPoint:bottomQuadCurvePoint.center controlPoint:bottomQuadCurveFirstControlPoint.center];
    
    [self.aPath addQuadCurveToPoint:lowerLeftCurvePoint.center controlPoint:lowerLeftCurveFirstControlPoint.center];
    
    
    [self.aPath addQuadCurveToPoint:midLeftCurvePoint.center controlPoint:midLeftCurveFirstControlPoint.center];
    
    
    self.aPath.lineJoinStyle = kCGLineJoinRound;

    
    [self.aPath closePath];
    
    
    
    
    
    

    UIBezierPath *topLeftCurvePathLine = [self findPointOfAttachementWithQuadCurve:self.aPath withStartingPoint:startingPoint.center atControlPoint:topLeftCurveControlPoint.center atEndingPoint:topLeftCurvePoint.center withTouchPointAtIndex:1 withPercentage:0.9];
    
    
    
    UIBezierPath *topCurveFirstControlPathLine = [self findPointOfAttachementWithCubicPath:self.aPath  withStartingPoint:topLeftCurvePoint.center atFirstControlPoint:topCurveFirstControlPoint.center andSecondControlPoint:topCurveSecondControlPoint.center atEndingPoint:topCurvePoint.center withTouchPointAtIndex:3 withPercentage:0.3];
    
    UIBezierPath *topCurveSecondControlPathLine = [self findPointOfAttachementWithCubicPath:self.aPath  withStartingPoint:topLeftCurvePoint.center atFirstControlPoint:topCurveFirstControlPoint.center andSecondControlPoint:topCurveSecondControlPoint.center atEndingPoint:topCurvePoint.center withTouchPointAtIndex:4 withPercentage:0.7];
    
    
    UIBezierPath *topRightCurvePathLine = [self findPointOfAttachementWithQuadCurve:self.aPath withStartingPoint:topCurvePoint.center atControlPoint:topRightCurveFirstControlPoint.center atEndingPoint:topRightCurvePoint.center withTouchPointAtIndex:6 withPercentage:0.1];
    
    
    
    
    UIBezierPath *midRightCurvePathLine = [self findPointOfAttachementWithQuadCurve:self.aPath withStartingPoint:topRightCurvePoint.center atControlPoint:midRightCurveFirstControlPoint.center atEndingPoint:midRightCurvePoint.center withTouchPointAtIndex:8 withPercentage:0.5];
    
    
    
    
    UIBezierPath *lowerRightCurvePathLine = [self findPointOfAttachementWithQuadCurve:self.aPath withStartingPoint:midRightCurvePoint.center atControlPoint:lowerRightCurveFirstControlPoint.center atEndingPoint:lowerRightCurvePoint.center withTouchPointAtIndex:10 withPercentage:0.5];
    
    
    UIBezierPath *bottomQuadCurvePathLine = [self findPointOfAttachementWithQuadCurve:self.aPath withStartingPoint:lowerRightCurvePoint.center atControlPoint:bottomQuadCurveFirstControlPoint.center atEndingPoint:bottomQuadCurvePoint.center withTouchPointAtIndex:12 withPercentage:0.5];
    
    
    
    UIBezierPath *lowerLeftCurvePathLine = [self findPointOfAttachementWithQuadCurve:self.aPath withStartingPoint:bottomQuadCurvePoint.center atControlPoint:lowerLeftCurveFirstControlPoint.center atEndingPoint:lowerLeftCurvePoint.center withTouchPointAtIndex:14 withPercentage:0.5];
    
    
    UIBezierPath *midLeftCurvePathLine = [self findPointOfAttachementWithQuadCurve:self.aPath withStartingPoint:lowerLeftCurvePoint.center atControlPoint:midLeftCurveFirstControlPoint.center atEndingPoint:midLeftCurvePoint.center withTouchPointAtIndex:16 withPercentage:0.5];
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    


    CGContextSaveGState(context);
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) cornerRadius:0];
    
    [path appendPath:self.aPath];
    [path setUsesEvenOddFillRule:YES];
    
    [[UIColor colorWithWhite:0.200 alpha:0.800] setFill];
    
    [path fill];
    
    
    
    CGContextRestoreGState(context);
    
    CGContextAddPath(context, self.aPath.CGPath);


    
    CGContextAddPath(context, topLeftCurvePathLine.CGPath);
    CGContextAddPath(context, topCurveFirstControlPathLine.CGPath);
    CGContextAddPath(context, topCurveSecondControlPathLine.CGPath);
    CGContextAddPath(context, topRightCurvePathLine.CGPath);
    CGContextAddPath(context, midRightCurvePathLine.CGPath);
    CGContextAddPath(context, lowerRightCurvePathLine.CGPath);
    CGContextAddPath(context, bottomQuadCurvePathLine.CGPath);
    CGContextAddPath(context, lowerLeftCurvePathLine.CGPath);
    CGContextAddPath(context, midRightCurvePathLine.CGPath);
    CGContextAddPath(context, midLeftCurvePathLine.CGPath);

    CGContextSetShouldAntialias(context, YES);

    
    CGContextSetLineWidth(context, 3.0);

    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:1.000 alpha:0.800].CGColor);
    
    CGContextStrokePath(context);
    
    
    
}



@end
