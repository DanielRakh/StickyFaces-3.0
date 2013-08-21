//
//  FavoritesViewController.h
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 11/17/12.
//
//

#import <UIKit/UIKit.h>
#import "StickyFacesViewController.h"


@class DataModel;


@interface FavoritesViewController : UIViewController <StickyFacesViewControllerDelegate, UIGestureRecognizerDelegate>


@property (strong, nonatomic)  UICollectionView *trueView;
@property (weak, nonatomic) DataModel *dataModel;


- (void)activateDeletionMode:(id)sender;


@end
