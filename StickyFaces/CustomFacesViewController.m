//
//  CustomFacesViewController.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 6/25/13.
//
//

#import "CustomFacesViewController.h"
#import "goBackToCustomFaces.h"
#import "UIColor+StickyFacesColors.h"

@interface CustomFacesViewController ()

@end

@implementation CustomFacesViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cameraViewColor];
    
    
    
    UIImage *camera = [UIImage imageNamed:@"Camera.png"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, camera.size.width, camera.size.height)];
    imageView.image = camera;

    
    imageView.center = CGPointMake(160, 22);
    
    [self.view addSubview:imageView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//UIStoryborad Unwind Segue Methods from ImagePreviewController
- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier {
	
	if ([identifier isEqualToString:@"goBackToCustomFaces"])
        NSLog(@"The identifier is being registerd");
        
        return [[goBackToCustomFaces alloc]initWithIdentifier:identifier source:fromViewController destination:toViewController];
    
        

	return [super segueForUnwindingToViewController:toViewController
								 fromViewController:fromViewController
										 identifier:identifier];
    
}

-(IBAction)goBackToCustomFacesViewController:(UIStoryboardSegue *)segue {
    
 
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    
}

@end
