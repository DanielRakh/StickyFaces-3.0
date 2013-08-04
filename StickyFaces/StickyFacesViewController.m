//
//  StickyFacesViewController.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StickyFacesViewController.h"
#import "UIDevice+Resolutions.h"
#import "FaceCell.h"
#import "SMPageControl.h"
#import "SpringBoardLayoutAttributes.h"
#import "WCAlertView.h"
#import "FavoritesViewController.h"
#import "UIViewController+RECurtainViewController.h"
#import "TutorialView.h"
#import "MyUnwindSegue.h"


#import "FlashCheckView.h"

#import "UIColor+StickyFacesColors.h"


@interface StickyFacesViewController  ()
{
    BOOL pageControlUsed;
    int numberOfFaces;
    BOOL appOpenedForTheFirstTime;
    

    IBOutlet UINavigationBar *navBar;
}



@property (nonatomic, readwrite) IBOutlet SMPageControl *pageControl;
@property (nonatomic, weak) IBOutlet UIButton *tutorialButton;


@property (nonatomic, strong) FlashCheckView *pasteFlashView;
@property (nonatomic, strong) FlashCheckView *favoritesFlashView;



@end



@implementation StickyFacesViewController



@synthesize trueView;


#pragma mark
#pragma mark - Face Button Methods

- (void)copy:(UIButton *)sender {
    
    NSUInteger kFace = sender.tag + 1;
    
    
    NSString *faceString = [NSString stringWithFormat:@"sticky%d",kFace];
    UIImage *faceImage = [UIImage imageNamed:faceString];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    NSData *imgData = UIImagePNGRepresentation(faceImage);
    
    [pasteboard setData:imgData forPasteboardType:[UIPasteboardTypeListImage objectAtIndex:0]];
}


-(void)flipDown:(UIButton *)sender {
    
    int num = sender.tag;
    
    if (!appOpenedForTheFirstTime) {
    
    [sender setBackgroundImage:[self.dataModel faceAtIndex:num] forState:UIControlStateNormal];
        
    }
    
    [self performSelector:@selector(copy:) withObject:sender];
    
}



-(void)delay:(UIButton *)sender
{

    int num = sender.tag;
    
    
    UIImage *image = [self.dataModel selectedFaceAtIndex:num];
    
    [sender setBackgroundImage:image forState:UIControlStateNormal];
  
    [self performSelector:@selector(flipDown:) withObject:sender afterDelay:0.5];
    
}



#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
 
    self.view.backgroundColor = [UIColor catalogViewColor];
    self.trueView.backgroundColor = [UIColor backgroundViewColor];
    
    UIImage *smiley = [UIImage imageNamed:@"Grid"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, smiley.size.width, smiley.size.height)];
    imageView.image = smiley;
    
    
    imageView.center = CGPointMake(160, 22);
    
    [self.view addSubview:imageView];
    
    
    NSLog(@"This is called");
    
    [self.trueView registerClass:[FaceCell class] forCellWithReuseIdentifier:@"Face"];
    
    
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(activateLongPressRecognizer:)];
    longPress.delegate = self;
    [self.trueView addGestureRecognizer:longPress];
    

    
    
    if ([UIDevice deviceType] & iPhone5) {
        self.pageControl.numberOfPages = 9;
    } else {
        self.pageControl.numberOfPages = 9;
    }
    self.pageControl.currentPage = 0;
    [self.pageControl setPageIndicatorTintColor:[UIColor colorWithWhite:0.8f alpha:0.5f]];
    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor blackColor]];
    
    
    [self.tutorialButton setBackgroundImage:[UIImage imageNamed:@"NavQuestionMark.png"] forState:UIControlStateNormal];

    
    NSLog(@"self.trueView.frame:%@",NSStringFromCGRect(self.trueView.frame));

    
    
    self.pasteFlashView = [[FlashCheckView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) andStyle:kConfirmedToPaste];
    self.pasteFlashView.alpha = 0.0f;
    
     [[[[UIApplication sharedApplication] delegate] window] addSubview:self.pasteFlashView];
 
    
    self.favoritesFlashView = [[FlashCheckView alloc]initWithFrame:CGRectMake(0,0, 320, 568) andStyle:kFavorites];
    self.favoritesFlashView.alpha = 0.0f;
 
    
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self.favoritesFlashView];


    
}





- (void)viewDidUnload
{
    [self setTrueView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [navBar setBackgroundImage:[UIImage imageNamed:@"CatalogNavBar"] forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[[UIImage alloc]init]];
    
    NSLog(@"Catalog View Controller has appeared!");
   
    
 
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
    NSLog(@"Catalog View Controller has disappeared!");

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if (interfaceOrientation == UIInterfaceOrientationPortrait) {
        return YES;
    }
    else {
        return NO;
    }

    
    
}



#pragma mark - 
#pragma mark UIScrollView Methods


- (void)scrollViewDidScroll:(UICollectionView *)sender
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = trueView.frame.size.width;
    int page = floor((trueView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UICollectionView *)scrollView
{
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UICollectionView *)scrollView
{
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender
{
    int page = self.pageControl.currentPage;
	
    
	// update the scroll view to the appropriate page
    CGRect frame = self.trueView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [self.trueView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}



#pragma mark - 
#pragma mark - UICollectionView Datasource Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;

}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    if ([UIDevice deviceType] & iPhone5) {
    return [self.dataModel faceCount] - 3;
    }
    else {
        return [self.dataModel faceCount] - 3;
    }
    

}


-(UICollectionViewCell *)collectionView:(UICollectionView *)theCollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   

    
    static NSString *CellIdentifier = @"Face";
    
    FaceCell *cell =[theCollectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.faceButton.tag = indexPath.item;
    [cell.faceButton setBackgroundImage:[self.dataModel faceAtIndex:indexPath.item
                                         ] forState:UIControlStateNormal];

    [cell.faceButton addTarget:self action:@selector(delay:) forControlEvents:UIControlEventTouchUpInside];
    [cell.faceButton addTarget:self action:@selector(displayHUB:) forControlEvents:UIControlEventTouchUpInside];
    


    return cell;
    
    
}



#pragma mark 
#pragma mark -  Welcome Screen & First Alert View

-(BOOL)getAboutScreen{
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSNumber *preference = [prefs objectForKey:@"TutScreen"];
	if(preference == nil){
		return NO;
		
	}
	else{
		return [preference boolValue];
	}
}

-(void)setAboutScreen:(BOOL)preference{
	NSNumber *pref = [NSNumber numberWithBool:preference];
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setObject:pref forKey:@"TutScreen"];
	[prefs synchronize];
}

-(BOOL)getAlertView{
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSNumber *preference = [prefs objectForKey:@"NewAlertView"];
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
	[prefs setObject:pref forKey:@"NewAlertView"];
	[prefs synchronize];
}




#pragma mark
#pragma mark - Alerts


-(void)displayAlertView {

    WCAlertView *alert = [[WCAlertView alloc]initWithTitle:@"Good job!" message:@"Now open up your Messages App and paste." delegate:self cancelButtonTitle:@"Got it!" otherButtonTitles:nil, nil];
    [alert show];
    appOpenedForTheFirstTime = NO;
    
}



- (void)displayHUB:(id)sender

{
    
    NSLog(@"Class of Sender:%@",[sender class]);
    
    
    if(![self getAlertView]){
        
        [self performSelector:@selector(displayAlertView) withObject:self.view];
        [self setAlertView:YES];
        
        
    }
    
    else {
        
        
        if ([sender isKindOfClass:[UIButton class]]) {
            
            [UIView animateWithDuration:0.8 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.pasteFlashView.alpha = 1.0f;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.8f animations:^{
                    self.pasteFlashView.alpha = 0.0f;
                }];
            }];
            
            
        }
        else if ([sender isKindOfClass:[UILongPressGestureRecognizer class]])
        {
            [UIView animateWithDuration:0.8 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.favoritesFlashView.alpha = 1.0f;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.8f animations:^{
                    self.favoritesFlashView.alpha = 0.0f;
                }];
            }];
            
            
        }
        
        
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


- (void)activateLongPressRecognizer:(UILongPressGestureRecognizer *)gr
{
    if (gr.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"Long Press Recognized");
        
        
        NSIndexPath *indexPath = [self.trueView indexPathForItemAtPoint:[gr locationInView:self.trueView]];
        if (indexPath)
        {
       
            numberOfFaces = 9;
            
            if ([self.dataModel favoritesFaceCount] == numberOfFaces ) {
            
                [WCAlertView showAlertWithTitle:@"Oops!" message:@"You have too many favorite faces. Please delete some to add more." customizationBlock:nil completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
                    if (buttonIndex == 0) {
                        FavoritesViewController *fvc = (FavoritesViewController *)[self.tabBarController.viewControllers objectAtIndex:1];
                        [fvc activateDeletionMode:self];
                        [self.tabBarController setSelectedIndex:1];
                    
                        
                    
                    }
                } cancelButtonTitle:@"Got it!" otherButtonTitles:nil];
                
            } else {
                

                [self.delegate getIndexPathOfPressedCell:indexPath];


            
            NSLog(@"Point:%d",indexPath.item);

            SpringboardLayout *layout = (SpringboardLayout *)self.trueView.collectionViewLayout;
            [layout invalidateLayout];
                
                
                [self displayHUB:gr];

             //Present Favorites View

//                self.containerViewController = (ContainerViewController *)self.parentViewController;
                
              
                
            }
        }
    }
}









@end
