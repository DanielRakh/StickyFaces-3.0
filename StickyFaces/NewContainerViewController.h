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


//The Actual TabButtons in the Container VC that have actions.
@property (nonatomic, strong) TabButton *favoritesTabButton;
@property (nonatomic, strong) TabButton *catalogTabButton;
@property (nonatomic, strong) TabButton *cameraTabButton;


@end
