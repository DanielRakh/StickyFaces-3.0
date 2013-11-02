//
//  NoFavoritesView.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 8/19/13.
//
//

#import "NoFavoritesView.h"
#import "UIColor+StickyFacesColors.h"

@implementation NoFavoritesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *noFavoritesview = [self createTheNoFavoritesView];
        
        [self addSubview:noFavoritesview];
    }
    return self;
}



-(UIView *)createTheNoFavoritesView {
    
    UIView *noFavoritesView = [[UIView alloc]initWithFrame:CGRectMake(0,0,320,419)];
    
    noFavoritesView.backgroundColor = [UIColor backgroundViewColor];
    
    
    //Create View for when No Faces are in the CollectionView.
    UIImage *noFavorites = [UIImage imageNamed:@"NoFavorites.png"];
    UIImageView *noFavoritesImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, noFavorites.size.width, noFavorites.size.height)];
    noFavoritesImageView.image = noFavorites;
    
    noFavoritesImageView.center = CGPointMake(CGRectGetMidX(noFavoritesView.bounds), CGRectGetMidY(noFavoritesView.bounds));
    
    [noFavoritesView addSubview:noFavoritesImageView];
    
    return noFavoritesView;
    
    
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
