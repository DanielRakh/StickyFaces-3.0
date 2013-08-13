//
//  CustomFacesViewController.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 6/25/13.
//
//

#import "CustomFacesViewController.h"
#import "goBackToCustomFaces.h"
#import "UIColor+StickyFacesColors.h"
#import "UIDevice+Resolutions.h"
#import "CustomFaceCell.h"
#import "CustomDataModel.h"
#import "FlashCheckView.h"
#import "V9Layout.h"


@interface CustomFacesViewController () <UICollectionViewDataSource, UICollectionViewDelegate, V9LayoutDelegate>
{
}

@property (nonatomic) IBOutlet UIButton *addFace;

@property (nonatomic, strong) IBOutlet UIButton *editButton;
@property (nonatomic, strong) UIImage *deleteButton;
@property (nonatomic, strong) UIImage *checkmarkButton;


@property (nonatomic, strong) FlashCheckView *pasteFlashView;



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
    
    
    
    //Setting up the Add Face Button in Nav Bar
    UIImage *addFaceImage = [UIImage imageNamed:@"SmileyAdd.png"];
    self.addFace.frame = CGRectMake(0, 0, addFaceImage.size.width, addFaceImage.size.height);
    self.addFace.center = CGPointMake(280, 22);
    [self.addFace setImage:addFaceImage forState:UIControlStateNormal];
    
    
    //Adding the "Ready To Paste" View onto the hiearchy and making it transparent
    self.pasteFlashView = [[FlashCheckView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) andStyle:kConfirmedToPaste];
    self.pasteFlashView.alpha = 0.0f;
    
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self.pasteFlashView];
    
    
    
    [self.view bringSubviewToFront:self.facesCollectionView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if (self.dataModel.arrayOfFaces.count == 0) {
        UIImage *noFaces = [UIImage imageNamed:@"NoFaces"];
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:noFaces];
        imageView.center = self.view.center;
        [self.facesCollectionView addSubview:imageView];
        
        [self animateWithRepeatedBounce:self.addFace];
        
    }
    else if (self.dataModel.arrayOfFaces.count >= 1) {
        
    
//        
    }
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    if ((self.dataModel.arrayOfFaces.count > 0) && (!isDeletionModeActive)) {
        
        self.editButton.hidden = NO;
        [self.editButton setBackgroundImage:self.deleteButton forState:UIControlStateNormal];
        
    } else if ((self.dataModel.arrayOfFaces.count > 0) && (isDeletionModeActive)) {
        
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


- (void)activateDeletionMode:(id)sender {
    
    if (self.dataModel.arrayOfFaces.count > 0) {
        
        
        isDeletionModeActive = YES;
        
        
        [self.editButton setBackgroundImage:self.checkmarkButton forState:UIControlStateNormal];
        
        
        V9Layout *layout = (V9Layout *)self.facesCollectionView.collectionViewLayout;
        [layout invalidateLayout];
        
    }
}


-(void)deactivateDeletionMode:(id)sender {
    
    isDeletionModeActive = NO;
    
    [self.editButton setBackgroundImage:self.deleteButton forState:UIControlStateNormal];
    
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
    
    

    return self.dataModel.arrayOfFaces.count;
    
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)theCollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    static NSString *CellIdentifier = @"FaceCell";
    
    CustomFaceCell *cell =[theCollectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    

    
    UIImage *faceImage = [self.dataModel.arrayOfFaces objectAtIndex:indexPath.item];
    NSLog(@"Size of FaceImage on cell:%@", NSStringFromCGSize(faceImage.size));
    

    [cell.faceButton setImage:faceImage forState:UIControlStateNormal];
    
  
    [cell.deleteButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.faceButton addTarget:self action:@selector(displayCopyHUB) forControlEvents:UIControlEventTouchUpInside];
    [cell.faceButton addTarget:self action:@selector(copy:) forControlEvents:UIControlEventTouchUpInside];
    [cell.faceButton addTarget:self action:@selector(displayPasteView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [cell.faceButton addTarget:self
                        action:@selector(animateWithBounce:) forControlEvents:UIControlEventTouchUpInside];
  
   
    
    
    
    
    return cell;
    
    
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
    
    NSIndexPath *FVCindexPath = [NSIndexPath indexPathForItem:lastItem inSection:0];
    
    NSDictionary *dictToPass = [notification userInfo];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"faceWasInserted" object:nil userInfo:dictToPass];
    
    [self.facesCollectionView performBatchUpdates:^{
        
        [self.facesCollectionView insertItemsAtIndexPaths:@[FVCindexPath]];
        
    } completion:^(BOOL finished) {
        
        NSLog(@"performBatch updates was called for insertion!");
    }];
    
    
    
    
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
        }
        
        
    }];
    

  
    
    
    
    
    
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
    if (indexPath && [gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]])
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




@end
