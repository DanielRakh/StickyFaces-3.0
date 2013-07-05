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



- (IBAction)favoritesButtonTapped:(id)sender
{
   
    UIViewController *currentVC = [self.childViewControllers objectAtIndex:0];
    
    [self addChildViewController:self.favoritesViewController];
    // 2
    [self transitionFromViewController:currentVC
                      toViewController:self.favoritesViewController duration:0.5
                               options: UIViewAnimationOptionTransitionFlipFromBottom
                            animations:nil
                            completion:^(BOOL finished) { // 4
                                [self.favoritesViewController didMoveToParentViewController:self];
                                [currentVC removeFromParentViewController]; }];
}


- (IBAction)catalogButtonTapped:(id)sender
{
    __block UIViewController *currentVC = [self.childViewControllers objectAtIndex:0];

    [self addChildViewController:self.catalogViewController];
    // 2
    [self transitionFromViewController:currentVC
                      toViewController:self.catalogViewController duration:0.5
                               options: UIViewAnimationOptionTransitionFlipFromBottom
                            animations:nil
                            completion:^(BOOL finished) { // 4
                                [self.catalogViewController didMoveToParentViewController:self];
                                [currentVC removeFromParentViewController]; }];
}




- (IBAction)cameraButtonTapped:(id)sender
{
    [self addChildViewController:self.cameraViewController];
    // 2
    [self transitionFromViewController:self.favoritesViewController
                      toViewController:self.catalogViewController duration:0.5
                               options: UIViewAnimationOptionTransitionFlipFromBottom
                            animations:nil
                            completion:^(BOOL finished) { // 4
                                [self.catalogViewController didMoveToParentViewController:self];
                                [self.favoritesViewController removeFromParentViewController]; }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
 
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
