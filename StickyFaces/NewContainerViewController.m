//
//  NewContainerViewController.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 7/6/13.
//
//

#import "NewContainerViewController.h"
#import "DataModel.h"
#import "StickyFacesViewController.h"
#import "FavoritesViewController.h"
#import "CustomFacesViewController.h"
#import <QuartzCore/QuartzCore.h>


static CALayer *currentLayer = nil;
static CALayer *nextLayer = nil;
static NSTimeInterval const kTransitionDuration = 0.0f;



@interface NewContainerViewController () <UIGestureRecognizerDelegate>
{
    BOOL onCameraScreen;
    BOOL onFavoritesScreen;
    
}

@property (nonatomic, strong) FavoritesViewController *favoritesViewController;
@property (nonatomic, strong) StickyFacesViewController *catalogViewController;
@property (nonatomic, strong) CustomFacesViewController *cameraViewController;
@property (nonatomic, strong) UIView *circleButton;
@property (nonatomic, strong) UIImageView *cameraImageView;


@property (nonatomic, strong) DataModel *dataModel;

@end

@implementation NewContainerViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    
    
    //Set the Background Color
//    self.view.backgroundColor = [UIColor colorWithRed:0.945 green:0.961 blue:0.976 alpha:1.000];
    self.view.backgroundColor = [UIColor colorWithRed:0.204 green:0.596 blue:0.859 alpha:1.000];
    
    
    
    
    
    //Set up the Data Model for the ChildViewControllers
    self.dataModel = [[DataModel alloc]init];
    
    
    
    //Refrence the Catalog View Controller to set it's datamodel property.
    self.catalogViewController = (StickyFacesViewController *)[self.childViewControllers objectAtIndex:0];
    self.catalogViewController.dataModel = self.dataModel;
    
    
    //    self.favoritesViewController = [[FavoritesViewController alloc]init];
    
    self.favoritesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Favorites"];
    
    self.favoritesViewController.view.frame = self.catalogViewController.view.frame;
    self.favoritesViewController.dataModel = self.dataModel;
    
    
    self.catalogViewController.delegate = self.favoritesViewController;
    
    
    self.cameraViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Camera"];
    self.cameraViewController.view.frame = self.catalogViewController.view.frame;
    
    
    ///Set the initial presentation of views;
    onCameraScreen = NO;;
    onFavoritesScreen = NO;
    
    
    //Set the little trigger circles at the bottom of the view
    
    self.circleButton = [self createTriggerButton];
    
    self.circleButton.center = CGPointMake(CGRectGetMidX(self.view.bounds)-40, CGRectGetMaxY(self.view.bounds)-40);
    [self.view addSubview:self.circleButton];
    
    //Set the camera icon on the circlebutton
    self.cameraImageView = [self createCameraIcon];
    self.cameraImageView.center = self.circleButton.center;
    [self.view addSubview:self.cameraImageView];

    
}





/*
-(IBAction)performTransitionToFavorites:(id)sender {
    
    
    [self transitionWithDirection:pullViewToTheLeft toChildViewController:self.favoritesViewController];
    onFavoritesScreen = YES;
    onCameraScreen = NO;
    
    
}


-(IBAction)performTransitionToCatalog:(id)sender
{
    
    if (onFavoritesScreen) {
        
        [self transitionWithDirection:pullViewToTheRight toChildViewController:self.catalogViewController];
    }
    else if (onCameraScreen)
    {
        [self transitionWithDirection:pullViewToTheLeft toChildViewController:self.catalogViewController];
    }
    else{
        NSLog(@"There was an error presenting the catalog view controller");
    }
}
 */


-(void)circlePressed {
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.circleButton.center = self.view.center;
        self.cameraImageView.center = self.view.center;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5f delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.circleButton.transform = CGAffineTransformMakeScale(16.0, 16.0);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.cameraImageView.center = CGPointMake(160, 22);
                //                                                self.scrollView.frame = CGRectMake(0, 44, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
            } completion:^(BOOL finished) {
                [self transitionWithDirectiontoChildViewController:self.cameraViewController];
                [self.circleButton removeFromSuperview];
                [self.cameraImageView removeFromSuperview];
            }];
        }];
    }];

    
}


-(void)performTransitionToCamera
{
    
    [self circlePressed];
//    [self transitionWithDirectiontoChildViewController:self.cameraViewController];
    onCameraScreen = YES;
    onFavoritesScreen = NO;
}



-(UIView *)createTriggerButton {
    
    UIView *circleButton = [[UIView alloc]init];
    circleButton.backgroundColor = [UIColor colorWithRed:0.204 green:0.596 blue:0.859 alpha:1.000];
    circleButton.bounds = CGRectMake(0, 0, 50, 50);
    circleButton.layer.borderColor = [UIColor whiteColor].CGColor;
    circleButton.layer.borderWidth = 4.0f;
    circleButton.layer.shadowRadius = 1.0f;
    circleButton.layer.shadowOpacity = 0.4f;
    circleButton.layer.shadowPath  = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 50, 50) cornerRadius:roundf(circleButton.bounds.size.width/2.0f)].CGPath;
    circleButton.layer.shadowOffset = CGSizeMake(0, 0);
    circleButton.layer.shadowColor = [UIColor blackColor].CGColor;
    circleButton.layer.cornerRadius = roundf(circleButton.bounds.size.width/2.0f);
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(performTransitionToCamera)];
    tapGesture.delegate = self;
    [circleButton addGestureRecognizer:tapGesture];
    
    return circleButton;
}
    

-(UIImageView *)createCameraIcon {
    

    
    UIImage *camera = [UIImage imageNamed:@"Camera.png"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, camera.size.width, camera.size.height)];
    imageView.image = camera;    
    return imageView;
    
}

- (void)transitionWithDirectiontoChildViewController:(UIViewController *)childViewController
{
    
    UIViewController *currentVC = [self.childViewControllers objectAtIndex:0];
    
    
    NSLog(@"The number of childviewcontrollers before:%d",self.childViewControllers.count );
    
    [self addChildViewController:childViewController];
    
    UIViewController *nextVC = [self.childViewControllers objectAtIndex:1];
    
    NSLog(@"The number of childviewcontrollers after:%d",self.childViewControllers.count );
    
    // 2
    [self transitionFromViewController:currentVC
                      toViewController:nextVC duration:kTransitionDuration
                               options: UIViewAnimationOptionTransitionNone
                            animations:^{
                                    
                                                            
                                
                            }
                            completion:^(BOOL finished) { // 4
                                [nextVC didMoveToParentViewController:self];
                                NSLog(@"The number of childviewcontrollers after didMoveToParentViewController:%d",self.childViewControllers.count );
                                
                                
                                [currentVC removeFromParentViewController];
                                NSLog(@"The number of childviewcontrollers after removeFromPArentViewController:%d",self.childViewControllers.count );
                                
                            }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"Getting a memory warning");
    
}



#pragma mark Animation Methods


@end