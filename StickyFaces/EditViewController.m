//
//  EditViewController.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 2/25/13.
//
//

#import "EditViewController.h"
#import "UIImage+Resize.h"
#import "CameraOverlay.h"
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


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor backgroundViewColor];
    
    self.faceImageView.image = self.faceImage;
    
    

    
}

- (IBAction)scaleImageDown:(id)sender {

   UIImage *resizedImage = [self.faceImage resizedImageToSize:CGSizeMake(121, 140)];
    
    NSLog(@"Resized Image Size:%@",NSStringFromCGSize(resizedImage.size));
    
    [self saveImageInPhone:UIImagePNGRepresentation(resizedImage)];
    
    [self performSelector:@selector(performUnwindSegue) withObject:self];
    
    //Is there a way to obtain the indexPath of an empty cell?
    //What if I name the string based on enumerating the filepath...grabbing the string of the last file name and changing a nu
    
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
     
    [[NSNotificationCenter defaultCenter]postNotificationName:@"imageSaved" object:nil userInfo:faceDict];
    
    
}


/*

-(CAShapeLayer *)createTransparentBackground {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.faceView.bounds.size.width, self.faceView.bounds.size.height) cornerRadius:0];

    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor colorWithWhite:0.000 alpha:0.750].CGColor;
    fillLayer.opacity = 0.5;
    
    return fillLayer;
    
}
*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    

    
}







@end
