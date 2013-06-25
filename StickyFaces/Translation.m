//
//  Translation.m
//  TranslationTest
//
//  Created by Daniel Rakhamimov on 4/29/13.
//  Copyright (c) 2013 Daniel Rak. All rights reserved.
//

#import "Translation.h"
#import <QuartzCore/QuartzCore.h>
#import "UIBezierPath-Points.h"

@interface Translation ()
{
    /*
    CGPoint zeroPoint;
    
    CGPoint topCurvePoint;
    CGPoint topCurveFirstControlPoint;
    CGPoint topCurveSecondControlPoint;
    
    CGPoint topRightPoint;
    CGPoint topRightControlPoint;
    
    CGPoint midRightPoint;
    CGPoint midRightControlPoint;
    
    CGPoint lowerRightPoint;
    CGPoint lowerRightControlPoint;
    
    
    CGPoint bottomQuadCurvePoint;
    CGPoint bottomQuardCurveControlPoint;
    
    
    CGPoint lowerLeftPoint;
    CGPoint lowerLeftControlPoint;
    
    CGPoint midLeftPoint;
    CGPoint midLeftControlPoint;
    
    CGPoint topLeftPoint;
    CGPoint topLeftControlPoint;
    
    */
    
}

@property (nonatomic, strong) FacePoint *facePoint;
@property (nonatomic) CGPoint midPoint;
@property (nonatomic, strong) NSMutableArray *pointsArray;
@property (nonatomic, strong) NSMutableArray *viewArray;

@end


@implementation Translation


#pragma mark
#pragma mark -  Initializer Methods

-(void)setUp {
    
    self.backgroundColor = [UIColor clearColor];
    
    
    
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
    
    CGPoint zeroPoint = CGPointMake(0, 0);
    
    CGPoint topCurvePoint = CGPointMake(182, 0);
    CGPoint topCurveFirstControlPoint = CGPointMake(30, -90);
    CGPoint topCurveSecondControlPoint = CGPointMake(154, -90);
    
    CGPoint topRightCurvePoint = CGPointMake(180, 60);
    CGPoint topRightCurveFirstControlPoint = CGPointMake(185, 40);
    CGPoint topRightCurveSecondControlPoint = CGPointMake(180, 60);
    
    CGPoint midRightCurvePoint = CGPointMake(176, 118);
    CGPoint midRightCurveFirstControlPoint = CGPointMake(194, 62); 
    CGPoint midRightCurveSecondControlPoint = CGPointMake(176, 118);
    
    CGPoint lowerRightCurvePoint = CGPointMake(154, 178);
    CGPoint lowerRightCurveFirstControlPoint = CGPointMake(173, 148);
    CGPoint lowerRightCurveSecondControlPoint = CGPointMake(154, 178);
    

    
    CGPoint bottomQuadCurvePoint = CGPointMake(28, 178);
    CGPoint bottomQuardCurveFirstControlPoint = CGPointMake(91, 280);
    CGPoint bottomQuardCurveSecondControlPoint = CGPointMake(28, 178);
    
    
    CGPoint lowerLeftPoint = CGPointMake(6, 118);
    CGPoint lowerLeftFirstControlPoint = CGPointMake(9, 148);
    CGPoint lowerLeftSecondControlPoint = CGPointMake(6, 118);

    
    
    CGPoint midLeftPoint = CGPointMake(2, 60);
    CGPoint midLeftFirstControlPoint = CGPointMake(-12, 62);
    CGPoint midLeftSecondControlPoint = CGPointMake(2, 60);
    
    CGPoint topLeftPoint = CGPointMake(0, 0.01);
    CGPoint topLeftFirstControlPoint = CGPointMake(-3, 40);
    CGPoint topLeftSecondControlPoint = CGPointMake(0, 0.01);
    
    /*
     CGPoint topRightPoint = CGPointMake(180, 60);
     CGPoint topRightControlPoint = CGPointMake(185, 40);
     
     CGPoint midRightPoint = CGPointMake(176, 118);
     CGPoint midRightControlPoint = CGPointMake(194, 62);
     
     CGPoint lowerRightPoint = CGPointMake(154, 178);
     CGPoint lowerRightControlPoint = CGPointMake(173, 148);
     
     
     
     
     
     CGPoint lowerLeftPoint = CGPointMake(6, 118);
     CGPoint lowerLeftControlPoint = CGPointMake(9, 148);
     
     
     CGPoint midLeftPoint = CGPointMake(2, 60);
     CGPoint midLeftControlPoint = CGPointMake(-12, 62);
     
     CGPoint topLeftPoint = CGPointMake(0, 0.01);
     CGPoint topLeftControlPoint = CGPointMake(-3, 40);
     
     */
    
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    
    
    [aPath moveToPoint:zeroPoint];
    
    [aPath addCurveToPoint:topCurvePoint controlPoint1:topCurveFirstControlPoint controlPoint2:topCurveSecondControlPoint];
    [aPath addCurveToPoint:topRightCurvePoint controlPoint1:topRightCurveFirstControlPoint controlPoint2:topRightCurveSecondControlPoint];
    [aPath addCurveToPoint:midRightCurvePoint controlPoint1:midRightCurveFirstControlPoint controlPoint2:midRightCurveSecondControlPoint];
    [aPath addCurveToPoint:lowerRightCurvePoint controlPoint1:lowerRightCurveFirstControlPoint controlPoint2:lowerRightCurveSecondControlPoint];

    [aPath addCurveToPoint:bottomQuadCurvePoint controlPoint1:bottomQuardCurveFirstControlPoint controlPoint2:bottomQuardCurveSecondControlPoint];
    
    [aPath addCurveToPoint:lowerLeftPoint controlPoint1:lowerLeftFirstControlPoint controlPoint2:lowerLeftSecondControlPoint];
    [aPath addCurveToPoint:midLeftPoint controlPoint1:midLeftFirstControlPoint controlPoint2:midLeftSecondControlPoint];
    [aPath addCurveToPoint:topLeftPoint controlPoint1:topLeftFirstControlPoint controlPoint2:topLeftSecondControlPoint];
    

    
    
    
    
    
    /*
     [aPath addQuadCurveToPoint:topRightPoint controlPoint:topRightControlPoint];
     [aPath addQuadCurveToPoint:midRightPoint controlPoint:midRightControlPoint];
     [aPath addQuadCurveToPoint:lowerRightPoint controlPoint:lowerRightControlPoint];
     [aPath addQuadCurveToPoint:bottomQuadCurvePoint controlPoint:bottomQuardCurveControlPoint];
     [aPath addQuadCurveToPoint:lowerLeftPoint controlPoint:lowerLeftControlPoint];
     [aPath addQuadCurveToPoint:midLeftPoint controlPoint:midLeftControlPoint];
     [aPath addQuadCurveToPoint:topLeftPoint controlPoint:topLeftControlPoint];
     */
    
    
    
    [aPath closePath];
    
    
    
    
    
    [aPath applyTransform:CGAffineTransformMakeScale(0.9, 0.9)];
    
    
    float yOrigin = CGPathGetBoundingBox(aPath.CGPath).origin.y;
    float xOrigin = CGPathGetBoundingBox(aPath.CGPath).origin.x;
    
    [aPath applyTransform:CGAffineTransformMakeTranslation(-xOrigin, -yOrigin)];
    
    
    
    [aPath applyTransform:CGAffineTransformMakeTranslation(self.bounds.size.width/2.0 -CGPathGetBoundingBox(aPath.CGPath).size.width/2.0, self.bounds.size.height/2.0-CGPathGetBoundingBox(aPath.CGPath).size.height/2.0)];
    
    
    
    
    [aPath applyTransform:CGAffineTransformMakeTranslation(0, 30)];
    
    
    
    
    return aPath;
    
}




- (void)pointForObjectAtIndex {
    
    UIBezierPath *pointPath = [self createFacePath];
    
    NSMutableArray *faceArray = [NSMutableArray arrayWithCapacity:17];

    
    
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
    NSMutableArray *transitionArray = [NSMutableArray arrayWithCapacity:11];
    
    for (NSValue *value in sortArray) {
        
        
        
        self.facePoint = [[FacePoint alloc]initWithFrame:CGRectMake(0, 0, 38, 38)];
        
        self.facePoint.origC = value.CGPointValue;
        
        self.facePoint.center = CGPointMake(self.facePoint.origC.x+self.facePoint.delta.x, self.facePoint.origC.y+self.facePoint.delta.y);
        
        self.facePoint.delegate = self;
        //    self.facePoint.center = self.facePoint.origC;
        
        [transitionArray addObject:self.facePoint];
        
        
        NSUInteger pointNum = [sortArray indexOfObject:value];
        
        switch ((int)pointNum) {
            case 0:
                
                
            case 1:
                
            case 2:
            case 4:
            case 5:
            case 7:
            case 8:
            case 10:
            case 11:
                case 13:
                case 14:
                case 16:
                case 17:
                case 19:
                case 20:
                case 22:
                case 23:
                
                [self addSubview:self.facePoint];
                
                break;
                
            default:
                break;
        }
        
        
    }
    
    self.viewArray = transitionArray;
    
    
}


-(void)repositionPoints {
    
    
    [self pointForObjectAtIndex];
    [self createPointView];
    [self setNeedsDisplay];
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    UIView *zeroPoint = [self.viewArray objectAtIndex:0];
    NSLog(@"Zero Point:%@",NSStringFromCGPoint(zeroPoint.center));
    
    
    UIView *topCurvePoint = [self.viewArray objectAtIndex:3];
    NSLog(@"Top Curve Point:%@", NSStringFromCGPoint(topCurvePoint.center));
    
    UIView *topCurveFirstControlPoint = [self.viewArray objectAtIndex:1];
    NSLog(@"Top Curve First Control Point:%@",NSStringFromCGPoint(topCurveFirstControlPoint.center));
    
    UIView *topCurveSecondControlPoint = [self.viewArray objectAtIndex:2];
    NSLog(@"Top Curve Second Control Point:%@",NSStringFromCGPoint(topCurveSecondControlPoint.center));
        
    
    UIView *topRightCurvePoint = [self.viewArray objectAtIndex:6];
    UIView *topRightCurveFirstControlPoint = [self.viewArray objectAtIndex:4];
    UIView *topRightCurveSecondControlPoint = [self.viewArray objectAtIndex:5];
    
    
    UIView *midRightCurvePoint = [self.viewArray objectAtIndex:9];
    UIView *midRightCurveFirstControlPoint = [self.viewArray objectAtIndex:7];
    UIView *midRightCurveSecondControlPoint = [self.viewArray objectAtIndex:8];
    
    UIView *something;
    
    UIView *lowerRightCurvePoint = [self.viewArray objectAtIndex:12];
    UIView *lowerRightCurveFirstControlPoint = [self.viewArray objectAtIndex:10];
    UIView *lowerRightCurveSecondControlPoint = [self.viewArray objectAtIndex:11];
        
    
    UIView *bottomQuadCurvePoint = [self.viewArray objectAtIndex:15];
    UIView *bottomQuardCurveFirstControlPoint = [self.viewArray objectAtIndex:13];
    UIView *bottomQuardCurveSecondControlPoint = [self.viewArray objectAtIndex:14];

    UIView *lowerLeftCurvePoint = [self.viewArray objectAtIndex:18];
    UIView *lowerLeftCurveFirstControlPoint = [self.viewArray objectAtIndex:16];
    UIView *lowerLeftCurveSecondControlPoint = [self.viewArray objectAtIndex:17];
    
    UIView *midLeftCurvePoint = [self.viewArray objectAtIndex:21];
    UIView *midLeftCurveFirstControlPoint = [self.viewArray objectAtIndex:19];
    UIView *midLeftCurveSecondControlPoint = [self.viewArray objectAtIndex:20];
    
    
    
    UIView *topLeftCurvePoint = [self.viewArray objectAtIndex:24];
    UIView *topLeftCurveFirstControlPoint = [self.viewArray objectAtIndex:22];
    UIView *topLeftCurveSecondControlPoint = [self.viewArray objectAtIndex:23];
    
    
    /*
     UIView *topRightPoint = [self.viewArray objectAtIndex:5];
     UIView *topRightControlPoint = [self.viewArray objectAtIndex:4];
     
     UIView *midRightPoint =[self.viewArray objectAtIndex:7];
     UIView * midRightControlPoint =[self.viewArray objectAtIndex:6];
     
     UIView *lowerRightPoint = [self.viewArray objectAtIndex:9];
     UIView *lowerRightControlPoint = [self.viewArray objectAtIndex:8];
     
     
     UIView *bottomQuadCurvePoint = [self.viewArray objectAtIndex:11];
     UIView *bottomQuardCurveControlPoint = [self.viewArray objectAtIndex:10];
     
     
     UIView *lowerLeftPoint = [self.viewArray objectAtIndex:13];
     UIView *lowerLeftControlPoint = [self.viewArray objectAtIndex:12];
     
     
     UIView *midLeftPoint = [self.viewArray objectAtIndex:15];
     UIView *midLeftControlPoint = [self.viewArray objectAtIndex:14];
     
     UIView *topLeftPoint = [self.viewArray objectAtIndex:17];
     UIView *topLeftControlPoint = [self.viewArray objectAtIndex:16];
     
     */
    
    
    
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    
    aPath.lineWidth = 3.0;
    
    
    [aPath moveToPoint:zeroPoint.center];
    
    
    [aPath addCurveToPoint:topCurvePoint.center controlPoint1:topCurveFirstControlPoint.center controlPoint2:topCurveSecondControlPoint.center];
    [aPath addCurveToPoint:topRightCurvePoint.center controlPoint1:topRightCurveFirstControlPoint.center controlPoint2:topRightCurveSecondControlPoint.center];
    [aPath addCurveToPoint:midRightCurvePoint.center controlPoint1:midRightCurveFirstControlPoint.center controlPoint2:midRightCurveSecondControlPoint.center];
    [aPath addCurveToPoint:lowerRightCurvePoint.center controlPoint1:lowerRightCurveFirstControlPoint.center controlPoint2:lowerRightCurveSecondControlPoint.center];
    
    [aPath addCurveToPoint:bottomQuadCurvePoint.center controlPoint1:bottomQuardCurveFirstControlPoint.center controlPoint2:bottomQuardCurveSecondControlPoint.center];
    
    
    [aPath addCurveToPoint:lowerLeftCurvePoint.center controlPoint1:lowerLeftCurveFirstControlPoint.center controlPoint2:lowerLeftCurveSecondControlPoint.center];
      [aPath addCurveToPoint:midLeftCurvePoint.center controlPoint1:midLeftCurveFirstControlPoint.center controlPoint2:midLeftCurveSecondControlPoint.center];
    [aPath addCurveToPoint:topLeftCurvePoint.center controlPoint1:topLeftCurveFirstControlPoint.center controlPoint2:topLeftCurveSecondControlPoint.center];
    
    
    
    /*
     [aPath addQuadCurveToPoint:topRightPoint.center controlPoint:topRightControlPoint.center];
     [aPath addQuadCurveToPoint:midRightPoint.center controlPoint:midRightControlPoint.center];
     [aPath addQuadCurveToPoint:lowerRightPoint.center controlPoint:lowerRightControlPoint.center];
     [aPath addQuadCurveToPoint:bottomQuadCurvePoint.center controlPoint:bottomQuardCurveControlPoint.center];
     [aPath addQuadCurveToPoint:lowerLeftPoint.center controlPoint:lowerLeftControlPoint.center];
     [aPath addQuadCurveToPoint:midLeftPoint.center controlPoint:midLeftControlPoint.center];
     [aPath addQuadCurveToPoint:topLeftPoint.center controlPoint:topLeftControlPoint.center];
     
     */
     
    [aPath closePath];
     
    
    [aPath stroke];
    
    
    
    CGRect boundingBox = CGPathGetBoundingBox(aPath.CGPath);
    
    UIBezierPath *boundBox = [UIBezierPath bezierPathWithRect:boundingBox];
    boundBox.lineWidth = 3.0f;
    [boundBox stroke];
    
    
    UIBezierPath *bounceBox = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 320, 371)];
    [bounceBox applyTransform:CGAffineTransformMakeTranslation(0, 44)];
    
    [[UIColor orangeColor]setStroke];
    [bounceBox stroke];
    
}
@end
