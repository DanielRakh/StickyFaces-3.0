//
//  SpringboardLayout.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 12/7/12.
//
//

#import "SpringboardLayout.h"
#import "UIDevice+Resolutions.h"

@implementation SpringboardLayout

- (id)init {
    
    if (self = [super init]) {
        
        [self setup];
        
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    
    return self;
}

-(void)setup {
 
    if ([UIDevice deviceType] & iPhone5) {
        
//        self.itemSize = CGSizeMake(95, 106.66);
//       
//        
//        if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
//            self.minimumLineSpacing = 12.0;
//
//        self.sectionInset = UIEdgeInsetsMake(0, 4, 3, 0);
//        } else if (self.scrollDirection == UICollectionViewScrollDirectionVertical)
//        {
//            self.minimumLineSpacing = 8.0;
//
//            self.sectionInset = UIEdgeInsetsMake(0, 4, 0, 4);
//        }
        
        
        self.itemSize = CGSizeMake(103, 117.33);
        self.minimumLineSpacing = 4.0;
        self.minimumInteritemSpacing = 0;
        
        
        if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
            self.sectionInset = UIEdgeInsetsMake(5, 3, 40, 0);

        } else if (self.scrollDirection == UICollectionViewScrollDirectionVertical)
        {
            self.sectionInset = UIEdgeInsetsMake(5, 3, 5, 0);
        
        }
        
        NSLog(@"iPhone 5 Layout Setup");
    } else {
        
        self.itemSize = CGSizeMake(103, 117.33);
        self.minimumLineSpacing = 4.0;
        
        if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        } else if (self.scrollDirection == UICollectionViewScrollDirectionVertical)
        {
            self.sectionInset = UIEdgeInsetsMake(3, 3, 0, 0);
        }


      NSLog(@"iPhone 4 layout is setup");
    }
}



- (BOOL)isDeletionModeOn
{
    if ([[self.collectionView.delegate class] conformsToProtocol:@protocol(SpringBoardLayoutDelegate)]) {
        
        return [(id)self.collectionView.delegate isDeletionModeActiveForCollectionView:(UICollectionView *)self.collectionView layout:(UICollectionViewFlowLayout *)self];
        
    }
    return NO;
    
}


+ (Class)layoutAttributesClass
{
    return [SpringBoardLayoutAttributes class];
}


- (SpringBoardLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SpringBoardLayoutAttributes *attributes = (SpringBoardLayoutAttributes *)[super layoutAttributesForItemAtIndexPath:indexPath];
    if ([self isDeletionModeOn])
        attributes.deleteButtonHidden = NO;
    else
        attributes.deleteButtonHidden = YES;
    return attributes;
}



- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributesArrayInRect = [super layoutAttributesForElementsInRect:rect];
    
    for (SpringBoardLayoutAttributes *attribs in attributesArrayInRect)
    {
        if ([self isDeletionModeOn]) attribs.deleteButtonHidden = NO;
        else attribs.deleteButtonHidden = YES;
    }
    return attributesArrayInRect;
}



@end
