//
//  StickyFacesAppDelegate.h
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCAlertView.h"
#import "MyTabBarController.h"


@class DataModel;

@interface StickyFacesAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MyTabBarController *tabBarController;
@property (strong, nonatomic) DataModel *dataModel;

@end
