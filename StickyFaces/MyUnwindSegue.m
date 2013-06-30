//
//  MyUnwindSegue.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 2/7/13.
//
//

#import "MyUnwindSegue.h"
#import "UIViewController+RECurtainViewController.h"

@implementation MyUnwindSegue





-(void)perform {
    
    NSLog(@"unwind segue test");


    
    
    UIViewController *source = self.sourceViewController;
    UIViewController *destination = self.destinationViewController;
    
    
    
    [source curtainRevealViewController:destination withPresentingViewController:source andTransitionStyle:RECurtainTransitionVertical andIsUnwinding:YES];
    


}

@end
