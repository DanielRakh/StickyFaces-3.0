//
//  goBackToCameraView.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 7/1/13.
//
//

#import "goBackToCameraView.h"

@implementation goBackToCameraView

-(void)perform {
    
    
    [self.sourceViewController dismissViewControllerAnimated:NO completion:nil];
}

@end
