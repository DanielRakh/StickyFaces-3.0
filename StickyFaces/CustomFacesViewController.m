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

@interface CustomFacesViewController () 

@property (weak, nonatomic) IBOutlet UICollectionView *facesCollectionView;

-(void)activateDeletionMode:(id)sender;



@end

@implementation CustomFacesViewController

- (IBAction)retrieveImage:(id)sender {
    
    UIImage *tmpImage = [self retrieveImageFromPhone:@"firstFace@2x" havingVersion:@"firstVersion"];
 
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cameraViewColor];
    self.facesCollectionView.backgroundColor = [UIColor backgroundViewColor];
    
    [self.facesCollectionView registerClass:[FaceCell class] forCellWithReuseIdentifier:@"FaceCell"];

    
    
    UIImage *camera = [UIImage imageNamed:@"Camera.png"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, camera.size.width, camera.size.height)];
    imageView.image = camera;

    
    imageView.center = CGPointMake(160, 22);
    
    [self.view addSubview:imageView];
    
    
    
    
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

//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    
//    return 1;
//    
//}
//
//
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    
//    
//    if ([UIDevice deviceType] & iPhone5) {
//        return [self.dataModel faceCount] - 3;
//    }
//    else {
//        return [self.dataModel faceCount] - 3;
//    }
//    
//    
//}
//
//
//-(UICollectionViewCell *)collectionView:(UICollectionView *)theCollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//    
//    static NSString *CellIdentifier = @"Face";
//    
//    FaceCell *cell =[theCollectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
//    cell.faceButton.tag = indexPath.item;
//    [cell.faceButton setBackgroundImage:[self.dataModel faceAtIndex:indexPath.item
//                                         ] forState:UIControlStateNormal];
//    
//    [cell.faceButton addTarget:self action:@selector(delay:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.faceButton addTarget:self action:@selector(displayHUB) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    return cell;
//    
//    
//}




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

@end
