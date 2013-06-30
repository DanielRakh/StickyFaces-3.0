//
//  CameraOverlay.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 6/25/13.
//
//

#import "CameraOverlay.h"

@interface CameraOverlay ()




@end

@implementation CameraOverlay


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage *overlayView = [UIImage imageNamed:@"CameraFrame.png"];
        
        UIImageView *overLayImageView = [[UIImageView alloc]initWithImage:overlayView];
        overLayImageView.userInteractionEnabled = NO;
        [self addSubview:overLayImageView];
        
        
        
    }
    return self;
}




//-(void)perfromCustomSplitAnimationWithTopImageView:(UIImageView *)topImageView andBottomImageView:(UIImageView *)bottomImageView {
//    
//    CGRect originalUpperFrame = topImageView.frame;
//    CGRect originalBottomFrame = bottomImageView.frame;
//    
//    
//    
//    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        topImageView.frame = CGRectMake(0, 0, topImageView.bounds.size.width, topImageView.bounds.size.height);
//        
//        bottomImageView.frame = CGRectMake(0, 212, bottomImageView.bounds.size.width, bottomImageView.bounds.size.height);
//        
//    } completion:^(BOOL finished) {
//        
//        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            topImageView.frame = originalUpperFrame;
//            bottomImageView.frame = originalBottomFrame;
//        } completion:^(BOOL finished) {
//            //
//        }];
//        
//        
//        
//    }];
//    
//    
//    
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
