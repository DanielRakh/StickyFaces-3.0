/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 6.x Edition
 BSD License, Use at your own risk
 */

#import <Foundation/Foundation.h>

@interface UIBezierPath (Points)
@property (nonatomic, readonly) NSArray *points;
@property (nonatomic, readonly) NSArray *bezierElements;
@property (nonatomic, readonly) CGFloat length;

- (NSArray *) pointPercentArray;
- (CGPoint) pointAtPercent: (CGFloat) percent withSlope: (CGPoint *) slope;
+ (UIBezierPath *) pathWithPoints: (NSArray *) points;
+ (UIBezierPath *) pathWithElements: (NSArray *) elements;


-(CGPoint)findQuadBezierPathPointInBetweenTheStartPoint:(CGPoint)startPoint theEndPoint:(CGPoint)endPoint withControlPoint:(CGPoint)controlPoint atPercentage:(CGFloat)percentage;


-(CGPoint)findCurveBezierPathPointInBetweenTheStartPoint:(CGPoint)startPoint theEndPoint:(CGPoint)endPoint withFirstControlPoint:(CGPoint)firstControlPoint andSecondControlPoint:(CGPoint)secondControlPoint atPercentage:(CGFloat)percentage;



@end
