//
//  CameraShutterView.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 6/29/13.
//
//

#import "CameraShutterView.h"

@interface CameraShutterView ()
{
 
    
}

@property (nonatomic, strong) UIImageView *upperImageView;
@property (nonatomic, strong) UIImageView *bottomImageView;


@end

@implementation CameraShutterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    [self firstPositionOfCameraShutter];
    }
    return self;
}



-(void)firstPositionOfCameraShutter {
    
    UIImage *upperImage = [UIImage imageNamed:@"UpperShutter.png"];
    self.upperImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, upperImage.size.width, upperImage.size.height)];
    self.upperImageView.image = upperImage;
    [self addSubview:self.upperImageView];
    
    
    UIImage *bottomImage = [UIImage imageNamed:@"BottomShutter.png"];
    self.bottomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 212, bottomImage.size.width, bottomImage.size.height)];
    self.bottomImageView.image = bottomImage;
    [self addSubview:self.bottomImageView];
    
    
 
    
    
}


-(void)performFirstSplitAnimation {
               
        
        [UIView animateWithDuration:0.3 delay:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.upperImageView.frame = CGRectMake(0, 0-self.upperImageView.bounds.size.height, self.upperImageView.bounds.size.width, self.upperImageView.bounds.size.height);
            
            self.bottomImageView.frame = CGRectMake(0, 212+self.upperImageView.bounds.size.height, self.bottomImageView.bounds.size.width, self.bottomImageView.bounds.size.height);
            
        } completion:^(BOOL finished) {
            
       //
            
        }];
        

}

-(void)addCameraShutterViews {
    
    
    UIImage *upperImage = [UIImage imageNamed:@"UpperShutter.png"];
    self.upperImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0-upperImage.size.height, upperImage.size.width, upperImage.size.height)];
    self.upperImageView.image = upperImage;
    [self addSubview:self.upperImageView];
    
    
    UIImage *bottomImage = [UIImage imageNamed:@"BottomShutter.png"];
    self.bottomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 212+bottomImage.size.height, bottomImage.size.width, bottomImage.size.height)];
    self.bottomImageView.image = bottomImage;
    [self addSubview:self.bottomImageView];
    
    
    

}



-(void)performCustomSplitAnimation {
    
    CGRect originalUpperFrame = self.upperImageView.frame;
    CGRect originalBottomFrame = self.bottomImageView.frame;
    
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.upperImageView.frame = CGRectMake(0, 0, self.upperImageView.bounds.size.width, self.upperImageView.bounds.size.height);
        
        self.bottomImageView.frame = CGRectMake(0, 212, self.bottomImageView.bounds.size.width, self.bottomImageView.bounds.size.height);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.upperImageView.frame = originalUpperFrame;
            self.bottomImageView.frame = originalBottomFrame;
        } completion:^(BOOL finished) {
            //
        }];
        
        
        
    }];
    
    
    
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
