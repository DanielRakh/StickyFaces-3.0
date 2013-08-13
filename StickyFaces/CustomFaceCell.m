//
//  CustomFaceCell.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 8/7/13.
//
//

#import "CustomFaceCell.h"
#import <QuartzCore/QuartzCore.h>
#import "SpringBoardLayoutAttributes.h"




@implementation CustomFaceCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.clipsToBounds = NO;
        
//        self.backgroundColor = [UIColor orangeColor];
        
        self.faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.faceButton.backgroundColor = [UIColor colorWithRed:0.000 green:0.000 blue:1.000 alpha:0.650];
        self.faceButton.frame =  CGRectMake(0, 0, 113, 150);
//          self.faceButton.frame =  CGRectMake(0, 0, 320, 427);

//        self.faceButton.frame = CGRectMake(0, 0, 95, 110);
        self.faceButton.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        self.faceButton.adjustsImageWhenHighlighted = YES;
        self.faceButton.adjustsImageWhenDisabled = YES;
        self.faceButton.userInteractionEnabled = YES;
        self.faceButton.highlighted = NO;
        self.faceButton.clipsToBounds = NO;
        self.faceButton.showsTouchWhenHighlighted = NO;
   
        
        [self.contentView addSubview:self.faceButton];
        
        
        
        UIImage *deleteButtonImage = [UIImage imageNamed:@"DeleteButton"];
        
        
        self.deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width/60, self.bounds.size.width/60, deleteButtonImage.size.width, deleteButtonImage.size.height)];
        [self.deleteButton setImage:deleteButtonImage forState:UIControlStateNormal];
        
        
        [self.contentView addSubview:self.deleteButton];
        
        
        
    }
    return self;
}



- (void)applyLayoutAttributes:(SpringBoardLayoutAttributes *)layoutAttributes
{
    if (layoutAttributes.isDeleteButtonHidden)
    {
        //        self.deleteButton.layer.opacity = 0.0;
        self.deleteButton.layer.hidden = YES;
        [self stopQuivering];
    }
    else
    {
        //        self.deleteButton.layer.opacity = 1.0;
        self.deleteButton.layer.hidden = NO;
        [self startQuivering];
        
    }
}




-(void)startQuivering
{
    self.faceButton.userInteractionEnabled = NO;
    
    CABasicAnimation *quiverAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    float startAngle = (-3) * M_PI/180.0;
    float stopAngle = -startAngle;
    quiverAnim.fromValue = [NSNumber numberWithFloat:startAngle];
    quiverAnim.toValue = [NSNumber numberWithFloat:3 * stopAngle];
    quiverAnim.autoreverses = YES;
    quiverAnim.duration = 0.2;
    quiverAnim.repeatCount = HUGE_VALF;
    float timeOffset = (float)(arc4random() % 100)/100 - 0.50;
    quiverAnim.timeOffset = timeOffset;
    CALayer *layer = self.layer;
    [layer addAnimation:quiverAnim forKey:@"quivering"];
}


-(void)stopQuivering {
    self.faceButton.userInteractionEnabled = YES;
    
    
    CALayer *layer = self.layer;
    [layer removeAnimationForKey:@"quivering"];
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
