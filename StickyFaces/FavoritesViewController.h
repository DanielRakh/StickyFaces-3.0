//
//  FavoritesViewController.h
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 11/17/12.
//
//

#import <UIKit/UIKit.h>
#import "StickyFacesViewController.h"
#import "DataModel.h"
#import "SpringboardLayout.h"


@interface FavoritesViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate , SpringBoardLayoutDelegate, StickyFacesViewControllerDelegate, UIGestureRecognizerDelegate>
{

}

@property (weak, nonatomic) IBOutlet UICollectionView *trueView;
@property (weak, nonatomic) DataModel *dataModel;


- (void)activateDeletionMode:(id)sender;

@end
