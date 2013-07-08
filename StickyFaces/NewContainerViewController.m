//
//  NewContainerViewController.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 7/6/13.
//
//

#import "StickyFacesAppDelegate.h"
#import "NewContainerViewController.h"
#import "DataModel.h"
#import "StickyFacesViewController.h"
#import "FavoritesViewController.h"
#import "CustomFacesViewController.h"
#import "UIColor+StickyFacesColors.h"

#import <QuartzCore/QuartzCore.h>


static CALayer *currentLayer = nil;
static CALayer *nextLayer = nil;
static NSTimeInterval const kTransitionDuration = 4.0f;
//static UIColor *redColor = [UIColor blackColor];



@interface NewContainerViewController () <UIGestureRecognizerDelegate>
{
    BOOL onCameraScreen;
    BOOL onFavoritesScreen;
    
}

@property (nonatomic, strong) FavoritesViewController *favoritesViewController;
@property (nonatomic, strong) StickyFacesViewController *catalogViewController;
@property (nonatomic, strong) CustomFacesViewController *cameraViewController;

@property (nonatomic, strong) UIView *cameraButton;
@property (nonatomic, strong) UIImageView *cameraIcon;

@property (nonatomic, strong) UIView *favoritesButton;
@property (nonatomic, strong) UIImageView *favoritesIcon;

@property (nonatomic, strong) UIView *catalogButton;
@property (nonatomic, strong) UIImageView *catalogIcon;




@property (nonatomic, strong) DataModel *dataModel;

@end

@implementation NewContainerViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    
    
    //Set the Background Color
    self.view.backgroundColor = [UIColor backgroundViewColor];
    
    
    
    
    
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
    
    
    //Create the Camera Button and Camera Icon
    
    self.cameraButton = [self createTriggerButtonWithColor:[UIColor cameraViewColor]];
    self.cameraButton.center = CGPointMake(CGRectGetMidX(self.view.bounds)-40, CGRectGetMaxY(self.view.bounds)-40);
    self.cameraIcon = [self createIconWithImage:[UIImage imageNamed:@"Camera"]];
    self.cameraIcon.center = self.cameraButton.center;
    [self.view addSubview:self.cameraButton];
    [self.view addSubview:self.cameraIcon];
    


    
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


-(void)animateWithControllerButton:(UIView *)controllerButton andControllerIcon:(UIImageView *)controllerIcon withSubview:(UIView *)subview   {
    
    UIView *tmpView = [[UIView alloc]initWithFrame:subview.frame];
    tmpView.backgroundColor = subview.backgroundColor;
    
    [controllerButton addSubview:tmpView];
    
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        controllerButton.center = self.view.center;
        controllerIcon.center = self.view.center;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5f delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
            controllerButton.transform = CGAffineTransformMakeScale(16.0, 16.0);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
                controllerIcon.center = CGPointMake(160, 22);
                tmpView.frame = CGRectMake(0, 44, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
            } completion:^(BOOL finished) {
                [tmpView removeFromSuperview];
                [controllerButton removeFromSuperview];
                [controllerIcon removeFromSuperview];
            }];
        }];
    }];

    
}


-(void)performTransitionToCamera
{
    
    [self transitionWithDirectiontoChildViewController:self.cameraViewController withTriggerButton:self.cameraButton andControllerIcon:self.cameraIcon];
    onFavoritesScreen = NO;
}



-(UIView *)createTriggerButtonWithColor:(UIColor *)color {
    
    UIView *circleButton = [[UIView alloc]init];
    circleButton.backgroundColor = color;
    circleButton.bounds = CGRectMake(0, 0, 70, 70);
    circleButton.layer.borderColor = [UIColor whiteColor].CGColor;
    circleButton.layer.borderWidth = 4.0f;
    circleButton.layer.shadowRadius = 8.0f;
    circleButton.layer.shadowOpacity = 0.4f;
    circleButton.layer.shadowPath  = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 70, 70) cornerRadius:roundf(circleButton.bounds.size.width/2.0f)].CGPath;
    circleButton.layer.shadowOffset = CGSizeMake(0, 0);
    circleButton.layer.shadowColor = [UIColor blackColor].CGColor;
    circleButton.layer.cornerRadius = roundf(circleButton.bounds.size.width/2.0f);
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(performTransitionToCamera)];
    tapGesture.delegate = self;
    [circleButton addGestureRecognizer:tapGesture];
    
    return circleButton;
}
    

-(UIImageView *)createIconWithImage:(UIImage *)iconImage {
    

    
    UIImage *camera = iconImage;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, camera.size.width, camera.size.height)];
    imageView.image = camera;    
    return imageView;
    
}

- (void)transitionWithDirectiontoChildViewController:(UIViewController *)childViewController withTriggerButton:(UIView *)triggerButton andControllerIcon:(UIImageView *)controllerIcon
{
    
    UIViewController *currentVC = [self.childViewControllers objectAtIndex:0];
    
    
    NSLog(@"The number of childviewcontrollers before:%d",self.childViewControllers.count );
    
    [self addChildViewController:childViewController];
    
    UIViewController *nextVC = [self.childViewControllers objectAtIndex:1];
//    [currentVC willMoveToParentViewController:nil];
    
    NSLog(@"The number of childviewcontrollers after:%d",self.childViewControllers.count );

//    UIView *subviewToPushUp = [nextVC.view.subviews objectAtIndex:0];
    
    nextLayer = [self _layerSnapshotWithTransform:CATransform3DIdentity fromViewControllerSubview:nextVC];
    
    UIView *tmpView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.view.bounds), CGRectGetMaxY(self.view.bounds), nextLayer.bounds.size.width, nextLayer.bounds.size.height)];
    [tmpView.layer addSublayer:nextLayer];
    
    [self.view addSubview:tmpView];
    
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        triggerButton.center = self.view.center;
        controllerIcon.center = self.view.center;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5f delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
            triggerButton.transform = CGAffineTransformMakeScale(16.0, 16.0);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
                controllerIcon.center = CGPointMake(160, 22);
                tmpView.frame = CGRectMake(0, 44, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
            } completion:^(BOOL finished) {
                
                
                [self transitionFromViewController:currentVC
                                  toViewController:nextVC duration:0
                                           options:UIViewAnimationOptionTransitionNone
                                        animations:^{
                                            
                                        }
                                        completion:^(BOOL finished) { // 4
                                            
                                            [tmpView removeFromSuperview];
                                            [triggerButton removeFromSuperview];
                                            [controllerIcon removeFromSuperview];
                                            
                                            [nextVC didMoveToParentViewController:self];
                                            NSLog(@"The number of childviewcontrollers after didMoveToParentViewController:%d",self.childViewControllers.count );
                                            
                                            
                                            [currentVC removeFromParentViewController];
                                            NSLog(@"The number of childviewcontrollers after removeFromPArentViewController:%d",self.childViewControllers.count );
                                            
                                        }];
                
                
            }];
        }];
    }];
    

    
    // 2
  
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"Getting a memory warning");
    
}



#pragma mark Animation Methods

- (CALayer *)_layerSnapshotWithTransform:(CATransform3D)transform fromViewController:(UIViewController *)viewController;
{
	if (UIGraphicsBeginImageContextWithOptions){
        UIGraphicsBeginImageContextWithOptions(viewController.view.bounds.size, NO, [UIScreen mainScreen].scale);
    }
	else {
        UIGraphicsBeginImageContext(viewController.view.bounds.size);
    }
	
	[viewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
    CALayer *snapshotLayer = [CALayer layer];
	snapshotLayer.transform = transform;
    snapshotLayer.anchorPoint = CGPointMake(1.f, 1.f);
    snapshotLayer.frame = viewController.view.bounds;
	snapshotLayer.contents = (id)snapshot.CGImage;
    return snapshotLayer;
}


- (CALayer *)_layerSnapshotWithTransform:(CATransform3D)transform fromViewControllerSubview:(UIViewController *)viewController;
{
    
    UIView *subView = [viewController.view.subviews objectAtIndex:0];
    
    
	if (UIGraphicsBeginImageContextWithOptions){
        UIGraphicsBeginImageContextWithOptions(subView.bounds.size, NO, [UIScreen mainScreen].scale);
    }
	else {
        UIGraphicsBeginImageContext(subView.bounds.size);
    }
	
	[subView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
    CALayer *snapshotLayer = [CALayer layer];
	snapshotLayer.transform = transform;
    snapshotLayer.anchorPoint = CGPointMake(1.f, 1.f);
    snapshotLayer.frame = subView.bounds;
	snapshotLayer.contents = (id)snapshot.CGImage;
    return snapshotLayer;
}

@end