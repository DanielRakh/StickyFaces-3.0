//
//  CustomFacesViewController.h
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 6/25/13.
//
//

#import <UIKit/UIKit.h>
#import "DataModel.h"
#import "SpringboardLayout.h"
@interface CustomFacesViewController : UIViewController <UIGestureRecognizerDelegate>

@property (weak, nonatomic) DataModel *dataModel;


//Unwind Segue used by ConfirmViewController
-(IBAction)goBackToCustomFacesViewController:(UIStoryboardSegue *)segue;

@end
