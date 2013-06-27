//
//  CameraOverlay.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 6/25/13.
//
//

#import "CameraOverlay.h"

@implementation CameraOverlay

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIImage *overlayView = [UIImage imageNamed:@"CameraFrame.png"];
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:overlayView];
        imageView.userInteractionEnabled = YES;
        
        [self addSubview:imageView];
        
        
        
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
