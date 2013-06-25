//
//  AVCamCaptureManager.h
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 3/12/13.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>

@interface AVCamCaptureManager : NSObject

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;

- (void)addVideoPreviewLayer;
- (void)addVideoInput;
-(void)addStillImageOutput;


@end
