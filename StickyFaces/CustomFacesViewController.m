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


@interface CustomFacesViewController () <UICollectionViewDataSource, UICollectionViewDelegate>





-(void)activateDeletionMode:(id)sender;



@end

@implementation CustomFacesViewController
{
    BOOL isDeletionModeActive;

}


- (IBAction)retrieveImage:(id)sender {
    
//    UIImage *tmpImage = [self retrieveImageFromPhone:@"firstFace@2x" havingVersion:@"firstVersion"];
 
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cameraViewColor];
    self.facesCollectionView.backgroundColor = [UIColor backgroundViewColor];
    
    

    

    
    
    UIImage *camera = [UIImage imageNamed:@"Camera.png"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, camera.size.width, camera.size.height)];
    imageView.image = camera;

    
    imageView.center = CGPointMake(160, 22);
    
    [self.view addSubview:imageView];
    
    
    
    [self.facesCollectionView registerClass:[FaceCell class] forCellWithReuseIdentifier:@"FaceCell"];
    
    
    NSLog(@"self.facesCollectionView.frame:%@",NSStringFromCGRect(self.facesCollectionView.frame));

    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(UIImage*)retrieveImageFromPhone:(NSString*)fileName
                    havingVersion:(NSString*)iconVersionString
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    
    //Get the docs directory
    NSString *documentsPath = [paths objectAtIndex:0];
    
    NSString *folderPath = [documentsPath
                            stringByAppendingPathComponent:@"CustomFaces"];
    
    NSString *filePath = [folderPath stringByAppendingPathComponent:
                          [fileName stringByAppendingFormat:
                           @"%@",@".png"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        return [[UIImage alloc] initWithContentsOfFile:filePath];
    else
        return nil;
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
    
//    cell.textLabel.text = [NSString stringWithFormat:@"%d,%d",indexPath.section,indexPath.item];
    
  
    
    
    UIImage *faceImage = [self.dataModel retrieveFaceAtIndexPosition:indexPath.item];
    
//    NSLog(@"The image size:%@",NSStringFromCGSize(faceImage.size));
    

    [cell.faceButton setBackgroundImage:faceImage forState:UIControlStateNormal];
    
    
    return cell;
    
    
}




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



#pragma mark - Spring Board Layout Delegate

- (BOOL)isDeletionModeActiveForCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout {
    
    return isDeletionModeActive;
}

@end
