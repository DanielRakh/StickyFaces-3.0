//
//  CustomFacesViewController.h
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 6/25/13.
//
//

#import <UIKit/UIKit.h>
#import "SpringboardLayout.h"

@class CustomDataModel;

@interface CustomFacesViewController : UIViewController <UIGestureRecognizerDelegate, SpringBoardLayoutDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *facesCollectionView;
@property (weak, nonatomic) CustomDataModel *dataModel;



//Unwind Segue used by ConfirmViewController
-(IBAction)goBackToCustomFacesViewController:(UIStoryboardSegue *)segue;

@end
