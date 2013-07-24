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




@interface NewContainerViewController () <UIGestureRecognizerDelegate>
{
    CGPoint leftTabButtonCenter;
    CGPoint rightTabButtonCenter;
    CGPoint iconCenterInNav; 
}




//Identifier Properties
@property (nonatomic, strong) UIViewController *thePresentedViewController; // The mainScreen VC
@property (nonatomic, strong) TabButton *thePresentedTabButton;
@property (nonatomic, strong) UIImageView *thePresentedTabIcon;


@property (nonatomic, strong) TabButton *leftTabButton; //The left Tab Button
@property (nonatomic, strong) TabButton *rightTabButton; //The Right Tab Button
@property (nonatomic, strong) TabButton *centerTabButton;

@property (nonatomic, strong) UIImageView *rightTabIcon;
@property (nonatomic, strong) UIImageView *leftTabIcon; 
@property (nonatomic, strong) UIImageView *centerTabIcon; 



//The Actual TabButtons in the Container VC that have actions. 
@property (nonatomic, strong) TabButton *favoritesTabButton;
@property (nonatomic, strong) TabButton *catalogTabButton;
@property (nonatomic, strong) TabButton *cameraTabButton;




//The Data Model to populate the CollectionViews of the three VC's. 
@property (nonatomic, strong) DataModel *dataModel;


//The Icons for the TabButtons
@property (nonatomic, weak) UIImageView *favoritesIcon;
@property (nonatomic, weak) UIImageView *catalogIcon;
@property (nonatomic, weak) UIImageView *cameraIcon;


//The actual three VC's that will becoome Child View Controllers of the Container.
@property (nonatomic, strong) StickyFacesViewController *catalogViewController;
@property (nonatomic, strong) FavoritesViewController *favoritesViewController;
@property (nonatomic, strong) CustomFacesViewController *cameraViewController;

@end






@implementation NewContainerViewController

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    
    //Set the positions of UI Elements
    iconCenterInNav = CGPointMake(CGRectGetMidX(self.view.bounds), 22);
    leftTabButtonCenter = CGPointMake(CGRectGetMidX(self.view.bounds)-50, CGRectGetMaxY(self.view.bounds)- 40);
    rightTabButtonCenter = CGPointMake(CGRectGetMidX(self.view.bounds)+50, CGRectGetMaxY(self.view.bounds)- 40);
    
    
    //Set the Background Color
    self.view.backgroundColor = [UIColor backgroundViewColor];
    self.containerView.backgroundColor = [UIColor backgroundViewColor];
    
    
    //Set up the Data Model for the ChildViewControllers
    self.dataModel = [[DataModel alloc]init];
    
    
    //Set up the Tab Buttons//
    
    
    //Set up the CatalogTabButton and position it to be a little above the center. 
    self.catalogTabButton = [self createTabButtonWithColor:[UIColor catalogViewColor] andPosition:CGPointMake(self.view.center.x, self.view.center.y - 40)];
    [self.catalogTabButton addTarget:self action:@selector(animateOpenWithTabButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //Set up the FavoritesTabButton and flag it as self.rightTabButton
    self.favoritesTabButton = [self createTabButtonWithColor:[UIColor favoritesViewColor] andPosition:CGPointMake(self.view.center.x +40 , self.view.center.y+40)];
    [self.favoritesTabButton addTarget:self action:@selector(animateOpenWithTabButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //Setting the
        //Set up the CameraTabButton and flag it as self.leftTabButton
    self.cameraTabButton = [self createTabButtonWithColor:[UIColor cameraViewColor] andPosition:CGPointMake(self.view.center.x -40, self.view.center.y+40)];
    [self.cameraTabButton addTarget:self action:@selector(animateOpenWithTabButton:) forControlEvents:UIControlEventTouchUpInside];

    

    
    // Add all Buttons to self.view
    [self.view addSubview:self.catalogTabButton];
    [self.view addSubview:self.favoritesTabButton];
    [self.view addSubview:self.cameraTabButton];
    
    
    //Set up Icons
    self.cameraIcon = [self createTabButtonIconForButton:self.cameraTabButton];
    self.favoritesIcon = [self createTabButtonIconForButton:self.favoritesTabButton];
    self.catalogIcon = [self createTabButtonIconForButton:self.catalogTabButton];
    
 
    
    
    //Add all icons to the self.view
    [self.view addSubview:self.catalogIcon];
    [self.view addSubview:self.cameraIcon];
    [self.view addSubview:self.favoritesIcon];
    
    
    
    self.rightTabButton = self.favoritesTabButton;
    self.leftTabButton = self.cameraTabButton;
    self.centerTabButton = self.catalogTabButton;
    
    self.leftTabIcon = self.cameraIcon;
    self.rightTabIcon = self.favoritesIcon;
    self.centerTabIcon = self.catalogIcon;
    
    
    
    
    
    
    //Instantiate the the three view controllers to be ready to be added as future children. 
    
    self.catalogViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Catalog"];
    self.catalogViewController.dataModel = self.dataModel;
    
    
    
    self.favoritesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Favorites"];
    self.favoritesViewController.dataModel = self.dataModel;
    self.catalogViewController.delegate = self.favoritesViewController;
    
    
    
    self.cameraViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Camera"];
    self.cameraViewController.dataModel = self.dataModel;
    
    
    
    
    //Begin initial animation... 
    [self initialPresentationWithChildViewController:self.catalogViewController andLeftTabView:self.leftTabButton withLeftIcon:self.leftTabIcon andRightTabView:self.rightTabButton withRightIcon:self.rightTabIcon andCenterTabView:self.centerTabButton withCenterIcon:self.centerTabIcon];
    
}





-(void)runSwitchAnimationWithTab:(TabButton *)tabButton andIcon:(UIImageView *)icon forViewController:(UIViewController *)viewController {
    
    

    
    UIView *backgroundSnapshot;

    backgroundSnapshot = [self createSnapshotViewForViewController:viewController isBeingPresented:YES];
    [self.view addSubview:backgroundSnapshot];
    
    
    [self runPresentingAnimationWithTabButton:tabButton andIcon:icon withPushUpView:backgroundSnapshot withCompletionBlock:^{
        
        //Make the previous presented Tab Button the Right Button now
  
        
        if (tabButton == self.leftTabButton) {

        self.leftTabIcon = self.thePresentedTabIcon;
        self.leftTabButton = self.thePresentedTabButton;
            
        } else if (tabButton == self.rightTabButton) {
            
            self.rightTabButton = self.thePresentedTabButton;
            self.rightTabIcon = self.thePresentedTabIcon;
        }
        
        
        [self presentContainedViewController:viewController];
        
        [backgroundSnapshot removeFromSuperview];
        [self.thePresentedTabButton removeFromSuperview];
        [self.thePresentedTabIcon removeFromSuperview];
        
        [self bounceRightTab:self.rightTabButton withRightIcon:self.rightTabIcon andLeftTabButton:self.leftTabButton withLeftIcon:self.leftTabIcon];
        
    }];

    
    
    
}


-(void)collisionAnimationWithActiveTabButton:(TabButton *)tabButton andIcon:(UIImageView *)activeIcon withOtherTab:(TabButton *)otherTabButton andOtherIcon:(UIImageView *)otherIcon fromRightSide:(BOOL)rightSide andCompletionBlock:(void(^)(void))completionBlock {
    
    
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    
        if (rightSide) {
        tabButton.center = CGPointMake(self.thePresentedTabButton.center.x + 35, self.thePresentedTabButton.center.y + 50);

        otherTabButton.center = CGPointMake(CGRectGetMinX(self.view.bounds)-30, CGRectGetMaxY(self.view.bounds)-40);
        }
        if (!rightSide) {
            NSLog(@"not right side");
            tabButton.center = CGPointMake(self.thePresentedTabButton.center.x - 35, self.thePresentedTabButton.center.y + 50);
            
            otherTabButton.center = CGPointMake(CGRectGetMaxX(self.view.bounds)+30, CGRectGetMaxY(self.view.bounds)-40);
        }
       
            otherIcon.center = otherTabButton.center;
            activeIcon.center = tabButton.center;

        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.25 delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            if (rightSide) {
            self.thePresentedTabButton.center = CGPointMake(-50, -50);
                NSLog(@"RightSide is not nil");
                
            }
            else if (!rightSide)
            {
                self.thePresentedTabButton.center  =CGPointMake(360, -360);
                NSLog(@"RightSide is  nil");

            }
            
            
            
            
            self.thePresentedTabIcon.center = self.thePresentedTabButton.center;
            tabButton.center = self.view.center;
            activeIcon.center = tabButton.center;
            
        } completion:^(BOOL finished) {
            completionBlock();
        }];
    }];
}





-(void)animateOpenWithTabButton:(id)sender {
    

// Close current childVC
[self animateCloseOfCurrentChildViewController:self.thePresentedViewController withTabButton:self.thePresentedTabButton andTabIcon:self.thePresentedTabIcon WithCompletionBlock:^{
            
            
            
            
if (sender == self.rightTabButton) {
                
    
            
    [self collisionAnimationWithActiveTabButton:self.rightTabButton andIcon:self.rightTabIcon withOtherTab:self.leftTabButton andOtherIcon:self.leftTabIcon fromRightSide:YES andCompletionBlock:^{
                 
              if (sender == self.favoritesTabButton) {
                  
                  
                  [self runSwitchAnimationWithTab:self.rightTabButton andIcon:self.rightTabIcon forViewController:self.favoritesViewController];

              }
            
             else if (sender == self.catalogTabButton) {
                 
                 [self runSwitchAnimationWithTab:self.rightTabButton andIcon:self.rightTabIcon forViewController:self.catalogViewController];

                 
             } else if (sender == self.cameraTabButton) {
                 
                 [self runSwitchAnimationWithTab:self.rightTabButton andIcon:self.rightTabIcon forViewController:self.cameraViewController];
             }
      
            }];
}
            
else if (sender == self.leftTabButton ) {
    
    
    [self collisionAnimationWithActiveTabButton:self.leftTabButton andIcon:self.leftTabIcon withOtherTab:self.rightTabButton andOtherIcon:self.rightTabIcon fromRightSide:NO andCompletionBlock:^{
        
        if (sender == self.cameraTabButton) {
            
            
            [self runSwitchAnimationWithTab:self.leftTabButton andIcon:self.leftTabIcon forViewController:self.cameraViewController];
            
        }
        
        else if (sender == self.catalogTabButton) {
            
            [self runSwitchAnimationWithTab:self.leftTabButton andIcon:self.leftTabIcon forViewController:self.catalogViewController];
            
            
        }
        else if (sender == self.favoritesTabButton) {
            
            [self runSwitchAnimationWithTab:self.leftTabButton andIcon:self.leftTabIcon forViewController:self.favoritesViewController];
        }
        
    }];
    
    
    
}
            
            
            
        }];
    
}





-(void)initialPresentationWithChildViewController:(UIViewController *)childViewController andLeftTabView:(TabButton *)leftTab withLeftIcon:(UIImageView *)leftIcon andRightTabView:(TabButton *)rightTab withRightIcon:(UIImageView *)rightIcon andCenterTabView:(TabButton *)centerTab withCenterIcon:(UIImageView *)centerIcon {
    
    
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        
        //Push the CameraTab button & icon to the left. 
        
        leftTab.center = CGPointMake(leftTabButtonCenter.x - 150, leftTabButtonCenter.y);
        leftIcon.center = leftTab.center;
        
        //Push the FavoritesTab button & icon to the right. 
        rightTab.center = CGPointMake(rightTabButtonCenter.x + 150, rightTabButtonCenter.y);
        rightIcon.center = rightTab.center;
        
        
    } completion:^(BOOL finished) {
        
        UIView *backgroundSnapshot = [self createSnapshotViewForViewController:childViewController isBeingPresented:YES];
        [self.view addSubview:backgroundSnapshot];
        
        [self runPresentingAnimationWithTabButton:centerTab andIcon:centerIcon withPushUpView:backgroundSnapshot withCompletionBlock:^{
            
            [self presentContainedViewController:childViewController];
            
            [self bounceRightTab:rightTab withRightIcon:rightIcon andLeftTabButton:leftTab withLeftIcon:leftIcon];
        }];

    }];

    
}




#pragma Mark - Helper Animation Methods

-(void)animateCloseOfCurrentChildViewController:(UIViewController *)childViewController withTabButton:(TabButton *)currentTab andTabIcon:(UIImageView *)currentIcon WithCompletionBlock:(void(^)(void))completionBlock {
    
    
    //Take a snapshot of the current ChildView that will be dismissed
    UIView *backgroundSnapshot = [self createSnapshotViewForViewController:childViewController isBeingPresented:NO];
    
    //Bring back the Tab that was removed from the superview on the way in. At this point the Tab is scaled to fill out the screen.
    [self.view addSubview:currentTab];
    
    [self.view addSubview:currentIcon];
    //Add the snapshot on top of the tabButton.
    [self.view addSubview:backgroundSnapshot];
    
    
    //Remove the presented ViewController.
    [self removeThePresentedViewController];
    
    
    
    
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        
        currentIcon.center = self.view.center;
        backgroundSnapshot.frame = CGRectMake(CGRectGetMinX(self.view.bounds), CGRectGetMaxY(self.view.bounds), backgroundSnapshot.bounds.size.width, backgroundSnapshot.bounds.size.height);

        
    } completion:^(BOOL finished) {
        
        [backgroundSnapshot removeFromSuperview];


        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            currentTab.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            
            
            completionBlock();
            
            
        }];
    }];
    

    if(!backgroundSnapshot) {
        NSLog(@"snapshot is gone!");
    }
    
    
}



-(void)runPresentingAnimationWithTabButton:(TabButton *)tabButton andIcon:(UIImageView *)tabIcon withPushUpView:(UIView *)backgroundView withCompletionBlock:(void (^)(void))completionBlock {
    
    
    
    
    [UIView animateWithDuration:0.25f animations:^{
        tabButton.center = self.view.center;
        tabIcon.center = tabButton.center;
    } completion:^(BOOL finished) {
        
        
        
        [UIView animateWithDuration:0.25f animations:^{
            tabButton.transform = CGAffineTransformMakeScale(16.0, 16.0);
        } completion:^(BOOL finished) {
            
            //        [self.view insertSubview:backgroundView belowSubview:tabButton];
            [UIView animateWithDuration:0.6f animations:^{
                backgroundView.frame = CGRectMake(0, 44, backgroundView.bounds.size.width, backgroundView.bounds.size.height);
                tabIcon.center = iconCenterInNav;
                
            } completion:^(BOOL finished) {
                
                [backgroundView removeFromSuperview];
                [tabButton removeFromSuperview];
                [tabIcon removeFromSuperview];
                
                completionBlock();
            }];
            
        }];
    }];
}


-(UIView *)createSnapshotViewForViewController:(UIViewController *)viewController isBeingPresented:(BOOL)isBeingPresented {
    
    
    CALayer *nextLayer = [self _layerSnapshotWithTransform:CATransform3DIdentity fromViewControllerSubview:viewController];
    
    UIView *tmpView;
    
    if (isBeingPresented) {
        
        tmpView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame), CGRectGetMaxY(self.view.frame), self.view.bounds.size.width, self.view.bounds.size.height)];
    }
    else {
        tmpView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height)];
    }
    
    tmpView.backgroundColor = [UIColor backgroundViewColor];
    
    [tmpView.layer addSublayer:nextLayer];
    
    return tmpView;
}



-(void)animateWithBounce:(UIView*)theView
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




-(void)bounceRightTab:(TabButton *)rightTab withRightIcon:(UIImageView *)rightIcon andLeftTabButton:(TabButton *)leftTab withLeftIcon:(UIImageView *)leftIcon
{
    
    CGPoint bottomLeftPosition = CGPointMake(CGRectGetMinX(self.view.bounds), CGRectGetMaxY(self.view.bounds)-40);
    
    CGPoint bottomRightPosition = CGPointMake(CGRectGetMaxX(self.view.bounds), CGRectGetMaxY(self.view.bounds)-40);
    
    
    rightTab.center = bottomRightPosition;
    rightIcon.center = rightTab.center;
    leftTab.center = bottomLeftPosition;
    leftIcon.center = leftTab.center;
    
    [UIView animateWithDuration:0.25 delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        rightTab.center = CGPointMake(CGRectGetMidX(self.view.bounds)+30, CGRectGetMaxY(self.view.bounds)- 40);
        rightIcon.center = rightTab.center;
        
        leftTab.center = CGPointMake(CGRectGetMidX(self.view.bounds)-30, CGRectGetMaxY(self.view.bounds)- 40);
        leftIcon.center = leftTab.center;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            rightTab.center = rightTabButtonCenter;
            rightIcon.center = rightTab.center;
            
            leftTab.center = leftTabButtonCenter;
            leftIcon.center = leftTab.center;
            
            [self animateWithBounce:rightTab];
            [self animateWithBounce:leftTab];
            
            
            
        } completion:^(BOOL finished) {
            
        }];
    }];
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
    
    
    if (containedViewController == self.catalogViewController) {
        self.thePresentedTabButton = self.catalogTabButton;
        self.thePresentedTabIcon = self.catalogIcon;
        
    }
    else if (containedViewController == self.favoritesViewController) {
        self.thePresentedTabButton = self.favoritesTabButton;
        self.thePresentedTabIcon = self.favoritesIcon;
    }
    else if (containedViewController == self.cameraViewController) {
        
        
        self.thePresentedTabButton = self.cameraTabButton;
        self.thePresentedTabIcon = self.cameraIcon;
    }
    
    
    
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

     
     



- (UIImageView *)_layerSnapshotWithTransform:(CATransform3D)transform fromView:(UIView *)originalView;
{
    
    UIView *subView = originalView;
    subView.backgroundColor= [UIColor blackColor];
    
	if (UIGraphicsBeginImageContextWithOptions){
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(subView.bounds.size.width,subView.bounds.size.height), NO, [UIScreen mainScreen].scale);
    }
	else {
//        UIGraphicsBeginImageContext(subView.bounds.size);
    }
	
	[subView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
    UIImageView *snapshotImageView = [[UIImageView alloc]initWithImage:snapshot];
    
    return snapshotImageView;
}
@end