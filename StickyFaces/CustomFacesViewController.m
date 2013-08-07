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
#import "FaceCell.h"
#import "CustomDataModel.h"
#import "FlashCheckView.h"


@interface CustomFacesViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) IBOutlet UIButton *addFace;

@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UIImage *deleteButton;
@property (nonatomic, strong) UIImage *checkmarkButton;
@property (nonatomic, strong) FlashCheckView *confirmedView;


-(IBAction)toggleDeleteMode:(id)sender;

@end

@implementation CustomFacesViewController
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
    
    self.view.backgroundColor = [UIColor cameraViewColor];
    
    
    
    //Setting up CollectionView
    self.facesCollectionView.backgroundColor = [UIColor backgroundViewColor];
    [self.facesCollectionView registerClass:[FaceCell class] forCellWithReuseIdentifier:@"FaceCell"];
    
    
    //Setting up CollectionView Layout To Scroll Vertical (have items being inserted horiztonally). 
    SpringboardLayout *layout = (SpringboardLayout *)self.facesCollectionView.collectionViewLayout;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    

    
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
    self.confirmedView = [[FlashCheckView alloc]initWithFrame:CGRectMake(0, 20, 320, 548)];
    self.confirmedView.alpha = 0.0f;
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self.confirmedView];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
    
    
    if ((self.dataModel.transferArray.count > 0) && (!isDeletionModeActive)) {
        
        self.editButton.hidden = NO;
        [self.editButton setBackgroundImage:self.deleteButton forState:UIControlStateNormal];
        
    } else if ((self.dataModel.transferArray.count > 0) && (isDeletionModeActive)) {
        
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
    
    if (self.dataModel.transferArray.count > 0) {
        
        
        isDeletionModeActive = YES;
        
        
        [self.editButton setBackgroundImage:self.checkmarkButton forState:UIControlStateNormal];
        
        
        SpringboardLayout *layout = (SpringboardLayout *)self.facesCollectionView.collectionViewLayout;
        [layout invalidateLayout];
        
    }
}


-(void)deactivateDeletionMode:(id)sender {
    
    isDeletionModeActive = NO;
    
    [self.editButton setBackgroundImage:self.deleteButton forState:UIControlStateNormal];
    
    //    [self.trueView reloadData];
    
    SpringboardLayout *layout = (SpringboardLayout *)self.facesCollectionView.collectionViewLayout;
    [layout invalidateLayout];
    
    
}

#pragma mark -
#pragma mark - UICollectionView Datasource Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return self.dataModel.transferArray.count;
    
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)theCollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    static NSString *CellIdentifier = @"FaceCell";
    
    FaceCell *cell =[theCollectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

//    cell.faceButton.frame = CGRectMake(0, 0, 121, 140);
//    cell.faceButton.center = CGPointMake(cell.bounds.size.width/2.0f, cell.bounds.size.height/2.0f);

    
    UIImage *faceImage = [self.dataModel retrieveFaceAtIndexPosition:indexPath.item];
    

    [cell.faceButton setBackgroundImage:faceImage forState:UIControlStateNormal];
    
//    
//    [cell.deleteButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.faceButton addTarget:self action:@selector(displayCopyHUB) forControlEvents:UIControlEventTouchUpInside];
    
    
    [cell.faceButton addTarget:self
                        action:@selector(animateWithBounce:) forControlEvents:UIControlEventTouchUpInside];
    [cell.faceButton addTarget:self
                        action:@selector(flashConfirmedView:) forControlEvents:UIControlEventTouchUpInside];
   
    
    
    
    
    return cell;
    
    
}





-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize cellSize = CGSizeMake(121, 140);
    return cellSize;
}


-(void)flashConfirmedView:(id)sender  {
    
    [UIView animateWithDuration:0.8 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.confirmedView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.8f animations:^{
            self.confirmedView.alpha = 0.0f;
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



#pragma mark - Spring Board Layout Delegate

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
    
    [self.facesCollectionView reloadData];
    
    
    
}


#pragma mark -
#pragma mark - Face Button Methods

-(void)delete:(UIButton *)sender {
    
    
    
    
    NSIndexPath *indexPath = [self.facesCollectionView indexPathForCell:(FaceCell *)sender.superview.superview];
    
//    [self.dataModel removeFromFavorites:indexPath.item];
    NSLog(@"Deleted Item number %d",indexPath.item);
    
    
    [self.facesCollectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    
    if (self.dataModel.transferArray.count == 0) {
        isDeletionModeActive = NO;
        self.editButton.hidden = YES;
    }
    
    
    
    
    
}


#pragma mark -  Copy & Paste Methods


- (void)copy:(UIButton *)sender {
    
    NSIndexPath *indexPath = [self.facesCollectionView indexPathForCell:(FaceCell *)sender.superview.superview];
    
//    UIImage *faceImage = [self.dataModel getCopyFaceAtIndex:indexPath.item];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
//    NSData *imgData = UIImagePNGRepresentation(faceImage);
    
//    [pasteboard setData:imgData forPasteboardType:[UIPasteboardTypeListImage objectAtIndex:0]];
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
            
            if ((!isDeletionModeActive && self.dataModel.transferArray.count > 0))
                
            {
                
                [self activateDeletionMode:gr];
                
            }
        }
    }
    
}




@end
