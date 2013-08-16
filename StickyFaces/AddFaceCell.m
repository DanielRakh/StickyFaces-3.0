//
//  AddFaceCell.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 8/15/13.
//
//

#import "AddFaceCell.h"
#import "UIColor+StickyFacesColors.h"

@implementation AddFaceCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIImage *smileyCell = [UIImage imageNamed:@"SmileyCell"];
        
        self.clipsToBounds = NO;
                
        self.faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.faceButton.frame =  CGRectMake(0, 0, smileyCell.size.width, smileyCell.size.height);
        [self.faceButton setImage:smileyCell forState:UIControlStateNormal];
      
        self.faceButton.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        self.faceButton.adjustsImageWhenHighlighted = YES;
        self.faceButton.adjustsImageWhenDisabled = YES;
        self.faceButton.userInteractionEnabled = YES;
        self.faceButton.highlighted = NO;
        self.faceButton.clipsToBounds = NO;
        self.faceButton.showsTouchWhenHighlighted = NO;
        
        
        [self.contentView addSubview:self.faceButton];
        
        
        
   

        
        
//        self.backgroundColor = [UIColor backgroundViewColor];
        
//        self.backgroundColor = [UIColor greenColor];
        
    }
    return self;
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
