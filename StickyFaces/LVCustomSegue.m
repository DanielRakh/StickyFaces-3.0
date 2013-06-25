//
//  LVCustomSegue.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 2/6/13.
//
//

#import "LVCustomSegue.h"
#import "UIViewController+RECurtainViewController.h"


@implementation LVCustomSegue


-(void)perform {
    
    
    UIViewController *source = self.sourceViewController;
    UIViewController *destination = self.destinationViewController;
    
    
    [source curtainRevealViewController:destination withPresentingViewController:source andTransitionStyle:RECurtainTransitionVertical andIsUnwinding:NO];
}
@end
