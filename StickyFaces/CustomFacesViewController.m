//
//  CustomFacesViewController.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 6/25/13.
//
//


#import <QuartzCore/QuartzCore.h>
#import "CustomFacesViewController.h"
#import "goBackToCustomFaces.h"
#import "UIColor+StickyFacesColors.h"
#import "UIDevice+Resolutions.h"
#import "CustomFaceCell.h"
#import "CustomDataModel.h"
#import "FlashCheckView.h"
#import "V9Layout.h"
#import "AddFaceCell.h"


@interface CustomFacesViewController () <UICollectionViewDataSource, UICollectionViewDelegate, V9LayoutDelegate>
{
    
//    UIImageView *noFacesImageView; 
}

@property (nonatomic, strong)  UIButton *addFace;

@property (nonatomic, weak) IBOutlet UIButton *editButton;
@property (nonatomic, strong) UIImage *deleteButton;
@property (nonatomic, strong) UIImage *checkmarkButton;


@property (nonatomic, strong) FlashCheckView *pasteFlashView;
@property (nonatomic, strong) UIImageView *noFacesImageView;


-(IBAction)toggleDeleteMode:(id)sender;

@end

@implementation CustomFacesViewController
{
    BOOL isDeletionModeActive;

}



-(IBAction)toggleDeleteMode:(id)sender {
    
    if (isDeletionModeActive) {
        
        [self deactivateDeletionMode:sender];

    } else if (!isDeletionModeActive) {
        
        
        [self activateDeletionMode:sender];
        
        
        
        
        
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(insertNewFaces:) name:@"imageSaved" object:nil];
    

    
    self.view.backgroundColor = [UIColor cameraViewColor];
    
    V9Layout *collectionViewLayout = [[V9Layout alloc]initWithItemsInOneRow:3];
    
    
    
    //Setting up CollectionView
    self.facesCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 44, 320, 419) collectionViewLayout:collectionViewLayout];
    [self.facesCollectionView registerClass:[CustomFaceCell class] forCellWithReuseIdentifier:@"FaceCell"];
    [self.facesCollectionView registerClass:[AddFaceCell class] forCellWithReuseIdentifier:@"AddFaceCell"];
    
    
    [self.facesCollectionView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
    [self.facesCollectionView setPagingEnabled:YES];
    [self.facesCollectionView setBackgroundColor:[UIColor backgroundViewColor]];
    
    self.facesCollectionView.dataSource = self;
    self.facesCollectionView.delegate = self;
    
    [self.view addSubview:self.facesCollectionView];
    
    
    
    //Setting up CollectionView Layout To Scroll Vertical (have items being inserted horiztonally). 
//    SpringboardLayout *layout = (SpringboardLayout *)self.facesCollectionView.collectionViewLayout;
//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    

    
    //Setting up Nav Bar Icon
    UIImage *camera = [UIImage imageNamed:@"CustomFaceIcon.png"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, camera.size.width, camera.size.height)];
    imageView.image = camera;
    imageView.center = CGPointMake(160, 22);
    [self.view addSubview:imageView];
    
    
    
    
    
    //Add the long press gesture recognizer
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(activateLongPressRecognizer:)];
    longPress.delegate = self;
    [self.facesCollectionView addGestureRecognizer:longPress];
    
    
    

    //Adding the "Ready To Paste" View onto the hiearchy and making it transparent
    self.pasteFlashView = [[FlashCheckView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) andStyle:kConfirmedToPaste];
    self.pasteFlashView.alpha = 0.0f;
    
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self.pasteFlashView];
    
    
    
    [self.view bringSubviewToFront:self.facesCollectionView];
    
    
    
    UIImage *addFaceImage = [UIImage imageNamed:@"SmileyCell"];
    self.addFace.frame = CGRectMake(0, 0, addFaceImage.size.width, addFaceImage.size.height);
    self.addFace.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds)+ 80);
    [self.addFace setImage:addFaceImage forState:UIControlStateNormal];
    self.addFace.hidden = YES;
    
    
    //Create View for when No Faces are in the CollectionView. 
    UIImage *noFaces = [UIImage imageNamed:@"NoFaces.png"];
    self.noFacesImageView = [[UIImageView alloc]initWithImage:noFaces];
    self.noFacesImageView.center = CGPointMake(self.view.center.x, self.view.center.y - 140);
    [self.facesCollectionView addSubview:self.noFacesImageView];
    self.noFacesImageView.hidden = YES;
    
    [self.view bringSubviewToFront:self.addFace];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    

    UIImage *editFaceImage = [UIImage imageNamed:@"SmileyDelete.png"];
    self.editButton.frame = CGRectMake(0, 0, editFaceImage.size.width, editFaceImage.size.height);
    self.editButton.center = CGPointMake(280, 22);
    [self.editButton setImage:editFaceImage forState:UIControlStateNormal];
    [self.editButton setImage:[UIImage imageNamed:@"StopEditCheckmark"] forState:UIControlStateSelected];

    
    if (self.dataModel.arrayOfFaces.count == 0) {
        
        
       self.noFacesImageView.hidden = NO;
        self.addFace.hidden = NO;
        [self animateWithBounce:self.noFacesImageView];
        [self animateWithRepeatedBounce:self.addFace];
        
    }

}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    if ((self.dataModel.arrayOfFaces.count > 0) && (!isDeletionModeActive)) {
        
        self.editButton.hidden = NO;
        self.noFacesImageView.hidden = YES;
        self.addFace.hidden = YES;

        
    } else if ((self.dataModel.arrayOfFaces.count > 0) && (isDeletionModeActive)) {
        
        self.editButton.hidden = NO;
//        self.addFace.hidden = YES;
//        self.editButton setImage:<#(UIImage *)#> forState:<#(UIControlState)#>
        
        
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


- (void)activateDeletionMode:(id)sender {
    
    if (self.dataModel.arrayOfFaces.count > 0) {
        
        
        isDeletionModeActive = YES;
        
//        self.addFace.hidden = YES;
        
        
        self.editButton.selected = YES;
        
        [self animateWithRepeatedBounce:self.editButton];
        
        
        V9Layout *layout = (V9Layout *)self.facesCollectionView.collectionViewLayout;
        [layout invalidateLayout];
        
    }
}


-(void)deactivateDeletionMode:(id)sender {
    
    isDeletionModeActive = NO;
    self.editButton.selected = NO;
    

//    self.addFace.hidden = NO;
//    [self animateWithBounce:self.addFace];
    
    [self.editButton.layer removeAllAnimations];
    
    //    [self.trueView reloadData];
    
    V9Layout *layout = (V9Layout *)self.facesCollectionView.collectionViewLayout;
    [layout invalidateLayout];
    
    
}

#pragma mark -
#pragma mark - UICollectionView Datasource Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    

    return self.dataModel.arrayOfFaces.count + 1;
    
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)theCollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    static NSString *CustomCellIdentifier = @"FaceCell";
    static NSString *AddFaceCellIdentifier = @"AddFaceCell";
    

    if (indexPath.item == self.dataModel.arrayOfFaces.count) {
        
        AddFaceCell *addFaceCell = [self.facesCollectionView dequeueReusableCellWithReuseIdentifier:AddFaceCellIdentifier forIndexPath:indexPath];
//     [addFaceCell.faceButton addTarget:self action:@selector(animateWithBounce:) forControlEvents:UIControlEventTouchUpInside];
     [addFaceCell.faceButton addTarget:self action:@selector(openUpTheCamera:) forControlEvents:UIControlEventTouchUpInside];

        
        
        return addFaceCell;
    }
    
    else {
    
    
    CustomFaceCell *cell =[theCollectionView dequeueReusableCellWithReuseIdentifier:CustomCellIdentifier forIndexPath:indexPath];
    

    
    UIImage *faceImage = [self.dataModel.arrayOfFaces objectAtIndex:indexPath.item];
    NSLog(@"Size of FaceImage on cell:%@", NSStringFromCGSize(faceImage.size));
    

    [cell.faceButton setImage:faceImage forState:UIControlStateNormal];
    
  
    [cell.deleteButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
//  [cell.faceButton addTarget:self action:@selector(displayCopyHUB) forControlEvents:UIControlEventTouchUpInside];
    [cell.faceButton addTarget:self action:@selector(copy:) forControlEvents:UIControlEventTouchUpInside];
    [cell.faceButton addTarget:self action:@selector(displayPasteView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [cell.faceButton addTarget:self
                        action:@selector(animateWithBounce:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
   
  
   
    
    
    
    
    return cell;
    }
    
    
}

- (void)displayPasteView:(id)sender

{
    
    NSLog(@"Class of Sender:%@",[sender class]);
    
//    
//    if(![self getAlertView]){
//        
//        [self performSelector:@selector(displayAlertView) withObject:self.view];
//        [self setAlertView:YES];
    
        

        
        
        if ([sender isKindOfClass:[UIButton class]]) {
            
            [UIView animateWithDuration:0.8 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.pasteFlashView.alpha = 1.0f;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.8f animations:^{
                    self.pasteFlashView.alpha = 0.0f;
                }];
            }];
            
            
        }

        
}


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



#pragma mark -V9 Layout Delegate

- (BOOL)isDeletionModeActiveForCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout {
    
    return isDeletionModeActive;
}


#pragma mark - UIStoryBoardSegue Methods


//UIStoryborad Unwind Segue Methods from ImagePreviewController
- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier {
	
	if ([identifier isEqualToString:@"goBackToCustomFaces"])
        NSLog(@"The identifier is being registerd");
        
        return [[goBackToCustomFaces alloc]initWithIdentifier:identifier source:fromViewController destination:toViewController];
    
        

	return [super segueForUnwindingToViewController:toViewController
								 fromViewController:fromViewController
										 identifier:identifier];
    
}

-(IBAction)goBackToCustomFacesViewController:(UIStoryboardSegue *)segue {
    
    [[UIApplication sharedApplication]setStatusBarHidden:NO];

}


#pragma mark -
#pragma mark - Face Button Methods



-(void)insertNewFaces:(NSNotification *)notification {
    
    int lastItem = [self.facesCollectionView numberOfItemsInSection:0];
    
    //This is the indexPath for the item that already exists in the section. We are going to move this
    NSIndexPath *indexPathForLastCell = [NSIndexPath indexPathForItem:lastItem-1 inSection:0];
    NSIndexPath *indexPathToMoveLastCell = [NSIndexPath indexPathForItem:lastItem inSection:0];
    
//    NSIndexPath *indexPathToInsertNewCell = [NSIndexPath indexPathForItem:lastItem inSection:0];

    
    
//    [self returnPointForLastCell:FVCindexPath];
    
    NSDictionary *dictToPass = [notification userInfo];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"faceWasInserted" object:nil userInfo:dictToPass];
    
    [self.facesCollectionView performBatchUpdates:^{
        
        [self.facesCollectionView moveItemAtIndexPath:indexPathForLastCell toIndexPath:indexPathToMoveLastCell];

        [self.facesCollectionView insertItemsAtIndexPaths:@[indexPathForLastCell]];

    } completion:^(BOOL finished) {
        
        self.noFacesImageView.hidden = YES;
        self.addFace.hidden = YES;
        NSLog(@"performBatch updates was called for insertion!");
    }];
    
    
    
    
}


-(void)returnPointForLastCell:(NSIndexPath *)indxPath {
    

    UICollectionViewCell *lastCell = [self.facesCollectionView cellForItemAtIndexPath:indxPath];
    
    
    
    CGPoint actualPoint = [self.facesCollectionView convertPoint:lastCell.center fromView:self.view];
    
    NSLog(@"Last Cell's Center Point:%@",NSStringFromCGPoint(actualPoint));
    
}

-(void)delete:(UIButton *)sender {
    
    NSIndexPath *indexPath = [self.facesCollectionView indexPathForCell:(CustomFaceCell *)sender.superview.superview];
    
    NSLog(@"IndexPath of cell that is about to be deleted:%@",indexPath);
    
    
    [self.dataModel removeFaceAtIndexPosition:indexPath.item];
    
    NSLog(@"Deleted Item number %d",indexPath.item);
    
    [self.facesCollectionView performBatchUpdates:^{
        
        [self.facesCollectionView deleteItemsAtIndexPaths:@[indexPath]];

    } completion:^(BOOL finished) {
        
        NSLog(@"performBatch updates was called for deletion!");
        
        
        if (self.dataModel.arrayOfFaces.count == 0) {
            isDeletionModeActive = NO;
            self.editButton.hidden = YES;
            
            
            [self performSelector:@selector(revealFacesImageView) withObject:self afterDelay:0.2];
            
        }
        
        
    }];
    

  
    
    
    
    
    
}


-(void)revealFacesImageView {
    

    self.noFacesImageView.hidden = NO;
    self.addFace.hidden = NO;

    [self animateWithBounce:self.noFacesImageView];
    [self animateWithRepeatedBounce:self.addFace];

    
    
}



#pragma mark -  Copy & Paste Methods


- (void)copy:(UIButton *)sender {
    
    NSIndexPath *indexPath = [self.facesCollectionView indexPathForCell:(CustomFaceCell *)sender.superview.superview];
    
    UIImage *faceImage = [self.dataModel getCopyFaceAtIndex:indexPath.item];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];

    pasteboard.image = faceImage;
}

#pragma mark - gesture-recognition action methods

- (void)fadeOutButton:(UIButton *)sender {
    
    [UIView animateWithDuration:2.0f animations:^{
        sender.alpha = 0.2f;
    } completion:^(BOOL finished) {
        //
    }];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint touchPoint = [touch locationInView:self.facesCollectionView];
    NSIndexPath *indexPath = [self.facesCollectionView indexPathForItemAtPoint:touchPoint];
    if ((indexPath && [gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]])  | (indexPath.item == self.dataModel.arrayOfFaces.count))
    {
        return NO;
    }
    return YES;
    
}

- (void)activateLongPressRecognizer:(UILongPressGestureRecognizer *)gr {
    
    if (gr.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Long Press Recognized");
        
        
        NSIndexPath *indexPath = [self.facesCollectionView indexPathForItemAtPoint:[gr locationInView:self.facesCollectionView]];
        if (indexPath) {
            
            if ((!isDeletionModeActive))
                
            {
                NSLog(@"Delete Mode called");
                
                [self activateDeletionMode:gr];
                
            }
        }
    }
    
}



#pragma mark Segue Methods

-(void)openUpTheCamera:(id)sender {
    
    [self performSegueWithIdentifier:@"performModalSegue" sender:self];
    
}




@end
