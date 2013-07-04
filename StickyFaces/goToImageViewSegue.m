//
//  goToImageViewSegue.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 6/25/13.
//
//

#import "goToImageViewSegue.h"
#import "CameraShutterView.h"
#import <QuartzCore/QuartzCore.h>

@implementation goToImageViewSegue

-(void)perform {
    
    
    UIViewController *source = (UIViewController *)self.sourceViewController;
    UIViewController *destination  = (UIViewController *)self.destinationViewController;
    
//    CameraShutterView *shutterView = source.view.subviews[2];

    
    CATransition* transition = [CATransition animation];
    transition.startProgress = 0;
    transition.endProgress = 1.0;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    transition.duration = 1.0;

    

    
    
    
    [source presentViewController:destination animated:NO completion:nil];
    
}

@end
