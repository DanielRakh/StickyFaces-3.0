//
//  ConfirmViewController.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 3/8/13.
//
//

#define kImageCapturedSuccessfully @"imageCapturedSuccessfully"


#import "ConfirmViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreVideo/CoreVideo.h>
#import <CoreMedia/CoreMedia.h>
#import <ImageIO/ImageIO.h>
#import "OverlayView.h"
#import "AVCamCaptureManager.h"
#import "UIImage+Resize.h"
#import "ImagePreviewViewController.h"
#import "CameraOverlay.h"
#import "CameraShutterView.h"




@interface ConfirmViewController () 
{
    
BOOL frontCameraIsOn;
    
}





@property (strong, nonatomic) IBOutlet UIView *cameraView;
@property (nonatomic, strong) AVCamCaptureManager *captureManager;
@property (nonatomic, strong) UIImage *faceImage;

@property (weak, nonatomic) IBOutlet UIButton *captureButton;
@property (weak, nonatomic) IBOutlet UIButton *toggleButton;

@property (nonatomic, strong) CameraShutterView *shutterView;


-(IBAction)cameraButtonPressed:(id)sender;

@end

@implementation ConfirmViewController


-(id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
  
        
    }
    
    return self;
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    

}


-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    

    AVCaptureDeviceInput *currentInput = [self.captureManager.captureSession.inputs objectAtIndex:0];
    if (currentInput.device.position == AVCaptureDevicePositionFront) {
        frontCameraIsOn = YES;
    } else if (currentInput.device.position == AVCaptureDevicePositionBack) {
        frontCameraIsOn = NO;
    }
    
        
    
}


-(void)performUnwindSegue
{
    [self performSegueWithIdentifier:@"goBackToCustomFacesViewController" sender:self];
    
    
}


-(void)setupElements {
    
    OverlayView *overlayView = [[OverlayView alloc]initWithFrame:self.cameraView.bounds];
    
    [self.cameraView addSubview:overlayView];
    
    
    self.shutterView = [[CameraShutterView alloc]initWithFrame:self.view.bounds];
    self.shutterView.tag = 100;
    
    [self.view addSubview:self.shutterView];
    
    CameraOverlay *cameraOverlayView = [[CameraOverlay alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:cameraOverlayView];

    
    [self.view bringSubviewToFront:self.captureButton];
    [self.view bringSubviewToFront:self.toggleButton];
    
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *cancelButtonImage = [UIImage imageNamed:@"CancelButton"];
    UIImage *cancelButtonPressedImage = [UIImage imageNamed:@"CancelButtonPressed"];
    
    
    
    cancelButton.frame = CGRectMake(18, 484, cancelButtonImage.size.width, cancelButtonImage.size.height);
    
    [cancelButton setImage:cancelButtonImage forState:UIControlStateNormal];
    [cancelButton setImage:cancelButtonPressedImage forState:UIControlStateHighlighted];
    
    [cancelButton addTarget:self action:@selector(performUnwindSegue) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cancelButton];
    
    
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
 

    
    self.captureManager = [[AVCamCaptureManager alloc]init];
    [self.captureManager addVideoInput];
    [self.captureManager addVideoPreviewLayer];
    [self.captureManager addStillImageOutput];
    

    
    self.captureManager.previewLayer.frame = self.cameraView.bounds;
    [self.cameraView.layer addSublayer:self.captureManager.previewLayer];
    
    
    NSLog(@"cameraView Frame: %@",NSStringFromCGRect(self.cameraView.frame));
    NSLog(@"cameraView Bounds:%@",NSStringFromCGRect(self.cameraView.bounds));
    
    NSLog(@"CaptureManager PreviewLayer Frame: %@",NSStringFromCGRect(self.captureManager.previewLayer.frame));
    NSLog(@"CaptureManager PreviewLayer Bounds:%@",NSStringFromCGRect(self.captureManager.previewLayer.bounds));

    
    
 

    

    [self setupElements];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(captureSessionIsRunning:) name:AVCaptureSessionDidStartRunningNotification object:nil];

    
    

    [self.captureManager.captureSession startRunning];
    
}

-(void)captureSessionIsRunning:(id)sender {
    
    [self.shutterView performFirstSplitAnimation];
    
}
//DELETE BACKGROUND

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(UIImage *)flipFrontFacingCameraImage:(UIImage *)image {
    
    
    //        Flip the image if its from the front facing camera
    CGSize imageSize = image.size;
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextRotateCTM(ctx, M_PI/2);
    CGContextTranslateCTM(ctx, 0, -imageSize.width);
    CGContextScaleCTM(ctx, imageSize.height/imageSize.width, imageSize.width/imageSize.height);
    CGContextDrawImage(ctx, CGRectMake(0.0, 0.0, imageSize.width, imageSize.height), image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
    
}


-(IBAction)cameraButtonPressed:(id)sender {
    [self.shutterView performCustomSplitAnimation];

    
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in self.captureManager.stillImageOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
            }
        }
        if ([videoConnection isVideoOrientationSupported])  {
            
            NSLog(@"Video orientation is called!");
            [videoConnection setVideoOrientation:AVCaptureVideoOrientationPortrait];
            
            break;
        }
    }
    
    
    NSLog(@"about to request a capture from: %@", self.captureManager.stillImageOutput);
    [self.captureManager.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        CFDictionaryRef exifAttachements = CMGetAttachment(imageDataSampleBuffer,kCGImagePropertyExifDictionary, NULL);
        if (exifAttachements)
        {
            NSLog(@"attachements: %@", exifAttachements);
        }
        else NSLog(@"no attachements");
        
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage *originalImage = [UIImage imageWithData:imageData];
        

        if (frontCameraIsOn) {
            
            //Flip the image if it is taken from the front facing camera.
            UIImage *newImage = [self flipFrontFacingCameraImage:originalImage];
            

            NSLog(@"Front Camera Image Orientation:%d",newImage.imageOrientation);

            
            UIImage *resizedImage = [newImage resizedImageToSize:CGSizeMake(320, 427)];
            
            
            NSLog(@"Front Camera Resized Image Orientation:%d",resizedImage.imageOrientation);

            
            self.faceImage = resizedImage;

            
            double delayInSeconds = 0.3;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self performSegueWithIdentifier:@"goToImageView" sender:self];
                [self.captureManager.captureSession stopRunning];

            });


//            
            
        
        
            
        }
        
        else if (!frontCameraIsOn)
        
        {
        
            NSLog(@"Front Camera is not on!");
            
     
            
            UIImage *newImage = [originalImage imageByNormalizingOrientation];
            
            NSLog(@"Back Camera Image Orientation:%d",newImage.
                  imageOrientation);

            UIImage *resizedImage = [newImage resizedImageToSize:CGSizeMake(320, 427)];
            
            
            NSLog(@"Back Camera Resized Image Orientation:%d",resizedImage.imageOrientation);

            
            self.faceImage = resizedImage;

            
            [self performSegueWithIdentifier:@"goToImageView" sender:self];
        }
        
        
        
       
        

    }];
    

}

- (NSUInteger) cameraCount
{
    return [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
}

- (AVCaptureDevice *) cameraWithPosition:(AVCaptureDevicePosition) position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}

- (AVCaptureDevice *) frontFacingCamera
{
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

// Find a back facing camera, returning nil if one is not found
- (AVCaptureDevice *) backFacingCamera
{
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}


- (IBAction)toggleCamera:(id)sender {
    
    BOOL success = NO;
    
    if ([self cameraCount] > 1) {
        NSError *error;
        AVCaptureDeviceInput *newVideoInput;
        AVCaptureDeviceInput *videoInput = [self.captureManager.captureSession.inputs objectAtIndex:0];
        AVCaptureDevicePosition position = [[videoInput device] position];
        
        if (position == AVCaptureDevicePositionBack)
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self frontFacingCamera] error:&error];
    
        else if (position == AVCaptureDevicePositionFront)
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backFacingCamera] error:&error];
        
//        else
//            goto bail;
        
        if (newVideoInput != nil) {
            [self.captureManager.captureSession beginConfiguration];
            [self.captureManager.captureSession removeInput:videoInput];
            if ([self.captureManager.captureSession canAddInput:newVideoInput]) {
                [self.captureManager.captureSession addInput:newVideoInput];
                
                if (newVideoInput.device.position == AVCaptureDevicePositionFront) {
                    frontCameraIsOn = YES;
                }
                else if (newVideoInput.device.position == AVCaptureDevicePositionBack) {
                    frontCameraIsOn = NO;
                }
                
                videoInput = newVideoInput;

                
            } else {
                [self.captureManager.captureSession addInput:videoInput];
            }
            [self.captureManager.captureSession commitConfiguration];
            success = YES;
        }
//        else if (error) {
//            if ([[self delegate] respondsToSelector:@selector(captureManager:didFailWithError:)]) {
//                [[self delegate] captureManager:self didFailWithError:error];
//            }
//        }
//    }
    
//bail:
//    return success;
    }
    

}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([segue.identifier isEqualToString:@"goToImageView"]) {
       
        NSLog(@"The Segue is being called!");
        
        
        ImagePreviewViewController *imagePreviewController = (ImagePreviewViewController *)segue.destinationViewController;
        
        imagePreviewController.faceImage = self.faceImage;
        
        NSLog(@"FaceImage Size:%@",NSStringFromCGSize(self.faceImage.size));
        
        
        
    }
}

-(IBAction)goBackToCameraView:(UIStoryboardSegue *)segue {
    
    //Unwind Segue for ImagePreviewController to use to go back to Camera View
    [self.captureManager.captureSession startRunning];


}







@end
