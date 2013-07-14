//
//  NewContainerViewController.h
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 7/6/13.
//
//

#import <UIKit/UIKit.h>
#import "TabButton.h"

@interface NewContainerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *containerView;


- (IBAction)addContainedController:(id)sender;
-(IBAction)animateTest:(id)sender;
@end
