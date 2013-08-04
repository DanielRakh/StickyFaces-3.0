//
//  FlashCheckView.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 8/4/13.
//
//

#import "FlashCheckView.h"


@interface FlashCheckView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation FlashCheckView

- (id)initWithFrame:(CGRect)frame
{
    
    return [self initWithFrame:frame andStyle:kDefaultStyle];
}


-(id)initWithFrame:(CGRect)frame andStyle:(MyStyleEnum)myStyleEnum {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _imageView = [[UIImageView alloc]initWithFrame:frame];
        
        [self setStyle:myStyleEnum];
        
        [self addSubview:_imageView];
    }
    
    return self;
    
}


-(void)setStyle:(MyStyleEnum)myStyleEnum {
    
    if (myStyleEnum == kDefaultStyle ) {
        _imageView.image = nil;
    }
    
    else if (myStyleEnum == kConfirmedToPaste) {
        UIImage *readyToPaste = [UIImage imageNamed:@"PasteFlash"];
        _imageView.image = readyToPaste;
    }
    else if (myStyleEnum == kFavorites) {
    
    UIImage *favoriteFlash = [UIImage imageNamed:@"FavoriteFlash"];
    _imageView.image = favoriteFlash;
}
    
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
