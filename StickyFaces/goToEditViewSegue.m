//
//  goToEditViewSegue.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 7/23/13.
//
//

#import "goToEditViewSegue.h"

@implementation goToEditViewSegue


-(void)perform {
    
    UIViewController *source = (UIViewController *)self.sourceViewController;
    UIViewController *destination  = (UIViewController *)self.destinationViewController;
    
    
    [source presentViewController:destination animated:NO completion:nil];

}

@end
