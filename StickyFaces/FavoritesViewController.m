//
//  FavoritesViewController.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 11/17/12.
//
//

#import "NewContainerViewController.h"
#import "FavoritesViewController.h"
#import "UIDevice+Resolutions.h"
#import "FaceCell.h"
#import "UIColor+StickyFacesColors.h"
#import "DataModel.h"
#import "V9Layout.h" 
#import "FaceCell.h"
#import "FlashCheckView.h"
#import "NoFavoritesView.h"


@interface FavoritesViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, V9LayoutDelegate>
{
    int itemNumber; 
}

@property (nonatomic, strong) UIButton *addFace;
@property (nonatomic, strong) UIButton *stopDelete;
@property (nonatomic, strong) UIImage *deleteButton;
@property (nonatomic, strong) UIImage *checkmarkButton;
@property (nonatomic, strong) FlashCheckView *pasteFlashView;
@property (nonatomic, strong) NoFavoritesView *noFavoritesView;




@end

@implementation FavoritesViewController


{
    BOOL isDeletionModeActive;
}







//Method called by Nav Bar Item to toggle cells into delete mode. 
-(IBAction)toggleDeleteMode:(id)sender
{
    
    if (isDeletionModeActive) {

        [self deactivateDeletionMode:sender];
    } else if (!isDeletionModeActive) {


        [self activateDeletionMode:sender];
    }
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    

    self.view.backgroundColor = [UIColor favoritesViewColor];
    
    
    V9Layout *collectionViewLayout = [[V9Layout alloc]initWithItemsInOneRow:3];
    
    
    
    
    // Setting up the Collection View
    self.trueView.backgroundColor = [UIColor backgroundViewColor];
    
    self.trueView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 44, 320, 419) collectionViewLayout:collectionViewLayout];
    [self.trueView registerClass:[FaceCell class] forCellWithReuseIdentifier:@"FaceCell"];
    self.trueView.pagingEnabled = YES;
    self.trueView.backgroundColor = [UIColor backgroundViewColor];
    self.trueView.showsVerticalScrollIndicator= NO;
    self.trueView.showsHorizontalScrollIndicator = NO;
    self.trueView.dataSource = self;
    self.trueView.delegate = self;
    
    [self.view addSubview:self.trueView];
    
 
    
    
    
    //Icon for Nav Bar.
    UIImage *heart = [UIImage imageNamed:@"Heart"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, heart.size.width, heart.size.height)];
    imageView.image = heart;
    imageView.center = CGPointMake(160, 22);
    [self.view addSubview:imageView];
    
    
    
    //Add the long press gesture recognizer 
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(activateLongPressRecognizer:)];
    longPress.delegate = self;
    [self.trueView addGestureRecognizer:longPress];
    
    
    //Adding the "Ready To Paste" View onto the hiearchy and making it transparent
    self.pasteFlashView = [[FlashCheckView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) andStyle:kConfirmedToPaste];
    self.pasteFlashView.alpha = 0.0f;
    
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self.pasteFlashView];
    

    
    
    //Setting up "No Favorites View"
    self.noFavoritesView = [[NoFavoritesView alloc]initWithFrame:CGRectMake(0, 0, 320, 419)];
    [self.trueView addSubview:self.noFavoritesView];
    self.noFavoritesView.hidden = YES;
    

    //Adding the "Done!" Button to end deletion mode
    UIImage *stopDelete = [UIImage imageNamed:@"StopDelete"];
    self.stopDelete = [UIButton buttonWithType:UIButtonTypeCustom];
    self.stopDelete.frame = CGRectMake(0, 0, stopDelete.size.width, stopDelete.size.height);
    self.stopDelete.center = CGPointMake(self.view.bounds.size.width/2.0f,CGRectGetMaxY(self.view.bounds)+100);
    
    [self.stopDelete setImage:stopDelete forState:UIControlStateNormal];
    
    
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self.stopDelete];
    
    
    [self.stopDelete addTarget:self action:@selector(deactivateDeletionMode:) forControlEvents:UIControlEventTouchUpInside];

    

}


-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    
    
    
    //Display AlertView
    if(![self getAlertView]){
        
        [self performSelector:@selector(displayAlertView) withObject:self.view];
        [self setAlertView:YES];
    }

    if ([self.dataModel favoritesFaceCount] == 0) {

        [self revealFacesImageView];
        
        
    }
    
    
    NSLog(@"Favorites View Controller has appeared!");

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    
    if ([self.dataModel favoritesFaceCount] > 0) {
        
        
        self.noFavoritesView.hidden = YES;
     
    }
}



-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    
    [self deactivateDeletionMode:self];
}







- (void)activateDeletionMode:(id)sender {
    
    if ([self.dataModel favoritesFaceCount] > 0) {
        
        
        isDeletionModeActive = YES;
                
        [[NSNotificationCenter defaultCenter]postNotificationName:@"DeletionModeOn" object:nil];
        
        
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.stopDelete.center = CGPointMake(CGRectGetMidX(self.parentViewController.view.bounds), CGRectGetMaxY(self.parentViewController.view.bounds)-30);
        } completion:^(BOOL finished) {
            [self animateWithBounce:self.stopDelete];
        }];
        
        
        V9Layout *layout = (V9Layout *)self.trueView.collectionViewLayout;
        [layout invalidateLayout];
        
    }
}


-(void)deactivateDeletionMode:(id)sender {
    
    isDeletionModeActive = NO;

    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.stopDelete.center = CGPointMake(CGRectGetMidX(self.parentViewController.view.bounds), CGRectGetMaxY(self.parentViewController.view.bounds)+100);
    } completion:^(BOOL finished) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"DeletionModeOff" object:nil];
    }];
//    [self.trueView reloadData];
    
    V9Layout *layout = (V9Layout *)self.trueView.collectionViewLayout;
    [layout invalidateLayout];

}





#pragma mark -
#pragma mark - UICollectionView Datasource Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.dataModel favoritesFaceCount];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)theCollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    static NSString *CellIdentifier = @"FaceCell";
    
    FaceCell *cell =[theCollectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    

    
    cell.faceButton.tag = indexPath.item;
        
    [cell.faceButton setBackgroundImage:[self.dataModel getImageAtIndex:indexPath.item] forState:UIControlStateNormal];
    [cell.faceButton addTarget:self action:@selector(delay:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
     [cell.faceButton addTarget:self action:@selector(displayCopyHUB) forControlEvents:UIControlEventTouchUpInside];

    
    return cell;
    
    
}


#pragma mark - Spring Board Layout Delegate

- (BOOL)isDeletionModeActiveForCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout {
    
    return isDeletionModeActive;
}


#pragma mark -
#pragma mark - Face Button Methods


-(void)getIndexPathOfPressedCell:(NSIndexPath *)indexPath {
 
    
    NSLog(@"GETINDEXPATHMESSAGECALLED");

    NSString *imageString = [NSString stringWithFormat:@"image%d@2x",indexPath.item+1];
    
    if (![self.dataModel.favorites containsObject:imageString]) {

    
    [self.dataModel addToFavorites:indexPath.item];

    int lastItem = [self.trueView numberOfItemsInSection:0];

    
    NSIndexPath *FVCindexPath = [NSIndexPath indexPathForItem:lastItem inSection:0];
    
    
    [self.trueView insertItemsAtIndexPaths:@[FVCindexPath]];
        
    if ([self.dataModel favoritesFaceCount] > 0) {
        
        
//         self.editButton.hidden = NO;
//        [self.editButton setBackgroundImage:self.deleteButton forState:UIControlStateNormal];
        }
        
//        [self displayFavoritesHUB];
        
    }
    
    
    else {
        
//        WCAlertView *alert = [[WCAlertView alloc]initWithTitle:@"Oops!" message:@"This face is already a favorite." delegate:nil cancelButtonTitle:@"Got it!" otherButtonTitles:nil];
//        [alert show];
    }
    
}

         
         
         
-(void)delete:(UIButton *)sender {
    

    
    
NSIndexPath *indexPath = [self.trueView indexPathForCell:(FaceCell *)sender.superview.superview];
    
    [self.dataModel removeFromFavorites:indexPath.item];
    NSLog(@"Deleted Item number %d",indexPath.item);
    
    
 [self.trueView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    
    if ([self.dataModel favoritesFaceCount] == 0) {
        isDeletionModeActive = NO;
        [self deactivateDeletionMode:self];
        
        
        [self performSelector:@selector(revealFacesImageView) withObject:self afterDelay:0.2];
    
    }



    
  
}



-(void)revealFacesImageView {
    
    
    self.noFavoritesView.hidden = NO;
    
    [self animateWithBounce:self.noFavoritesView];
    
    NSLog(@"Class of parent:%@",[self.parentViewController class]);
    
    
    
    
}



#pragma mark -  Copy & Paste Methods 


- (void)copy:(UIButton *)sender {
    
 NSIndexPath *indexPath = [self.trueView indexPathForCell:(FaceCell *)sender.superview.superview];
    
    UIImage *faceImage = [self.dataModel getCopyFaceAtIndex:indexPath.item];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    NSData *imgData = UIImagePNGRepresentation(faceImage);
    
    [pasteboard setData:imgData forPasteboardType:[UIPasteboardTypeListImage objectAtIndex:0]];
}


-(void)flipDown:(UIButton *)sender {
    

      NSIndexPath *indexPath = [self.trueView indexPathForCell:(FaceCell *)sender.superview.superview];
    
    
    [sender setBackgroundImage:[self.dataModel getImageAtIndex:indexPath.item] forState:UIControlStateNormal];
    
    [self performSelector:@selector(copy:) withObject:sender];
    
}



-(void)delay:(UIButton *)sender
{
    if (!isDeletionModeActive) {
    
      NSIndexPath *indexPath = [self.trueView indexPathForCell:(FaceCell *)sender.superview.superview];
    
    UIImage *image = [self.dataModel getSelectedFaceAtIndex:indexPath.item];
    
    
    [sender setBackgroundImage:image forState:UIControlStateNormal];
    
    [self performSelector:@selector(flipDown:) withObject:sender afterDelay:0.5];
    }
    
}

#pragma mark - gesture-recognition action methods




-(void)fadeOutButton:(UIButton *)sender {
    
    [UIView animateWithDuration:2.0f animations:^{
        sender.alpha = 0.2f;
    } completion:^(BOOL finished) {
        //
    }];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint touchPoint = [touch locationInView:self.trueView];
    NSIndexPath *indexPath = [self.trueView indexPathForItemAtPoint:touchPoint];
    if (indexPath && [gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]])
    {
        return NO;
    }
    return YES;
    
}

- (void)activateLongPressRecognizer:(UILongPressGestureRecognizer *)gr {
    
    if (gr.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Long Press Recognized");
        
        
        NSIndexPath *indexPath = [self.trueView indexPathForItemAtPoint:[gr locationInView:self.trueView]];
        if (indexPath) {
            
        if ((!isDeletionModeActive && [self.dataModel favoritesFaceCount] > 0))
        
        {
        
        [self activateDeletionMode:gr];
            
        }
    }
}

}






#pragma mark -  Alert View Methods

-(BOOL)getAlertView{
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSNumber *preference = [prefs objectForKey:@"FavoritesScreen"];
	if(preference == nil){
		return NO;
		
	}
	else{
		return [preference boolValue];
	}
}

-(void)setAlertView:(BOOL)preference{
	NSNumber *pref = [NSNumber numberWithBool:preference];
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setObject:pref forKey:@"FavoritesScreen"];
	[prefs synchronize];
}


-(void)displayAlertView {
    
//    [WCAlertView showAlertWithTitle:@"Welcome To Your Favorites Catalog!" message:@"Hold down a face from the main catalog to save it here for easy access."customizationBlock:nil completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
//        if (buttonIndex == 0) {
//            [self.tabBarController setSelectedIndex:0];
//        }
//    } cancelButtonTitle:@"Got it!" otherButtonTitles:nil];


}

- (void)displayCopyHUB

{
    
    
    if(![self getAlertView]){
        
        [self performSelector:@selector(displayAlertView) withObject:self.view];
        [self setAlertView:YES];
        
        
    }
    
    else {
        
        
// animate the return to visible
    }
}



- (void)displayFavoritesHUB

{
    
    
    if(![self getAlertView]){
        
        [self performSelector:@selector(displayAlertView) withObject:self.view];
        [self setAlertView:YES];
        
        
    }
    
    else {
        
	// animate the return to visible
    }
}



#pragma mark - UIView Animation methods
-(void)animateWithRepeatedBounce:(UIView*)theView
{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction animations:^{
        
        theView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            theView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                theView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }];
    }];
    
}

-(void)animateWithBounce:(UIView*)theView
{
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        theView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            theView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                theView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }];
    }];
    
    
}



@end
