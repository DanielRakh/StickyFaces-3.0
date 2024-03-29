//
//  FacePoint.m
//  TranslationTest
//
//  Created by Daniel Rakhamimov on 5/1/13.
//  Copyright (c) 2013 Daniel Rak. All rights reserved.
//




#import "FacePoint.h"
#import <QuartzCore/QuartzCore.h>


@interface FacePoint ()


@property (nonatomic) CGPoint origC;
@property (nonatomic) CGPoint delta;
@property (nonatomic) CGPoint origD;
@property (nonatomic) CGPoint origE;
@property (nonatomic) CGPoint origF;


@end

@implementation FacePoint


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
        UIImage *point = [UIImage imageNamed:@"Point"];
        
        CGFloat cornerRadius = frame.size.width/2.0f;
        

        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = cornerRadius;
        self.layer.contents = (__bridge id)(point.CGImage);
        
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragging:)];
        
        
        
        
        [self addGestureRecognizer:pan];
        
        
    }
    return self;
}




-(void)dragging:(UIPanGestureRecognizer *)p

{
    
    
    UIView *newView = p.view;
    
    if (p.state == UIGestureRecognizerStateBegan) {
        self.origC = newView.center;
        self.origD = self.controlPointView.center;
        self.origE = self.secondControlPointView.center;
        self.origF = self.thirdControlPointView.center;
        //Here I point self.origC to the view's actual center.
    }
    self.delta = [p translationInView:newView.superview];
    CGPoint c = self.origC;
    
    c.x +=self.delta.x;
    c.y +=self.delta.y;
    
    // Restrict movement into parent bounds
    float halfx = CGRectGetMidX(self.bounds);
    c.x = MAX(halfx, c.x);
    c.x = MIN(self.superview.bounds.size.width - halfx,
                      c.x);
    
    float halfy = CGRectGetMidY(self.bounds);
    c.y = MAX(halfy, c.y);
    c.y = MIN(self.superview.bounds.size.height - halfy,
                      c.y);
    
    newView.center = c;
    
    
    CGPoint d = self.origD;
    d.x +=self.delta.x;
    d.y +=self.delta.y;
    
    d.x = MAX(halfx, d.x);
    d.x = MIN(self.superview.bounds.size.width - halfx,
              d.x);
    
    d.y = MAX(halfy, d.y);
    d.y = MIN(self.superview.bounds.size.height - halfy,
              d.y);
    
    self.controlPointView.center = d;
    
    
    CGPoint e = self.origE;
    e.x +=self.delta.x;
    e.y +=self.delta.y;
    
    e.x = MAX(halfx, e.x);
    e.x = MIN(self.superview.bounds.size.width - halfx,
              e.x);
    
    e.y = MAX(halfy, e.y);
    e.y = MIN(self.superview.bounds.size.height - halfy,
              e.y);
    
    self.secondControlPointView.center = e;
    
    
    CGPoint f = self.origF;
    f.x +=self.delta.x;
    f.y +=self.delta.y;
    
    f.x = MAX(halfx, f.x);
    f.x = MIN(self.superview.bounds.size.width - halfx,
              f.x);
    
    f.y = MAX(halfy, f.y);
    f.y = MIN(self.superview.bounds.size.height - halfy,
              f.y);
    
    self.thirdControlPointView.center = f;
    
    [self.delegate refreshView];
    
    
    
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
