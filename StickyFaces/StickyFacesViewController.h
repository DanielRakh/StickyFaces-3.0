//
//  StickyFacesViewController.h
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//




#import <UIKit/UIKit.h>
#import "SpringboardLayout.h"
#import "DataModel.h"


@class StickyFacesViewController;
@protocol StickyFacesViewControllerDelegate <NSObject>

-(void)getIndexPathOfPressedCell:(NSIndexPath *)indexPath;

@end


@interface StickyFacesViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate, UIGestureRecognizerDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *trueView;

@property (weak, nonatomic) id <StickyFacesViewControllerDelegate> delegate;

@property (nonatomic, weak) DataModel *dataModel;




@end
