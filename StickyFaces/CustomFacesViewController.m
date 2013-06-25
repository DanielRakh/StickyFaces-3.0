//
//  CustomFacesViewController.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 6/25/13.
//
//

#import "CustomFacesViewController.h"

@interface CustomFacesViewController ()

@end

@implementation CustomFacesViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)goBackToCustomFacesViewController:(UIStoryboardSegue *)segue {
    
 
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    
}

@end
