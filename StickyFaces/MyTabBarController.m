//
//  MyTabBarController.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 2/8/13.
//
//

#import "MyTabBarController.h"
#import "MyUnwindSegue.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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


-(IBAction)dismissLastPage:(UIStoryboardSegue *)segue {
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    

    NSLog(@"CALLED!!");
    
}



-(UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier {
    
    if ([identifier isEqualToString:@"myUnwindSegue"]) {

        return [[MyUnwindSegue alloc]initWithIdentifier:identifier source:fromViewController destination:toViewController];
    }
    else {
        
        return [super segueForUnwindingToViewController:toViewController fromViewController:fromViewController identifier:identifier];
    }
    
    
}



@end
