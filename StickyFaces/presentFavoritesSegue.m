//
//  presentFavoritesSegue.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 7/4/13.
//
//

#import "presentFavoritesSegue.h"
#import "FavoritesViewController.h"
#import "StickyFacesViewController.h"

@implementation presentFavoritesSegue

-(void)perform {
    
    StickyFacesViewController *catalogViewController  = [[(StickyFacesViewController *)self.sourceViewController childViewControllers] objectAtIndex:0];
    FavoritesViewController *favoritesViewController = (FavoritesViewController *)self.destinationViewController;
    
    
    //Transition to swap out the ViewControllers in the container. 
    [catalogViewController.parentViewController transitionFromViewController:catalogViewController toViewController:favoritesViewController duration:0.4 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:^(BOOL finished) {
        [favoritesViewController didMoveToParentViewController:catalogViewController.parentViewController];
        [catalogViewController removeFromParentViewController];
    }];
}

@end
