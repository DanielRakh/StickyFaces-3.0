//
//  SpringboardLayout.h
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 12/7/12.
//
//

#import <UIKit/UIKit.h>
#import "SpringBoardLayoutAttributes.h"

@protocol SpringBoardLayoutDelegate <UICollectionViewDelegateFlowLayout>

@required

- (BOOL)isDeletionModeActiveForCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout;


@end

@interface SpringboardLayout : UICollectionViewFlowLayout

@end
