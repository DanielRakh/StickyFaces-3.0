//
//  AVCamCaptureManager.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 3/12/13.
//
//

#import "AVCamCaptureManager.h"

@implementation AVCamCaptureManager

-(id)init {
    
    self = [super init];
    
    if (self) {
        self.captureSession = [[AVCaptureSession alloc]init];
        self.captureSession.sessionPreset = AVCaptureSessionPreset640x480;
    }
    
    return self;
}



- (void)addVideoPreviewLayer {
    
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    self.previewLayer.videoGravity =AVLayerVideoGravityResizeAspect;

    
}

-(void)addStillImageOutput {
    
    
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc]init];
    NSDictionary *outputSettings = [[NSDictionary alloc]initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    [self.captureSession addOutput:self.stillImageOutput];
}

- (void)addVideoInput {
   
    /*
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if (videoDevice) {
        NSError *error;
        AVCaptureDeviceInput *videoIn = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
        
        if (!error) {
            if ([self.captureSession canAddInput:videoIn]) {
                [self.captureSession addInput:videoIn];
            }
            else {
                NSLog(@"Couldn't add video input");
            }
        }
        else {
            NSLog(@"Couldn't create video input");
        }
        
        
    }
    else {
        NSLog(@"Couldn't create video capture device");
    }

    
    */
    
    
    NSArray *devices = [AVCaptureDevice devices];
    AVCaptureDevice *frontCamera;
    AVCaptureDevice *backCamera;
    
    
    for (AVCaptureDevice *device in devices) {
        

        if ([device hasMediaType:AVMediaTypeVideo]) {
            
            if (device.position == AVCaptureDevicePositionBack) {
            
            backCamera = device;
                
             }
        
        else {
            frontCamera = device;
        }
    }
}
    
    NSError *error = nil;
    
    AVCaptureDeviceInput *frontFacingCameraDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:frontCamera error:&error];
    if (!error) {
        if ([self.captureSession canAddInput:frontFacingCameraDeviceInput]) {
            [self.captureSession addInput:frontFacingCameraDeviceInput];
        }
        else {
            NSLog(@"Couldn't add front facing video input");
        }
    }
    
}

@end
