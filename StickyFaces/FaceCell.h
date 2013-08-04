//
//  FaceCell.h
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 10/11/12.
//
//

#import <UIKit/UIKit.h>


@interface FaceCell : UICollectionViewCell <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIButton *faceButton;
@property (nonatomic, strong) UIButton *deleteButton;


@end
