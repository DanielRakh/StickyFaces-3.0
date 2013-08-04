//
//  FavoritesViewController.h
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 11/17/12.
//
//

#import <UIKit/UIKit.h>
#import "StickyFacesViewController.h"
#import "SpringboardLayout.h"



@class DataModel;


@interface FavoritesViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate , SpringBoardLayoutDelegate, StickyFacesViewControllerDelegate, UIGestureRecognizerDelegate>
{

}

@property (weak, nonatomic) IBOutlet UICollectionView *trueView;
@property (weak, nonatomic) DataModel *dataModel;


- (void)activateDeletionMode:(id)sender;

@end
