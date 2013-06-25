//
//  FacePoint.m
//  TranslationTest
//
//  Created by Daniel Rakhamimov on 5/1/13.
//  Copyright (c) 2013 Daniel Rak. All rights reserved.
//




#import "FacePoint.h"
#import <QuartzCore/QuartzCore.h>


@implementation FacePoint


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
        CGFloat cornerRadius = frame.size.width/2.0f;
        

        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = cornerRadius;
        self.layer.borderWidth = 2.0;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragging:)];
        
        [self addGestureRecognizer:pan];
        
        
    
    }
    return self;
}




-(void)dragging:(UIPanGestureRecognizer *)p {
    
    
    UIView *newView = p.view;
    if (p.state == UIGestureRecognizerStateBegan) {
        self.origC = newView.center;
    }
    self.delta = [p translationInView:newView.superview];
    CGPoint c = self.origC;
    
    c.x +=self.delta.x;
    c.y +=self.delta.y;
    
    newView.center = c;
    
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
