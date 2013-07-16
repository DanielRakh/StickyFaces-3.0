//
//  TabButton.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 7/12/13.
//
//

#import "TabButton.h"
#import "UIColor+StickyFacesColors.h"
#import <QuartzCore/QuartzCore.h>

@implementation TabButton


-(id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    
    return self;
}




-(void)setUp {
    //Draw the white border
    self.layer.cornerRadius = self.bounds.size.width/2;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.borderWidth = 1;
    
    self.layer.shadowRadius = 1;
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowPath  = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) cornerRadius:(self.bounds.size.width/2)].CGPath;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    
    //Draw the inner circle
    self.innerCircle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.layer.bounds.size.width - 8, self.layer.bounds.size.height - 8)];
    self.innerCircle.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    self.innerCircle.userInteractionEnabled = NO;

    self.innerCircle.backgroundColor = [UIColor blackColor];
    self.innerCircle.layer.cornerRadius = self.innerCircle.bounds.size.width/2;
    self.innerCircle.layer.borderColor = [UIColor clearColor].CGColor;
    self.innerCircle.layer.borderWidth = 1;
    
    [self addSubview:self.innerCircle];
    
    self.userInteractionEnabled = YES;
    

}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, [UIColor favoritesViewColor].CGColor);
    CGContextFil
    
}
*/
@end
