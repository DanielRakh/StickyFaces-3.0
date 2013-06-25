//
//  PointsView.m
//  TestCroping
//
//  Created by Javier Berlana on 20/12/12.
//  Copyright (c) 2012 Mobile one2one. All rights reserved.
//

#import "JBCroppableView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView-Transform.h"
#import "UIImage+Resize.h"
#import "UIBezierPath-Points.h"

#import "ACMagnifyingView.h"
#import "ACMagnifyingGlass.h"
#import "ACLoupe.h"


#define k_POINT_WIDTH 30

#define degreesToRadians(x) ((x) * (M_PI / 180.0))
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))



@interface JBCroppableView () {
    
    CGPoint lastPoint;
    UIBezierPath *LastBezierPath;
    BOOL isContainView;
    BOOL drawRectCalled;
    
    CGRect pathBoundingBox; 
    
    
}

@property (nonatomic, strong) NSArray *points;
@property (nonatomic, strong) UIView *activePoint;

@property (nonatomic, strong) UIBezierPath *outlinePath;
@property (nonatomic, strong) UIBezierPath *facePath;


+ (CGPoint)convertCGPoint:(CGPoint)point1 fromRect1:(CGSize)rect1 toRect2:(CGSize)rect2;

@end

@implementation JBCroppableView


// 1st Method Called....takes the imageView from the other VC and calls "addPointsAt".

-(UIBezierPath *)createFacePath {
    
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
    
    
    
    
    [aPath applyTransform:CGAffineTransformMakeTranslation(0, 0)];
    
    
    
    return aPath;
    
}




- (id)initWithImageView:(UIImageView *)imageView
{
    
   
    
    
    self = [super initWithFrame:imageView.frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.pointColor      = [UIColor orangeColor];
        self.lineColor       = [UIColor blackColor];
        self.clipsToBounds   = YES;
        self.userInteractionEnabled = YES;
        isContainView = YES;
        
        drawRectCalled = YES;
        LastBezierPath = [UIBezierPath bezierPath];
        
                
        
        UIBezierPath *aPath = [self createFacePath];
        
        NSArray *pointsArray = aPath.bezierElements;
        NSLog(@"Points Array Bezier Elements:%@",pointsArray);

        
        NSArray *freshArray = [NSArray arrayWithObjects:
                               [[pointsArray objectAtIndex:0]objectAtIndex:1],
                               [[pointsArray objectAtIndex:1]objectAtIndex:3],
                               [[pointsArray objectAtIndex:1]objectAtIndex:1],
                               [[pointsArray objectAtIndex:1]objectAtIndex:2],
                               [[pointsArray objectAtIndex:2]objectAtIndex:2],
                               [[pointsArray objectAtIndex:2]objectAtIndex:1],
                               [[pointsArray objectAtIndex:3]objectAtIndex:2],
                               [[pointsArray objectAtIndex:3]objectAtIndex:1],
                               [[pointsArray objectAtIndex:4]objectAtIndex:2],
                               [[pointsArray objectAtIndex:4]objectAtIndex:1],
                               [[pointsArray objectAtIndex:5]objectAtIndex:2],
                               [[pointsArray objectAtIndex:5]objectAtIndex:1],
                               [[pointsArray objectAtIndex:6]objectAtIndex:2],
                               [[pointsArray objectAtIndex:6]objectAtIndex:1],
                               [[pointsArray objectAtIndex:7]objectAtIndex:2],
                               [[pointsArray objectAtIndex:7]objectAtIndex:1],
                               [[pointsArray objectAtIndex:8]objectAtIndex:2],
                               [[pointsArray objectAtIndex:8]objectAtIndex:1],
                               nil];
    
        
        [self addPointsAt:freshArray];
    
        NSLog(@"Fresh Array Bezier Elements:%@",freshArray);

        
        
    }
    
    
    return self;
}

//2nd method called
//  This method creates a temporary array where the points are created and added to the view....the points are UIView's. After they are creaetd and added they are added to the universal "points" array which is also a property of the class.

//The "getPointView: at: " method is called here.
- (void)addPointsAt:(NSArray *)points
{
    NSMutableArray *tmp = [NSMutableArray array];
    UIView *pointToAdd;
    NSValue *pointValue;
/*
    uint i = 0;
    for (NSValue *point in points)
    {
        
        switch (i) {
            case 0:
                pointToAdd = [self getPointView:i at:point.CGPointValue];
                [tmp addObject:pointToAdd];
                [self addSubview:pointToAdd];

                break;
                
            default:
                break;
        }
        

        i++;
    }
    

    self.points = tmp;
    
    */
    
    for (int i = 0; i < points.count; i++) {
        
        switch (i) {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
            case 15:
            case 16:
            case 17:
                
                pointValue = [points objectAtIndex:i];
                pointToAdd = [self getPointView:i at:pointValue.CGPointValue];
                [tmp addObject:pointToAdd];
                [self addSubview:pointToAdd];
                NSLog(@"Switch Method points:%@",NSStringFromCGPoint(pointToAdd.frame.origin));
                [self bringSubviewToFront:pointToAdd];
               
                break;
        
                
            default:
                break;
        }
   
    }
    
    self.points = tmp;

    
    
    NSLog(@"SELF.POINTS:%@",self.points);
    
    
}



// 3rd method called

//This method is the one that actually created the Point UIView's that were added in the previous method...

// It creates a UIView





- (UIView *)getPointView:(int)num at:(CGPoint)point
{
    UIView *point1;

    
    point1 = [[UIView alloc] initWithFrame:CGRectMake(point.x-k_POINT_WIDTH/2.0, point.y-k_POINT_WIDTH/2.0, k_POINT_WIDTH, k_POINT_WIDTH)];

    
    
    point1.alpha = 0.8;
    point1.backgroundColor    = self.pointColor;
    point1.layer.borderColor  = self.lineColor.CGColor;
    point1.layer.borderWidth  = 4;
    point1.layer.cornerRadius = k_POINT_WIDTH/2.0;
    
    UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, k_POINT_WIDTH, k_POINT_WIDTH)];
    number.text = [NSString stringWithFormat:@"%d",num];
    number.textColor = [UIColor whiteColor];
    number.backgroundColor = [UIColor clearColor];
    number.font = [UIFont systemFontOfSize:14];
    number.textAlignment = NSTextAlignmentCenter;
    
    [point1 addSubview:number];
    
    return point1;

    
}




- (NSArray *)getPoints
{
    NSMutableArray *p = [NSMutableArray array];
    
    for (uint i=0; i<self.points.count; i++)
    {
        UIView *v = [self.points objectAtIndex:i];
        CGPoint point = CGPointMake(v.frame.origin.x +k_POINT_WIDTH/2, v.frame.origin.y +k_POINT_WIDTH/2);
//        CGPoint point = CGPointMake(v.frame.origin.x, v.frame.origin.y);
        
        [p addObject:[NSValue valueWithCGPoint:point]];
    }
    
    return p;
}




#pragma mark - Support methods

+ (CGRect)scaleRespectAspectFromRect1:(CGRect)rect1 toRect2:(CGRect)rect2
{
    CGSize scaledSize = rect2.size;
    
    float scaleFactor = 1.0;
    
    CGFloat widthFactor  = rect2.size.width / rect1.size.width;
    CGFloat heightFactor = rect2.size.height / rect1.size.width;
    
    if (widthFactor < heightFactor)
        scaleFactor = widthFactor;
    else
        scaleFactor = heightFactor;
    
    scaledSize.height = rect1.size.height *scaleFactor;
    scaledSize.width  = rect1.size.width  *scaleFactor;
    
    float y = (rect2.size.height - scaledSize.height)/2;
    
    return CGRectMake(0, y, scaledSize.width, scaledSize.height);
}


+ (CGPoint)convertCGPoint:(CGPoint)point1 fromRect1:(CGSize)rect1 toRect2:(CGSize)rect2
{
    
    point1.y = rect1.height - point1.y;
    CGPoint result = CGPointMake((point1.x*rect2.width)/rect1.width, (point1.y*rect2.height)/rect1.height);
    return result;
    
    

}


+ (CGPoint)convertPoint:(CGPoint)point1 fromRect1:(CGSize)rect1 toRect2:(CGSize)rect2
{
    CGPoint result = CGPointMake((point1.x*rect2.width)/rect1.width, (point1.y*rect2.height)/rect1.height);
    return result;
}

- (UIImage *)deleteBackgroundOfImage:(UIImageView *)image
{
    if (self.points.count <= 0) return nil;
    
    image.clearsContextBeforeDrawing = YES;
    
    NSArray *points = [self getPoints];
    
    CGRect rect = CGRectZero;
    rect.size = image.image.size;
    
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0);
    
    {
        [[UIColor blackColor] setFill];
        UIRectFill(rect);
        [[UIColor whiteColor] setFill];
        
        self.outlinePath = [UIBezierPath bezierPath];
        

        
        
        
        // Set the starting point of the shape.
        CGPoint p1 = [JBCroppableView convertCGPoint:[[points objectAtIndex:0] CGPointValue] fromRect1:image.frame.size toRect2:image.image.size];
        [self.outlinePath moveToPoint:CGPointMake(p1.x, p1.y)];
        
        /*
         for (uint i=1; i<points.count; i++)
         {
         CGPoint p = [JBCroppableView convertCGPoint:[[points objectAtIndex:i] CGPointValue] fromRect1:image.frame.size toRect2:image.image.size];
         [aPath addLineToPoint:CGPointMake(p.x, p.y)];
         
         }
         
         */
        
        CGPoint topCurvePoint = [JBCroppableView convertCGPoint:[[points objectAtIndex:1] CGPointValue] fromRect1:image.frame.size toRect2:image.image.size];
        
        
        
        CGPoint topCurveFirstControlPoint = [JBCroppableView convertCGPoint:[[points objectAtIndex:2] CGPointValue] fromRect1:image.frame.size toRect2:image.image.size];
        
        
        CGPoint topCurveSecondControlPoint = [JBCroppableView convertCGPoint:[[points objectAtIndex:3] CGPointValue] fromRect1:image.frame.size toRect2:image.image.size];
        
        CGPoint topRightPoint = [JBCroppableView convertCGPoint:[[points objectAtIndex:4] CGPointValue] fromRect1:image.frame.size toRect2:image.image.size];
        
        CGPoint topRightControlPoint = [JBCroppableView convertCGPoint:[[points objectAtIndex:5] CGPointValue] fromRect1:image.frame.size toRect2:image.image.size];
        
        CGPoint midRightPoint = [JBCroppableView convertCGPoint:[[points objectAtIndex:6] CGPointValue] fromRect1:image.frame.size toRect2:image.image.size];
        
        CGPoint midRightControlPoint = [JBCroppableView convertCGPoint:[[points objectAtIndex:7] CGPointValue] fromRect1:image.frame.size toRect2:image.image.size];
        
        CGPoint lowerRightPoint = [JBCroppableView convertCGPoint:[[points objectAtIndex:8] CGPointValue] fromRect1:image.frame.size toRect2:image.image.size];
        
        CGPoint lowerRightControlPoint = [JBCroppableView convertCGPoint:[[points objectAtIndex:9] CGPointValue] fromRect1:image.frame.size toRect2:image.image.size];
        
        
        CGPoint bottomQuadCurvePoint = [JBCroppableView convertCGPoint:[[points objectAtIndex:10] CGPointValue] fromRect1:image.frame.size toRect2:image.image.size];
        
        CGPoint bottomQuardCurveControlPoint = [JBCroppableView convertCGPoint:[[points objectAtIndex:11] CGPointValue] fromRect1:image.frame.size toRect2:image.image.size];
        
        
        CGPoint lowerLeftPoint = [JBCroppableView convertCGPoint:[[points objectAtIndex:12] CGPointValue] fromRect1:image.frame.size toRect2:image.image.size];
        
        CGPoint lowerLeftControlPoint = [JBCroppableView convertCGPoint:[[points objectAtIndex:13] CGPointValue] fromRect1:image.frame.size toRect2:image.image.size];
        
        CGPoint midLeftPoint = [JBCroppableView convertCGPoint:[[points objectAtIndex:14] CGPointValue] fromRect1:image.frame.size toRect2:image.image.size];
        
        CGPoint midLeftControlPoint = [JBCroppableView convertCGPoint:[[points objectAtIndex:15] CGPointValue] fromRect1:image.frame.size toRect2:image.image.size];
        
        CGPoint topLeftPoint = [JBCroppableView convertCGPoint:[[points objectAtIndex:16] CGPointValue] fromRect1:image.frame.size toRect2:image.image.size];
        
        CGPoint topLeftControlPoint = [JBCroppableView convertCGPoint:[[points objectAtIndex:17] CGPointValue] fromRect1:image.frame.size toRect2:image.image.size];
        

        
        
        [self.outlinePath addCurveToPoint:topCurvePoint controlPoint1:topCurveFirstControlPoint controlPoint2:topCurveSecondControlPoint];
        
        [self.outlinePath addQuadCurveToPoint:topRightPoint controlPoint:topRightControlPoint];
        
        [self.outlinePath addQuadCurveToPoint:midRightPoint controlPoint:midRightControlPoint];
        
        [self.outlinePath addQuadCurveToPoint:lowerRightPoint controlPoint:lowerRightControlPoint];
        
        
        [self.outlinePath addQuadCurveToPoint:bottomQuadCurvePoint controlPoint:bottomQuardCurveControlPoint];
        
        [self.outlinePath addQuadCurveToPoint:lowerLeftPoint controlPoint:lowerLeftControlPoint];
        
        
        [self.outlinePath addQuadCurveToPoint:midLeftPoint controlPoint:midLeftControlPoint];
        
        [self.outlinePath addQuadCurveToPoint:topLeftPoint controlPoint:topLeftControlPoint];
        
        
        
        
        
        [self.outlinePath closePath];

        [self.outlinePath applyTransform:CGAffineTransformMakeScale(0.9, 0.9)];
        
        self.outlinePath = [self translateCurrentBezierPath:self.outlinePath toCenterOfView:self];
        
    }
    

    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    
    
    {
        
        [self.outlinePath addClip];
        
        [image.image drawAtPoint:CGPointZero];
    }
    
    UIImage *maskedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIImage *freshImage = [self addBackgroundToImage:maskedImage withPath:self.outlinePath];
    
    
    
    
    return freshImage;
}

#pragma mark - Draw & touch


- (CGFloat) xscaleOfTransform:(CGAffineTransform)transform
{
    CGAffineTransform t = transform;
    return sqrt(t.a * t.a + t.c * t.c);
}

- (CGFloat) yscaleofTransform:(CGAffineTransform)transform
{
    CGAffineTransform t = transform;
    return sqrt(t.b * t.b + t.d * t.d);
}


-(UIImage *)addBackgroundToImage:(UIImage *)image withPath:(UIBezierPath *)backgroundPath {
    
    CGSize size  =  image.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
//    CGContextRef con = UIGraphicsGetCurrentContext();
    
    [[UIColor whiteColor]setFill];
    
    CGAffineTransform theTransform = CGAffineTransformMakeScale(1.1, 1.1);
    
    
    [backgroundPath applyTransform:theTransform];
    UIBezierPath *bgPath = [self translateCurrentBezierPath:backgroundPath toCenterOfView:self];
    [bgPath fill];
    
    


    
    
    
    [image drawAtPoint:CGPointZero blendMode:kCGBlendModeNormal alpha:1.0];
    
    UIImage *freshImage = UIGraphicsGetImageFromCurrentImageContext();
    
    return freshImage;
    
    
    
}

-(float) getRotatingAngle : (CGPoint)firstPoint secondPoint:(CGPoint)secondPoint
{
    float dx = firstPoint.x - secondPoint.x;
    float dy = firstPoint.y - secondPoint.y;
    float angle = (atan2(dy, dx));
    return angle;
}

- (void)drawRect:(CGRect)rect

{
   if (self.points.count <= 0) return;
    

    UIView *point1 = [self.points objectAtIndex:0];

    UIView *topCurvePoint = [self.points objectAtIndex:1];
   
    UIView *topCurveFirstControlPoint = [self.points objectAtIndex:2];
    
    
    UIView *topCurveSecondControlPoint = [self.points objectAtIndex:3];
    UIView *topRightPoint = [self.points objectAtIndex:4];
    UIView *topRightControlPoint = [self.points objectAtIndex:5];
    UIView *midRightPoint = [self.points objectAtIndex:6];
    UIView *midRightControlPoint = [self.points objectAtIndex:7];
    UIView *lowerRightPoint = [self.points objectAtIndex:8];
    UIView *lowerRightControlPoint = [self.points objectAtIndex:9];
    UIView *bottomQuadCurvePoint = [self.points objectAtIndex:10];
    UIView *bottomQuardCurveControlPoint = [self.points objectAtIndex:11];
    UIView *lowerLeftPoint = [self.points objectAtIndex:12];
    UIView *lowerLeftControlPoint = [self.points objectAtIndex:13];
    UIView *midLeftPoint= [self.points objectAtIndex:14];
    UIView *midLeftControlPoint = [self.points objectAtIndex:15];
    UIView *topLeftPoint = [self.points objectAtIndex:16];
    UIView *topLeftControlPoint = [self.points objectAtIndex:17];
    
/*
    

//    I AM CREATING THE FIXED POINT HERE THAT IS BEING RETURNED BY A CUSTOM METHOD THAT FINDS THE POINT OF ATTACHEMENT OF THE LARGER IRREGULAR SHAPED UIBEZIERPATH.
//    THE DRAGGABLE POINTS ARE ACTUALLY UIVIEW'S AND I'M USING THEIR ORIGINS.
    
    CGPoint fixedPoint = [aPath findCurveBezierPathPointInBetweenTheStartPoint:point1.frame.origin theEndPoint:topCurvePoint.frame.origin withFirstControlPoint:topCurveFirstControlPoint.frame.origin andSecondControlPoint:topCurveSecondControlPoint.frame.origin atPercentage:0.3];
    
    
    NSLog(@"%@",NSStringFromCGPoint(fixedPoint));
    
    
    
//    This is the fixed point
    CGPoint startPoint = fixedPoint;
    
//    This is the point that is going to be able to be dragged
    CGPoint endPoint = topCurveFirstControlPoint.frame.origin;
    
    
//    I am finding the angle in between these two points to pass in an CGAffineTransform for the rotation. 
    float angle = [self getRotatingAngle:startPoint secondPoint:endPoint];

    
    
//    I am creating the transform by passing in the angle and doing the necessary translations for the rotation to occur on the fixed point. 
    CGAffineTransform transform = CGAffineTransformMakeTranslation(fixedPoint.x, fixedPoint.y);
    transform = CGAffineTransformRotate(transform, angle);
    transform = CGAffineTransformTranslate(transform,-fixedPoint.x,-fixedPoint.y);
    
    
//  I am setting up to draw the line of fixed length and applying the transform and 
    [aPath moveToPoint:startPoint];
    [aPath addLineToPoint:endPoint];
//    [aPath addLineToPoint:CGPointMake(fixedPoint.x, fixedPoint.y - 50)];
//    [aPath applyTransform:transform];


    */
    
// I then continue to draw the rest of the BezierPath and stroke it at the end.
    
    
    UIBezierPath *aPath = [UIBezierPath bezierPath];

    
    [aPath moveToPoint:point1.frame.origin];
    
    [aPath addCurveToPoint:topCurvePoint.frame.origin controlPoint1:CGPointMake(topCurveFirstControlPoint.frame.origin.x,topCurveFirstControlPoint.frame.origin.y)controlPoint2:topCurveSecondControlPoint.frame.origin];
    
    
    CGPoint fixedPoint = [aPath findCurveBezierPathPointInBetweenTheStartPoint:point1.frame.origin theEndPoint:topCurvePoint.frame.origin withFirstControlPoint:topCurveFirstControlPoint.frame.origin andSecondControlPoint:topCurveSecondControlPoint.frame.origin atPercentage:0.3];
    
    
    NSLog(@"DRAW RECT POINT:%@",NSStringFromCGPoint(topCurveFirstControlPoint.frame.origin));
    
    
    [aPath addQuadCurveToPoint:topRightPoint.frame.origin controlPoint:topRightControlPoint.frame.origin];
    
    
    [aPath addQuadCurveToPoint:midRightPoint.frame.origin controlPoint:midRightControlPoint.frame.origin];
    
    [aPath addQuadCurveToPoint:lowerRightPoint.frame.origin controlPoint:lowerRightControlPoint.frame.origin];
    
    
    [aPath addQuadCurveToPoint:bottomQuadCurvePoint.frame.origin controlPoint:bottomQuardCurveControlPoint.frame.origin];
    
    [aPath addQuadCurveToPoint:lowerLeftPoint.frame.origin controlPoint:lowerLeftControlPoint.frame.origin];
    

    [aPath addQuadCurveToPoint:midLeftPoint.frame.origin controlPoint:midLeftControlPoint.frame.origin];
 
    [aPath addQuadCurveToPoint:topLeftPoint.frame.origin controlPoint:topLeftControlPoint.frame.origin];
   
//    [aPath closePath];
    


    
    

    if (drawRectCalled) {
        pathBoundingBox = CGPathGetBoundingBox(aPath.CGPath);
        drawRectCalled = NO;
    }
    
 
    
    
    
    float yOrigin = pathBoundingBox.origin.y;
    float xOrigin = pathBoundingBox.origin.x;
    
    [aPath applyTransform:CGAffineTransformMakeTranslation(-xOrigin, -yOrigin)];
    
    
    [aPath applyTransform:CGAffineTransformMakeTranslation(self.bounds.size.width/2.0 -pathBoundingBox.size.width/2.0, self.bounds.size.height/2.0-pathBoundingBox.size.height/2.0)];
    
    [aPath applyTransform:CGAffineTransformMakeTranslation(0, 0)];

    aPath.lineWidth = 3.0;
    
    [aPath stroke];
    
    
    

}

-(NSArray *)returnPointsFromBezierPath:(UIBezierPath *)bezPath {
    
    NSArray *thePoints = bezPath.points;
    
    
    return thePoints;
}




-(UIBezierPath *)translateCurrentBezierPath:(UIBezierPath *)bezPath toCenterOfView:(UIView *)view {
    
    
    UIBezierPath *aPath = [UIBezierPath bezierPathWithCGPath:bezPath.CGPath];
    
    
    float yOrigin = CGPathGetBoundingBox(aPath.CGPath).origin.y;
    float xOrigin = CGPathGetBoundingBox(aPath.CGPath).origin.x;
    
    
    CGAffineTransform originTransform;
    CGAffineTransform centerTransform;
    
    
    
    
    //Translate the origin of the bounding box of the BezierPath to CGPointZero
 /*
    if ((xOrigin < 0) && (yOrigin < 0)) {
        
        
        originTransform = CGAffineTransformMakeTranslation(-xOrigin, -yOrigin);
        
    }
    else if ((xOrigin >= 0 ) && (yOrigin >= 0)) {
        originTransform = CGAffineTransformMakeTranslation(-xOrigin, -yOrigin);
    }
    
    else if ((xOrigin < 0) && (yOrigin >= 0))
    {
        originTransform = CGAffineTransformMakeTranslation(-xOrigin, yOrigin);
    }
    else if ((xOrigin >= 0 ) && (yOrigin < 0)){
        originTransform = CGAffineTransformMakeTranslation(xOrigin, -yOrigin);
    }
    */
     originTransform = CGAffineTransformMakeTranslation(-xOrigin, -yOrigin);
    
    centerTransform = CGAffineTransformTranslate(originTransform, view.center.x -CGPathGetBoundingBox(aPath.CGPath).size.width/2.0, view.center.y-CGPathGetBoundingBox(aPath.CGPath).size.height/2.0);
    
    [aPath applyTransform:centerTransform];
    
    return aPath;
}


//Detect Finger in BezierPath
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    
    if (self.points.count <= 0) return NO;
    
    CGPoint locationPoint = point;
    
    for (UIView *pointView in self.points)
    {
        CGPoint viewPoint = [pointView convertPoint:locationPoint fromView:self];
        
        if ([pointView pointInside:viewPoint withEvent:event])
        {
            
            return  YES;
            break;
        }
    }
    
    lastPoint = locationPoint;
    
    [LastBezierPath removeAllPoints];
    
    NSArray *points = [self getPoints];
    
    CGSize rectSize = self.frame.size;
    
    // Set the starting point of the shape.
    CGPoint p1 = [JBCroppableView convertCGPoint:[[points objectAtIndex:0] CGPointValue] fromRect1:rectSize toRect2:rectSize];
    [LastBezierPath moveToPoint:CGPointMake(p1.x, rectSize.height - p1.y)];
    
    for (uint i=1; i<points.count; i++)
    {
        CGPoint p = [JBCroppableView convertCGPoint:[[points objectAtIndex:i] CGPointValue] fromRect1:rectSize toRect2:rectSize];
        [LastBezierPath addLineToPoint:CGPointMake(p.x, rectSize.height - p.y)];
    }
    
    [LastBezierPath closePath];
    
    isContainView = [LastBezierPath containsPoint:point];
    
    return isContainView;
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    CGPoint locationPoint = [[touches anyObject] locationInView:self];
    
    
    for (UIView *point in self.points)
    {
        CGPoint viewPoint = [point convertPoint:locationPoint fromView:self];

        
        if ([point pointInside:viewPoint withEvent:event])
        {
            
            self.activePoint = point;
            
    
            
            self.activePoint.backgroundColor = [UIColor redColor];
            
            break;
        }
    }
    
    lastPoint = locationPoint;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    CGPoint locationPoint = [[touches anyObject] locationInView:self];
    
    if (!self.activePoint)
    {
        //if in BezierPath,move the view,else don't move
        if (isContainView) {
            for (UIView *point in self.points)
            {
                
                point.frame = CGRectOffset(point.frame, locationPoint.x - lastPoint.x, +locationPoint.y - lastPoint.y);
            }
            [self setNeedsDisplay]; 
        }
    }
    else
    {
        //This is where the points are actually being moved.
        
        self.activePoint.frame = CGRectMake(locationPoint.x -k_POINT_WIDTH/2, locationPoint.y -k_POINT_WIDTH/2, k_POINT_WIDTH, k_POINT_WIDTH);
        
        
        
        [self setNeedsDisplay];
    }
    lastPoint = locationPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [super touchesEnded:touches withEvent:event];
    
    
    self.activePoint.backgroundColor = self.pointColor;
    self.activePoint = nil;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [super touchesCancelled:touches withEvent:event];
    
    self.activePoint.backgroundColor = self.pointColor;
    self.activePoint = nil;
}

@end
