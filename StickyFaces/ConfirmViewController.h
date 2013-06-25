//
//  ConfirmViewController.h
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 3/8/13.
//
//

#import <UIKit/UIKit.h>

@interface ConfirmViewController : UIViewController


//Unwind Segue for ImagePreviewController to use to go back to Camera View
-(IBAction)goBackToCameraView:(UIStoryboardSegue *)segue;

@end
