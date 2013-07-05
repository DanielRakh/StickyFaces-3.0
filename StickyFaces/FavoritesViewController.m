//
//  FavoritesViewController.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 11/17/12.
//
//

#import "FavoritesViewController.h"
#import "UIDevice+Resolutions.h"
#import "FaceCell.h"
#import "WCAlertView.h"

@interface FavoritesViewController ()
{
    IBOutlet UINavigationBar *navBar;
}

@property (nonatomic, assign) int itemNumber;

@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) UIImage *deleteButton;
@property (strong, nonatomic) UIImage *checkmarkButton;


-(IBAction)toggleDeleteMode:(id)sender;


@end

@implementation FavoritesViewController
{
    BOOL isDeletionModeActive;
}




-(id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        
        _deleteButton = [UIImage imageNamed:@"NavCloseButton"];
        _checkmarkButton = [UIImage imageNamed:@"NavCheckmarkButton"];        
    
    }

    return self;
}


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

    [self.trueView registerClass:[FaceCell class] forCellWithReuseIdentifier:@"FaceCell"];
    
    
    
    
    //Add the long press gesture recognizer 
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(activateLongPressRecognizer:)];
    longPress.delegate = self;
    [self.trueView addGestureRecognizer:longPress];
    

    

}


-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    if(![self getAlertView]){
        
        [self performSelector:@selector(displayAlertView) withObject:self.view];
        [self setAlertView:YES];
    }

    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
    [navBar setBackgroundImage:[UIImage imageNamed:@"CatalogNavBar"] forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[[UIImage alloc]init]];

    

    
    if (([self.dataModel favoritesFaceCount] > 0) && (!isDeletionModeActive)) {
        
        self.editButton.hidden = NO;
        [self.editButton setBackgroundImage:self.deleteButton forState:UIControlStateNormal];
        
    } else if (([self.dataModel favoritesFaceCount] > 0) && (isDeletionModeActive)) {
        
        self.editButton.hidden = NO;
        [self.editButton setBackgroundImage:self.checkmarkButton forState:UIControlStateNormal];
        
    }
    else
    {
        self.editButton.hidden = YES;
    }

}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    
    [self deactivateDeletionMode:self];
}



-(void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:YES];
    
}







- (void)activateDeletionMode:(id)sender {
    
    if ([self.dataModel favoritesFaceCount] > 0) {
        
        
        isDeletionModeActive = YES;
                
                
        [self.editButton setBackgroundImage:self.checkmarkButton forState:UIControlStateNormal];
        
        
        SpringboardLayout *layout = (SpringboardLayout *)self.trueView.collectionViewLayout;
        [layout invalidateLayout];
        
    }
}


-(void)deactivateDeletionMode:(id)sender {
    
    isDeletionModeActive = NO;

    [self.editButton setBackgroundImage:self.deleteButton forState:UIControlStateNormal];
    
//    [self.trueView reloadData];
    
    SpringboardLayout *layout = (SpringboardLayout *)self.trueView.collectionViewLayout;
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
        
        [self displayFavoritesHUB];
        
    }
    
    
    else {
        
        WCAlertView *alert = [[WCAlertView alloc]initWithTitle:@"Oops!" message:@"This face is already a favorite." delegate:nil cancelButtonTitle:@"Got it!" otherButtonTitles:nil];
        [alert show];
    }
    
}

         
         
         
-(void)delete:(UIButton *)sender {
    

    
    
NSIndexPath *indexPath = [self.trueView indexPathForCell:(FaceCell *)sender.superview.superview];
    
    [self.dataModel removeFromFavorites:indexPath.item];
    NSLog(@"Deleted Item number %d",indexPath.item);
    
    
 [self.trueView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    
    if ([self.dataModel favoritesFaceCount] == 0) {
        isDeletionModeActive = NO;
        self.editButton.hidden = YES;
    }
  
    
    
    
  
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
    
    [WCAlertView showAlertWithTitle:@"Welcome To Your Favorites Catalog!" message:@"Hold down a face from the main catalog to save it here for easy access."customizationBlock:nil completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
        if (buttonIndex == 0) {
            [self.tabBarController setSelectedIndex:0];
        }
    } cancelButtonTitle:@"Got it!" otherButtonTitles:nil];


}

- (void)displayCopyHUB

{
    
    
    if(![self getAlertView]){
        
        [self performSelector:@selector(displayAlertView) withObject:self.view];
        [self setAlertView:YES];
        
        
    }
    
    else {
        
        
        CopyHUD *newHud = [CopyHUD newHUD];
        newHud.alpha = 0.0;	// make the view transparent
     
        
        if ([UIDevice deviceType] &iPhone5) {
            newHud.frame = CGRectMake(0, 42, 320, 460);
        }
        
        [self.view addSubview:newHud];
        [UIView animateWithDuration:0.5 delay:0.4 options:0
                         animations:^{newHud.alpha = 1.0;}
                         completion:^ (BOOL finished) {
                             [UIView animateWithDuration:0.5 delay:0.2 options:0 animations:^{
                                 newHud.alpha = 0.0;
                             } completion:^(BOOL finished) {
                                 [newHud removeFromSuperview];
                             }];
                         }];	// animate the return to visible
    }
}



- (void)displayFavoritesHUB

{
    
    
    if(![self getAlertView]){
        
        [self performSelector:@selector(displayAlertView) withObject:self.view];
        [self setAlertView:YES];
        
        
    }
    
    else {
        
        
        CopyHUD *newHud = [CopyHUD newHUD];
        newHud.alpha = 0.0;	// make the view transparent
        newHud.imageView.image = [UIImage imageNamed:@"FavoriteHud.png"];
        
        if ([UIDevice deviceType] &iPhone5) {
            newHud.frame = CGRectMake(0, 42, 320, 460);
        }
        
        [self.view addSubview:newHud];
        [UIView animateWithDuration:0.8 delay:0.4 options:0
                         animations:^{newHud.alpha = 1.0;}
                         completion:^ (BOOL finished) {
                             [UIView animateWithDuration:0.5 delay:0.2 options:0 animations:^{
                                 newHud.alpha = 0.0;
                             } completion:^(BOOL finished) {
                                 [newHud removeFromSuperview];
                             }];
                         }];	// animate the return to visible
    }
}





@end
