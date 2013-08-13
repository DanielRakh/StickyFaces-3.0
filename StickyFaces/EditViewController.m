//
//  EditViewController.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 2/25/13.
//
//

#import "EditViewController.h"
#import "UIImage+Resize.h"
#import "UIDevice+Resolutions.h"
#import "UIColor+StickyFacesColors.h"
#import "CustomFacesViewController.h"



@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UIButton *checkMarkButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;



@end

@implementation EditViewController



- (IBAction)goBackToCamera:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}




//Dismiss VC and go Back to Custom Faces VC
-(void)performUnwindSegue
{
    [self performSegueWithIdentifier:@"goBackToCustomFaces" sender:self];
    
    
    
    
}




-(void)positionImage:(UIImage *)image inCenterOfButton:(UIButton *)button withColor:(UIColor *)color {
    
    button.backgroundColor = color;
    button.imageView.image = image;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    

    self.view.backgroundColor = [UIColor backgroundViewColor];
    
    self.closeButton.backgroundColor = [UIColor favoritesViewColor];
    self.closeButton.tintColor = [UIColor blueColor];

    
    
    
    UIView *bottomBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 427, 320, CGRectGetMaxY(self.view.bounds)- 427)];
    bottomBarView.backgroundColor = [UIColor cameraViewColor];
//    [self.view addSubview:bottomBarView];
    
    
    
    self.faceImageView.image = self.faceImage;
    
    
    

    
}

- (IBAction)scaleImageDown:(id)sender {

//    CGSize imageSize = CGSizeMake(121,140);
    
    
    
    NSLog(@"FaceImage Size:%@", NSStringFromCGSize(self.faceImage.size));
    
//   UIImage *resizedImage = [self.faceImage resizedImageToSize:CGSizeMake(127 ,170)];
    
//    NSLog(@"Resized Image Size:%@",NSStringFromCGSize(resizedImage.size));
    
    [self saveImageInPhone:UIImagePNGRepresentation(self.faceImage)];
    
        
}




#pragma mark  - Saving and Retrieving Image Methods

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


-(void)saveImageInPhone:(NSData*)imageData
{
    
    NSMutableDictionary *faceDict = [NSDictionary dictionaryWithObject:imageData forKey:@"faceKey"];
//
    [[NSNotificationCenter defaultCenter]postNotificationName:@"imageSaved" object:nil userInfo:faceDict];
    

  
    [self performSelector:@selector(performUnwindSegue) withObject:self];
    

    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    

    
}







@end
