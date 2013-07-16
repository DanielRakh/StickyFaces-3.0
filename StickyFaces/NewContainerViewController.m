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




//Identifier Properties
@property (nonatomic, strong) UIViewController *thePresentedViewController; // The mainScreen VC
@property (nonatomic, strong) TabButton *leftTabButton; //The left Tab Button
@property (nonatomic, strong) TabButton *rightTabButton; //The Right Tab Button
@property (nonatomic, strong) UIImageView *rightTabIcon;
@property (nonatomic, strong) UIImageView *leftTabIcon; 




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








-(void)animateOpenWithTabButton:(id)sender {
    
    
    CALayer *nextLayer = [self _layerSnapshotWithTransform:CATransform3DIdentity fromViewControllerSubview:self.favoritesViewController];
    
    UIView *nextView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame), CGRectGetMaxY(self.view.frame), self.view.bounds.size.width, self.view.bounds.size.height)];
    
    [nextView.layer addSublayer:nextLayer];
    [self.view addSubview:nextView];
    
    
    if (sender == self.rightTabButton) {
        
        
     [self animateCloseWithCompletionBlock:^(BOOL finished) {
         
         CGPoint rightButtonCenter = self.rightTabButton.center;
         
         
         [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
             
             self.rightTabButton.center = self.containerView.center;
             self.rightTabIcon.center = self.rightTabButton.center;
             
             self.leftTabButton.center = rightButtonCenter;
             self.leftTabIcon.center = self.leftTabButton.center;
             
         } completion:^(BOOL finished) {
             
             [UIView animateWithDuration:0.5 delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
                 self.rightTabButton.transform = CGAffineTransformMakeScale(16.0, 16.0);
             } completion:^(BOOL finished) {
                 [UIView animateWithDuration:0.2 animations:^{
                     
                     self.rightTabIcon.center = CGPointMake(CGRectGetMidX(self.view.bounds), 22);
                     nextView.frame = CGRectMake(0, 44, nextView.bounds.size.width, nextView.bounds.size.height);
                     
                 } completion:^(BOOL finished) {
                     //
                 }];
             }];
         }];
     }];
        
  

        

    
    }
    
    
    
}



-(void)animateCloseWithCompletionBlock:(void(^)(BOOL finished))completionBlock {
    
    
    
    CALayer *currentLayer = [self _layerSnapshotWithTransform:CATransform3DIdentity fromViewControllerSubview:self.catalogViewController];
    UIView *currentView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, CGRectGetWidth(currentLayer.bounds), CGRectGetHeight(currentLayer.bounds))];
    [currentView.layer addSublayer:currentLayer];
    
    
    [self.view addSubview:self.catalogTabButton];


   
    [self.view addSubview:currentView];
    
      self.catalogIcon =  [self createTabButtonIconForButton:self.catalogTabButton];
    self.catalogIcon.center = CGPointMake(CGRectGetMidX(self.view.bounds), 22);
    
    [self.view addSubview:self.catalogIcon];

//    UIView *collectionView = [self.catalogViewController.view.subviews objectAtIndex:0];
//    UIView *pageView = [self.catalogViewController.view.subviews objectAtIndex:1];

    [self removeThePresentedViewController];
    
//    [collectionView removeFromSuperview];
//    [pageView removeFromSuperview];
    
    
    
    
    
//    TabButton *fakeButton = [self createTabButtonWithColor:[UIColor catalogViewColor] andPosition:self.containerView.center];
//    fakeButton.transform = CGAffineTransformMakeScale(16.0, 16.0);
//    UIImageView *gridIcon = [self createTabButtonIconForButton:self.catalogTabButton];
//    gridIcon.center = CGPointMake(CGRectGetMidX(self.view.bounds), 22);
//
//         [self.view addSubview:gridIcon];
//    

    
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.catalogIcon.center = self.containerView.center;
      
        currentView.frame = CGRectMake(CGRectGetMinX(self.view.bounds), CGRectGetMaxY(self.view.bounds), currentView.bounds.size.width, currentView.bounds.size.height);
        
    } completion:^(BOOL finished) {
        [currentView removeFromSuperview];

        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                        
            self.catalogTabButton.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            
            
            completionBlock(finished);

            
        }];
    }];
    
    
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

-(void)initialCenterViewAnimation {
    
    CGPoint oldCenterCamera = self.cameraTabButton.center;
    CGPoint oldCenterFavorites = self.favoritesTabButton.center;
    
    CALayer *nextLayer = [self _layerSnapshotWithTransform:CATransform3DIdentity fromViewControllerSubview:self.catalogViewController];
    
    UIView *tmpView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame), CGRectGetMaxY(self.view.frame), self.view.bounds.size.width, self.view.bounds.size.height)];
    tmpView.backgroundColor = [UIColor backgroundViewColor];
    
    [tmpView.layer addSublayer:nextLayer];
    
    [self.view addSubview:tmpView];
    
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        
        //Push the CameraTab button & icon to the left. 
        
        self.cameraTabButton.center = CGPointMake(oldCenterCamera.x - 150, oldCenterCamera.y);
        self.cameraIcon.center = self.cameraTabButton.center;
        
        //Push the FavoritesTab button & icon to the right. 
        self.favoritesTabButton.center = CGPointMake(oldCenterFavorites.x + 150, oldCenterFavorites.y);
        self.favoritesIcon.center = self.favoritesTabButton.center;
        
        
        //Push the CatalaogTab Button & icon to the center. 
        self.catalogTabButton.center = self.containerView.center;
        self.catalogIcon.center = self.catalogTabButton.center;
        
        
    } completion:^(BOOL finished) {
        
        //Scale the CatalogButtton to fill up screen. 
        [UIView animateWithDuration:0.5f animations:^{
            self.catalogTabButton.transform = CGAffineTransformMakeScale(16.0, 16.0);
        } completion:^(BOOL finished) {
            
            //Push the CatalogIcon up to the center top along with the TmpView created earlier containing the layer of the collectionview of the VC to be presented. 
            [UIView animateWithDuration:0.6f animations:^{
                self.catalogIcon.center = CGPointMake(CGRectGetMidX(self.view.bounds), 22);
                tmpView.frame = CGRectMake(0, 44, tmpView.bounds.size.width, tmpView.bounds.size.height);
            } completion:^(BOOL finished) {
            
                
                //Positon the FavoritesTab button & icon at the bottom right edge of the screen. 
                self.favoritesTabButton.center = CGPointMake(CGRectGetMaxX(self.view.bounds), CGRectGetMaxY(self.view.bounds)-100);
                self.favoritesIcon.center = self.favoritesTabButton.center;
                
                //Position the CameraTab button & icon at the bottom left edge of the screen. 
                self.cameraTabButton.center = CGPointMake(CGRectGetMinX(self.view.bounds), CGRectGetMaxY(self.view.bounds)-100);
                self.cameraIcon.center = self.cameraTabButton.center;

                
                
                [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    self.favoritesTabButton.center = CGPointMake(CGRectGetMidX(self.view.bounds)+30, CGRectGetMaxY(self.view.bounds)- 40);
                    self.favoritesIcon.center = self.favoritesTabButton.center;
                    
                     self.cameraTabButton.center = CGPointMake(CGRectGetMidX(self.view.bounds)-30, CGRectGetMaxY(self.view.bounds)- 40);
                    self.cameraIcon.center = self.cameraTabButton.center;
                    
                } completion:^(BOOL finished) {
                    
                    [tmpView removeFromSuperview];
                    [self.catalogTabButton removeFromSuperview];
                    [self.catalogIcon removeFromSuperview];
                    
                    [self presentContainedViewController:self.catalogViewController];

                    
                    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{

                        self.favoritesTabButton.center = CGPointMake(CGRectGetMidX(self.view.bounds)+50, CGRectGetMaxY(self.view.bounds)- 40);
                        self.favoritesIcon.center = self.favoritesTabButton.center;
                        
                        self.cameraTabButton.center = CGPointMake(CGRectGetMidX(self.view.bounds)-50, CGRectGetMaxY(self.view.bounds)- 40);
                        self.cameraIcon.center = self.cameraTabButton.center;
                        
                        [self animateWithBounce:self.favoritesTabButton];
                        [self animateWithBounce:self.cameraTabButton];
                    

                    } completion:^(BOOL finished) {
                     

       

                       
                            
                    }];
                }];
            
            }];
            
        }];
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    //Set the Background Color
    self.view.backgroundColor = [UIColor redColor];
    self.containerView.backgroundColor = [UIColor backgroundViewColor];
    
    
    //Set up the Data Model for the ChildViewControllers
    self.dataModel = [[DataModel alloc]init];
   
    
    //Set up the Tab Buttons
    self.catalogTabButton = [self createTabButtonWithColor:[UIColor catalogViewColor] andPosition:CGPointMake(self.containerView.center.x, self.containerView.center.y - 40)];
  
    
    
    self.favoritesTabButton = [self createTabButtonWithColor:[UIColor favoritesViewColor] andPosition:CGPointMake(self.containerView.center.x +40 , self.containerView.center.y+40)];
    [self.favoritesTabButton addTarget:self action:@selector(animateOpenWithTabButton:) forControlEvents:UIControlEventTouchUpInside];
    self.rightTabButton = self.favoritesTabButton;
    
    self.cameraTabButton = [self createTabButtonWithColor:[UIColor cameraViewColor] andPosition:CGPointMake(self.containerView.center.x -40, self.containerView.center.y+40)];
    self.leftTabButton = self.cameraTabButton;
   
    [self.view addSubview:self.catalogTabButton];
    [self.view addSubview:self.favoritesTabButton];
    [self.view addSubview:self.cameraTabButton];
    
    
    //Set up Icons
    self.cameraIcon = [self createTabButtonIconForButton:self.cameraTabButton];
    self.favoritesIcon = [self createTabButtonIconForButton:self.favoritesTabButton];
    self.catalogIcon = [self createTabButtonIconForButton:self.catalogTabButton];
    
    self.leftTabIcon = self.cameraIcon;
    self.rightTabIcon = self.favoritesIcon;
    
    [self.view addSubview:self.catalogIcon];
    [self.view addSubview:self.cameraIcon];
    [self.view addSubview:self.favoritesIcon];
    
    

    //Add the initial ChildViewController 
    
    self.catalogViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Catalog"];
   self.catalogViewController.dataModel = self.dataModel;

    self.favoritesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Favorites"];
    self.favoritesViewController.dataModel = self.dataModel;
    
    
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
    
//    CALayer *snapshotLayer = [CALayer layer];
//	snapshotLayer.transform = transform;
//
//    snapshotLayer.anchorPoint = CGPointMake(1.f, 1.f);
//    snapshotLayer.frame = subView.bounds;
//	snapshotLayer.contents = (id)snapshot.CGImage;
    
    return snapshotImageView;
}

@end