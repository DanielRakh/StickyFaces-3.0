//
//  StickyFacesAppDelegate.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StickyFacesAppDelegate.h"
#import "UIDevice+Resolutions.h"
#import "StickyFacesViewController.h"
#import "FavoritesViewController.h"
#import "DataModel.h"
#import "NewContainerViewController.h"



@interface StickyFacesAppDelegate ()

@property (nonatomic, strong) NewContainerViewController *containerViewController;

@end

@implementation StickyFacesAppDelegate

@synthesize window = _window;


+ (void)initialize
{
	if ([self class] == [StickyFacesAppDelegate class])
	{
		// Add an empty favorites array to the NSUserDefaults
		NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSArray array], @"Favorites", [NSArray array], @"SelectedFavorites", [NSArray array], @"CopyFaces",
                              nil];
        
		[[NSUserDefaults standardUserDefaults] registerDefaults:dict];
        
        
        NSLog(@"APP DELEGATE initialize method called");
	}
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    
    
//    self.dataModel = [[DataModel alloc]init];
    

//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NavBarSF.png"] forBarMetrics:UIBarMetricsDefault];
 


    if ([UIDevice deviceType] & iPhone5) {
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"iPhone5Storyboard" bundle:nil];
        self.containerViewController = [storyBoard instantiateInitialViewController];

    
    } else {
        UIStoryboard *theStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        
        self.containerViewController = [theStoryBoard instantiateInitialViewController];
        
    }

        
        self.window.rootViewController = self.containerViewController;
    
//        FavoritesViewController *fvc = (FavoritesViewController *)[self.tabBarController.viewControllers objectAtIndex:1];
//    StickyFacesViewController *svc = (StickyFacesViewController *)[self.containerViewController.childViewControllers objectAtIndex:0];

//    StickyFacesViewController *svc = (StickyFacesViewController *)[self.containerViewController.childViewControllers objectAtIndex:0];
//        svc.dataModel = self.dataModel;
//        fvc.dataModel = self.dataModel;
    
//        svc.delegate = fvc;



    [self.window makeKeyAndVisible];

// 
//    
//    [[UITabBar appearance]setBackgroundImage:[UIImage imageNamed:@"TB3.png"]];
//    [[UITabBar appearance]setSelectionIndicatorImage:[UIImage imageNamed:@"TabSel.png"]];
//    
//    UITabBarItem *tabBarItem1 = [self.tabBarController.tabBar.items objectAtIndex:0];
//    UITabBarItem *tabBarItem2 = [self.tabBarController.tabBar.items objectAtIndex:1];
//        
//    
//    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"FaceSel.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"FaceUnSel.png"]];
//    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"FavSel.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"FavUnSel.png"]];
//    
//
    
    [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    
    
//    
//    FavoritesViewController *fvc = (FavoritesViewController *)[self.tabBarController.viewControllers objectAtIndex:1];
//    
//    SpringboardLayout *layout = (SpringboardLayout *)fvc.trueView.collectionViewLayout;
//    
//    [layout invalidateLayout];
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
//    
//    FavoritesViewController *fvc = (FavoritesViewController *)[self.tabBarController.viewControllers objectAtIndex:1];
//    [fvc.trueView.collectionViewLayout invalidateLayout];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
//    FavoritesViewController *fvc = (FavoritesViewController *)[self.tabBarController.viewControllers objectAtIndex:1];
//    [fvc.trueView.collectionViewLayout invalidateLayout];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
//    
//    FavoritesViewController *fvc = (FavoritesViewController *)[self.tabBarController.viewControllers objectAtIndex:1];
//    [fvc.trueView.collectionViewLayout invalidateLayout];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
