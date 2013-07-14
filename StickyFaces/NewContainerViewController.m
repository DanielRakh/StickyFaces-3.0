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
#import "UIView+EasingFunctions.h"
#import "easing.h"

#import <QuartzCore/QuartzCore.h>


#define BUTTON_SIZE CGRectMake(0,0,60,60)

//static CALayer *currentLayer = nil;
//static CALayer *nextLayer = nil;
static NSTimeInterval const kTransitionDuration = 4.0f;
//static UIColor *redColor = [UIColor blackColor];



@interface NewContainerViewController () <UIGestureRecognizerDelegate>


@property (nonatomic, strong) UIViewController *thePresentedViewController;
@property (nonatomic, strong) TabButton *favoritesTabButton;
@property (nonatomic, strong) TabButton *catalogTabButton;
@property (nonatomic, strong) TabButton *cameraTabButton; 

@property (nonatomic, strong) DataModel *dataModel;

@property (nonatomic, weak) UIImageView *favoritesIcon;
@property (nonatomic, weak) UIImageView *catalogIcon;
@property (nonatomic, weak) UIImageView *cameraIcon;


@property (nonatomic, strong) StickyFacesViewController *catalogViewController;
@property (nonatomic, strong) FavoritesViewController *favoritesViewController;
@property (nonatomic, strong) CustomFacesViewController *cameraViewController;

@end

@implementation NewContainerViewController








-(void)animateTabButton:(TabButton *)tabButton withIcon:(UIImageView *)icon {
    
    
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        tabButton.center = self.view.center;
        icon.center = self.view.center;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5f delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            tabButton.transform = CGAffineTransformMakeScale(16.0, 16.0);
            
        } completion:^(BOOL finished) {
            
            [tabButton removeFromSuperview];

            [icon removeFromSuperview];
                        
            
//            TabButton *leftTabButton  = [[TabButton alloc]initWithFrame:CGRectMake(55, 458, 60, 60)];
//            [self.view addSubview:leftTabButton];
            
            
//            [UIView animateWithDuration:.5f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
//                tmpView.frame = CGRectMake(0, 44, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
//                controllerIcon.center = CGPointMake(160, 22);
//                
//            } completion:^(BOOL finished) {
//                //
//            }];

        }];
   
    }];
    
}


-(void)addSubviewWithBounce:(UIView*)theView
{
//    theView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        theView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            theView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                theView.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}

-(void)initialCenterViewAnimation {
    
    CGPoint oldCenterCamera = self.cameraTabButton.center;
    CGPoint oldCenterFavorites = self.favoritesTabButton.center;
    
    CALayer *nextLayer = [self _layerSnapshotWithTransform:CATransform3DIdentity fromViewControllerSubview:self.catalogViewController];
    
    UIView *tmpView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame), CGRectGetMaxY(self.view.frame), self.view.bounds.size.width, self.view.bounds.size.height)];
    tmpView.backgroundColor = [UIColor backgroundViewColor];
    
    [tmpView.layer addSublayer:nextLayer];
    
    [self.view addSubview:tmpView];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.cameraTabButton.center = CGPointMake(oldCenterCamera.x - 150, oldCenterCamera.y);
        self.cameraIcon.center = self.cameraTabButton.center;
        
        
        self.favoritesTabButton.center = CGPointMake(oldCenterFavorites.x + 150, oldCenterFavorites.y);
        self.favoritesIcon.center = self.favoritesTabButton.center;
        
        self.catalogTabButton.center = self.containerView.center;
        self.catalogIcon.center = self.catalogTabButton.center;
        
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5f animations:^{
            self.catalogTabButton.transform = CGAffineTransformMakeScale(16.0, 16.0);
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.4f animations:^{
                self.catalogIcon.center = CGPointMake(CGRectGetMidX(self.view.bounds), 22);
                tmpView.frame = CGRectMake(0, 44, tmpView.bounds.size.width, tmpView.bounds.size.height);
            } completion:^(BOOL finished) {
            
//                [self presentContainedViewController:self.catalogViewController];
                
                self.favoritesTabButton.center = CGPointMake(CGRectGetMaxX(self.view.bounds), CGRectGetMaxY(self.view.bounds)-100);
                
                
                self.cameraTabButton.center = CGPointMake(CGRectGetMinX(self.view.bounds), CGRectGetMaxY(self.view.bounds)-100);
                [tmpView addSubview:self.favoritesTabButton];
                [tmpView addSubview:self.cameraTabButton];
                
                
                [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    self.favoritesTabButton.center = CGPointMake(CGRectGetMidX(self.view.bounds)+30, CGRectGetMaxY(self.view.bounds)- 80);
                     self.cameraTabButton.center = CGPointMake(CGRectGetMidX(self.view.bounds)-30, CGRectGetMaxY(self.view.bounds)- 80);
                    
                } completion:^(BOOL finished) {
                    
                    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        
                        self.favoritesTabButton.center = CGPointMake(CGRectGetMidX(self.view.bounds)+50, CGRectGetMaxY(self.view.bounds)- 80);
                        self.cameraTabButton.center = CGPointMake(CGRectGetMidX(self.view.bounds)-50, CGRectGetMaxY(self.view.bounds)- 80);
                        
                      
                    

                    } completion:^(BOOL finished) {
                        [self addSubviewWithBounce:self.favoritesTabButton];
                        [self addSubviewWithBounce:self.cameraTabButton];
                        
//                        
                    }];
                }];
            
//                [self addSubviewWithBounce:self.favoritesTabButton];
            }];
            
        }];
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    //Set the Background Color
    self.view.backgroundColor = [UIColor backgroundViewColor];
    self.containerView.backgroundColor = [UIColor backgroundViewColor];
    
    
    //Set up the Data Model for the ChildViewControllers
    self.dataModel = [[DataModel alloc]init];
   
    
    //Set up the Tab Buttons
    self.catalogTabButton = [self createTabButtonWithColor:[UIColor catalogViewColor] andPosition:CGPointMake(self.containerView.center.x, self.containerView.center.y - 40)];
    self.favoritesTabButton = [self createTabButtonWithColor:[UIColor favoritesViewColor] andPosition:CGPointMake(self.containerView.center.x +40 , self.containerView.center.y+40)];
    self.cameraTabButton = [self createTabButtonWithColor:[UIColor cameraViewColor] andPosition:CGPointMake(self.containerView.center.x -40, self.containerView.center.y+40)];
   
    [self.containerView addSubview:self.catalogTabButton];
    [self.containerView addSubview:self.favoritesTabButton];
    [self.containerView addSubview:self.cameraTabButton];
    
    
    //Set up Icons
    self.cameraIcon = [self createTabButtonIconForButton:self.cameraTabButton];
    self.favoritesIcon = [self createTabButtonIconForButton:self.favoritesTabButton];
    self.catalogIcon = [self createTabButtonIconForButton:self.catalogTabButton];
    
    [self.containerView addSubview:self.catalogIcon];
    [self.containerView addSubview:self.cameraIcon];
    [self.containerView addSubview:self.favoritesIcon];
    
    

    //Add the initial ChildViewController 
    
    self.catalogViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Catalog"];
   self.catalogViewController.dataModel = self.dataModel;

    
    
    [self initialCenterViewAnimation];
    
    
    
    
    
//    [self presentContainedViewController:self.catalogViewController];
//    
//    
//  
//    self.cameraViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Camera"];
//    
//    self.favoritesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Favorites"];
//    self.favoritesViewController.dataModel = self.dataModel;
//    
////    self.catalogViewController.delegate = self.favoritesViewController;
//    
//    
//    
// 
//    
//    //Color the left tabButton with CameraView Color
//    self.leftTabButton.innerCircle.backgroundColor = [UIColor cameraViewColor];
//    
//    self.cameraIcon = [self returnIconForViewController:self.cameraViewController];
//    self.cameraIcon.center = self.leftTabButton.center;
//    [self.view addSubview:self.cameraIcon];
//    
//    
//    //Color the right tabButton with FavoritesView Color
//    self.rightTabButton.innerCircle.backgroundColor = [UIColor favoritesViewColor];
//    
//    self.favoritesIcon = [self returnIconForViewController:self.favoritesViewController];
//    self.favoritesIcon.center = self.rightTabButton.center;
//    
//    [self.view addSubview:self.favoritesIcon];
    
    
    

    
}








#pragma mark -  TabButton Methods


-(TabButton *)createTabButtonWithColor:(UIColor *)color andPosition:(CGPoint)center {
    
    TabButton *tabbutton = [[TabButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    tabbutton.center = center;
    tabbutton.innerCircle.backgroundColor = color;
    
    return tabbutton;
}

-(UIImageView *)createTabButtonIconForButton:(TabButton *)tabButton {
    
    UIImageView *tmpImageView = [[UIImageView alloc]init];
    UIImage *icon;
    
    if (tabButton == self.favoritesTabButton) {
        icon = [UIImage imageNamed:@"Heart"];
        
    }
    
    else if (tabButton == self.cameraTabButton) {
        icon = [UIImage imageNamed:@"Camera"];
        
    }
    
    else if (tabButton == self.catalogTabButton) {
        icon = [UIImage imageNamed:@"Grid"];
        
    }
    
    tmpImageView.frame = CGRectMake(0, 0, icon.size.width, icon.size.height);
    
    tmpImageView.image = icon;
    
    tmpImageView.center = tabButton.center;
    
    return tmpImageView;
    
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"Getting a memory warning");
    
}

#pragma mark - Container Methods


-(CGRect)returnContainedViewFrameSize {
    
    CGRect containedRect = self.containerView.bounds;
    return containedRect;
}

- (void)presentContainedViewController:(UIViewController*)containedViewController{
    
    //0. Remove the current Detail View Controller showed
    if(self.thePresentedViewController){
        [self removeThePresentedViewController];
    }
    
    //1. Add the detail controller as child of the container
    [self addChildViewController:containedViewController];
    
    //2. Define the detail controller's view size
    
    //iPhone 5
    containedViewController.view.frame = [self returnContainedViewFrameSize];
    
    //3. Add the contained controller's view to the self's subview containerView and save a reference to the Contained View Controller
    [self.containerView addSubview:containedViewController.view];
    self.thePresentedViewController = containedViewController;
    
    //4. Complete the add flow calling the function didMoveToParentViewController
    [containedViewController didMoveToParentViewController:self];
    
}



-(void)removeThePresentedViewController {
    
    //1. Call the willMoveToParentViewController with nil
    //   This is the last method where your detailViewController can perform some operations before neing removed
    [self.thePresentedViewController willMoveToParentViewController:nil];
    
    //2. Remove the DetailViewController's view from the Container
    [self.thePresentedViewController.view removeFromSuperview];
    
    //3. Update the hierarchy"
    //   Automatically the method didMoveToParentViewController: will be called on the detailViewController)
    [self.thePresentedViewController removeFromParentViewController];
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