//
//  CustomViewController.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 2/23/13.
//
//


#define CAMERA_TRANSFORM                    1.12412


#import "CustomViewController.h"
#import "OverlayView.h"
#import  <QuartzCore/QuartzCore.h>
#import  <MobileCoreServices/MobileCoreServices.h>
#import "JBCroppableView.h"
#import "EditViewController.h"





@interface CustomViewController ()

@property (nonatomic, strong) IBOutlet UIImageView *imageView; 


@end

@implementation CustomViewController


+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
{
    // Create a graphics image context
    UIGraphicsBeginImageContextWithOptions(newSize, YES, 0.0);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}


+ (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSizeWithSameAspectRatio:(CGSize)targetSize

{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor; // scale to fit height
        }
        else {
            scaleFactor = heightFactor; // scale to fit width
        }
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    CGImageRef imageRef = [sourceImage CGImage];
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    
    if (bitmapInfo == kCGImageAlphaNone) {
        bitmapInfo = kCGImageAlphaNoneSkipLast;
    }
    
    CGContextRef bitmap;
    
    if (sourceImage.imageOrientation == UIImageOrientationUp || sourceImage.imageOrientation == UIImageOrientationDown) {
        bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
        
    } else {
        bitmap = CGBitmapContextCreate(NULL, targetHeight, targetWidth, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
        
    }
    
    // In the right or left cases, we need to switch scaledWidth and scaledHeight,
    // and also the thumbnail point
    if (sourceImage.imageOrientation == UIImageOrientationLeft) {
        thumbnailPoint = CGPointMake(thumbnailPoint.y, thumbnailPoint.x);
        CGFloat oldScaledWidth = scaledWidth;
        scaledWidth = scaledHeight;
        scaledHeight = oldScaledWidth;
        
        CGContextRotateCTM (bitmap, M_PI_2); // + 90 degrees
        CGContextTranslateCTM (bitmap, 0, -targetHeight);
        
    } else if (sourceImage.imageOrientation == UIImageOrientationRight) {
        thumbnailPoint = CGPointMake(thumbnailPoint.y, thumbnailPoint.x);
        CGFloat oldScaledWidth = scaledWidth;
        scaledWidth = scaledHeight;
        scaledHeight = oldScaledWidth;
        
        CGContextRotateCTM (bitmap, -M_PI_2); // - 90 degrees
        CGContextTranslateCTM (bitmap, -targetWidth, 0);
        
    } else if (sourceImage.imageOrientation == UIImageOrientationUp) {
        // NOTHING
    } else if (sourceImage.imageOrientation == UIImageOrientationDown) {
        CGContextTranslateCTM (bitmap, targetWidth, targetHeight);
        CGContextRotateCTM (bitmap, -M_PI); // - 180 degrees
    }
    
    CGContextDrawImage(bitmap, CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledWidth, scaledHeight), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return newImage; 
}


- (IBAction)saveImage:(id)sender {
    
    if (self.imageView != nil) {
        UIImage *imageToSave;
        imageToSave = self.imageView.image;
        
        UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil);
        
        
        
    }
    
    
    
    
}

- (IBAction)showCameraUI:(id)sender {
    
    self.imageView.image = nil;
    

    
    
}





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
//    self.imagePicker = [[UIImagePickerController alloc]init];
    
    
    
    
    


}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)renderView:(UIView*)someView inContext:(CGContextRef)context
{
    // -renderInContext: renders in the coordinate space of the layer,
    // so we must first apply the layer's geometry to the graphics context
    CGContextSaveGState(context);
    // Center the context around the window's anchor point
    CGContextTranslateCTM(context, [someView center].x, [someView center].y);
    // Apply the window's transform about the anchor point
    CGContextConcatCTM(context, [someView transform]);
    // Offset by the portion of the bounds left of and above the anchor point
    CGContextTranslateCTM(context, -[someView bounds].size.width * [[someView layer] anchorPoint].x, -[someView bounds].size.height * [[someView layer] anchorPoint].y);
    
    // Render the layer hierarchy to the current context
    [someView.layer renderInContext:context];
    
    // Restore the context
    CGContextRestoreGState(context);
    
}

// this get called when an image has been taken from the camera
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  /*
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    //cameraImage = image;
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    else
        UIGraphicsBeginImageContext(imageSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    // Draw the image returned by the camera sample buffer into the context.
    // Draw it into the same sized rectangle as the view that is displayed on the screen.
    float menubarUIOffset = 44.0;
    UIGraphicsPushContext(context);
    [image drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height-menubarUIOffset)];
    UIGraphicsPopContext();
    
    // Render the camera overlay view into the graphic context that we created above.
    [self renderView:self.cameraUI.view inContext:context];
    
   enshot image containing both the camera content and the overlay view
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil);
    UIGraphicsEndImageContext();
  */
 UIImage *theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
//    UIImage *theImage = [self.class imageWithImage:originalImage scaledToSize:CGSizeMake(320, 426.666)];

    if (picker.cameraDevice == UIImagePickerControllerCameraDeviceFront) {
        CGSize imageSize = theImage.size;
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextRotateCTM(ctx, M_PI/2);
        CGContextTranslateCTM(ctx, 0, -imageSize.width);
        CGContextScaleCTM(ctx, imageSize.height/imageSize.width, imageSize.width/imageSize.height);
        CGContextDrawImage(ctx, CGRectMake(0.0, 0.0, imageSize.width, imageSize.height), theImage.CGImage);
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIImage *theImage = [self.class imageWithImage:newImage scaledToSize:CGSizeMake(320, 426.666)];
       
        UIGraphicsEndImageContext();

        _imageView.image = theImage;

    }


    
    


    
    [self.presentedViewController dismissViewControllerAnimated:NO completion:^{
        [self performSegueWithIdentifier:@"openEditViewController" sender:self];

    }];
    
    
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"openEditViewController"]) {
        EditViewController *editViewController = (EditViewController *)segue.destinationViewController;
        editViewController.passedImage =_imageView.image;
        
        [[UIApplication sharedApplication]setStatusBarHidden:YES];
       
    }
}



@end
