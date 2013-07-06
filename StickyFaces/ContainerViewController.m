//
//  ContainerViewController.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 7/3/13.
//
//

#import "ContainerViewController.h"
#import "DataModel.h"
#import "StickyFacesViewController.h"
#import "FavoritesViewController.h"
#import "CustomFacesViewController.h"
#import <QuartzCore/QuartzCore.h>


static CALayer *currentLayer = nil;
static CALayer *nextLayer = nil;
static NSTimeInterval const kTransitionDuration = 0.3f;


@interface ContainerViewController ()
{
    BOOL catalogShown;
    BOOL favoritesShown;
    BOOL cameraShown;
}

@property (nonatomic, strong) FavoritesViewController *favoritesViewController;
@property (nonatomic, strong) StickyFacesViewController *catalogViewController;
@property (nonatomic, strong) CustomFacesViewController *cameraViewController;


@property (nonatomic, strong) DataModel *dataModel; 

@end

@implementation ContainerViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //Set the Background Color
    self.view.backgroundColor = [UIColor colorWithRed:0.945 green:0.961 blue:0.976 alpha:1.000];
    
    
    
    
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
    catalogShown = YES;
    cameraShown = NO;
    favoritesShown = NO;
    
}


-(IBAction)cycleViewControllers:(id)sender
{
    
}



-(UIImage *)renderImageFromSnapshotWithViewController:(UIViewController *)viewController {
    
    UIGraphicsBeginImageContextWithOptions(viewController.view.bounds.size, YES, 0);
    CALayer *freshLayer = [CALayer layer];
    [freshLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *tmpImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tmpImage;

}



- (IBAction)favoritesButtonTapped:(id)sender
{
   
    UIViewController *currentVC = [self.childViewControllers objectAtIndex:0];
    
    
    NSLog(@"The number of childviewcontrollers before:%d",self.childViewControllers.count );
    
    [self addChildViewController:self.favoritesViewController];
    
    NSLog(@"The number of childviewcontrollers after:%d",self.childViewControllers.count );

    // 2
    [self transitionFromViewController:currentVC
                      toViewController:self.favoritesViewController duration:kTransitionDuration
                               options: UIViewAnimationOptionTransitionNone
                            animations:^{
                        
                                currentLayer = [self _layerSnapshotWithTransform:CATransform3DIdentity fromViewController:currentVC];
                                nextLayer = [self _layerSnapshotWithTransform:CATransform3DIdentity fromViewController:[self.childViewControllers objectAtIndex:1]];
                                NSLog(@"The number of childviewcontrollers in method:%d",self.childViewControllers.count );

                                
                                nextLayer.frame = CGRectMake(CGRectGetWidth(currentVC.view.bounds), CGRectGetMinY(currentVC.view.bounds), currentVC.view.bounds.size.width, currentVC.view.bounds.size.height);
                                
                                [self.view.layer addSublayer:currentLayer];
                                [self.view.layer addSublayer:nextLayer];
                                
                                [CATransaction flush];
                                
                                [currentLayer addAnimation:[self _animationWithTranslation:-CGRectGetWidth(self.view.bounds)] forKey:nil];
                                [nextLayer addAnimation:[self _animationWithTranslation:-CGRectGetWidth(self.view.bounds)] forKey:nil];

                                
                                
                            }
                            completion:^(BOOL finished) { // 4
                                [self.favoritesViewController didMoveToParentViewController:self];
                                NSLog(@"The number of childviewcontrollers after didMoveToParentViewController:%d",self.childViewControllers.count );

                          
                                [currentVC removeFromParentViewController];
                                NSLog(@"The number of childviewcontrollers after removeFromPArentViewController:%d",self.childViewControllers.count );

                            }];
}


- (IBAction)catalogButtonTapped:(id)sender
{
     UIViewController *currentVC = [self.childViewControllers objectAtIndex:0];

    [self addChildViewController:self.catalogViewController];
    // 2
    [self transitionFromViewController:currentVC
                      toViewController:self.catalogViewController duration:0.5
                               options: UIViewAnimationOptionTransitionNone
                            animations:nil
                            completion:^(BOOL finished) { // 4
                                [self.catalogViewController didMoveToParentViewController:self];
                                [currentVC removeFromParentViewController]; }];
}




- (IBAction)cameraButtonTapped:(id)sender
{
    UIViewController *currentVC = [self.childViewControllers objectAtIndex:0];

    
    [self addChildViewController:self.cameraViewController];
    // 2
    [self transitionFromViewController:currentVC
                      toViewController:self.cameraViewController duration:0.5
                               options: UIViewAnimationOptionTransitionNone
                            animations:nil
                            completion:^(BOOL finished) { // 4
                                [self.cameraViewController didMoveToParentViewController:self];
                                [currentVC removeFromParentViewController]; }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
 
}



#pragma mark Animation Methods

- (CABasicAnimation *)_animationWithTranslation:(CGFloat)translation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DTranslate(CATransform3DIdentity, translation, 0.f, 0.f)];
    animation.duration = kTransitionDuration;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return animation;
}

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

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag
{
    [currentLayer removeFromSuperlayer];
    [nextLayer removeFromSuperlayer];
}

//
//-(IBAction)performTransition:(id)sender {
//    
//    [self transitionFromViewController:self.catalogViewController
//                      toViewController:self.favoritesViewController
//                              duration:0.4
//                               options:UIViewAnimationOptionTransitionFlipFromLeft
//                            animations:nil
//                            completion:^(BOOL done){
//                                // we called "add"; we must call "did" afterwards
//                                [self.favoritesViewController didMoveToParentViewController:self];
//                                [self.catalogViewController removeFromParentViewController];
//                                // "did" is called for us
//                            }];
//}
//



//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    if ([segue.identifier isEqualToString:@"presentFavoritesViewController"]) {
//        
//        FavoritesViewController *favoritesViewController = (FavoritesViewController *)segue.destinationViewController;
//        
//        //Setting up FavoritesViewController to be addedd to the view hiarchy
//        favoritesViewController.dataModel = self.dataModel;
//        favoritesViewController.view.frame  = self.catalogViewController.view.frame;
//        [self addChildViewController:favoritesViewController];
//        [self.catalogViewController willMoveToParentViewController:nil];
//        
//        
//        
//    }
//}





@end
