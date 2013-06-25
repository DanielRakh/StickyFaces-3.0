//
//  goToImageViewSegue.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 6/25/13.
//
//

#import "goToImageViewSegue.h"

@implementation goToImageViewSegue

-(void)perform {
    
    
    UIViewController *source = (UIViewController *)self.sourceViewController;
    UIViewController *destination  = (UIViewController *)self.destinationViewController;
    
    
    [source presentViewController:destination animated:NO completion:nil];
    
    
    
}

@end
