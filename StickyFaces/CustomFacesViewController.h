//
//  CustomFacesViewController.h
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 6/25/13.
//
//

#import <UIKit/UIKit.h>

@class CustomDataModel;

@interface CustomFacesViewController : UIViewController <UIGestureRecognizerDelegate>

@property (weak, nonatomic) CustomDataModel *dataModel;



//Unwind Segue used by ConfirmViewController
-(IBAction)goBackToCustomFacesViewController:(UIStoryboardSegue *)segue;


- (void)activateDeletionMode:(id)sender;


@end
