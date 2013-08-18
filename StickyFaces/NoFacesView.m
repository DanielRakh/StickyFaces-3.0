//
//  NoFacesView.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 8/16/13.
//
//

#import "NoFacesView.h"
#import "UIColor+StickyFacesColors.h"

@implementation NoFacesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    
        UIView *noFacesView = [self createTheNoFacesView];
        
        [self addSubview:noFacesView];
    
    
    }
    return self;
}


-(UIView *)createTheNoFacesView {
    
    UIView *noFacesView = [[UIView alloc]initWithFrame:CGRectMake(0,0,320,419)];
    
    noFacesView.backgroundColor = [UIColor backgroundViewColor];
    
    
    
    
    //Create View for when No Faces are in the CollectionView.
    UIImage *noFaces = [UIImage imageNamed:@"NoFaces.png"];
    UIImageView *noFacesImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, noFaces.size.width, noFaces.size.height)];
    noFacesImageView.image = noFaces;
    
    noFacesImageView.center = CGPointMake(CGRectGetMidX(noFacesView.bounds), CGRectGetMidY(noFacesView.bounds)-60);
    
    [noFacesView addSubview:noFacesImageView];
    
    
    UIImage *addFaceImage = [UIImage imageNamed:@"SmileyCell"];
    self.addFace = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addFace.frame = CGRectMake(0, 0, addFaceImage.size.width, addFaceImage.size.height);
    self.addFace.center = CGPointMake(noFacesView.center.x, noFacesView.center.y + 120);
    [self.addFace setImage:addFaceImage forState:UIControlStateNormal];
    
    [noFacesView addSubview:self.addFace];

    
    
    return noFacesView;
    
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
