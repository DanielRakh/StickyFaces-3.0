//
//  ImagePreviewViewController.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 6/25/13.
//
//

#import "ImagePreviewViewController.h"
#import "PointsView.h"
#import "EditViewController.h"
#import "CameraOverlay.h"

@interface ImagePreviewViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) PointsView *pointsView;

@property (weak, nonatomic) IBOutlet UIButton *cropButton;

@end

@implementation ImagePreviewViewController




-(CAShapeLayer *)createTransparentBackground {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.imageView.bounds.size.width, self.imageView.bounds.size.height) cornerRadius:0];
    
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor colorWithWhite:0.902 alpha:0.800].CGColor;
    fillLayer.opacity = 1.0;
    
    return fillLayer;
    
}

-(IBAction)cropFace:(id)sender {
    
    
    CAShapeLayer *transparentBackground = [self createTransparentBackground];
    [self.imageView.layer addSublayer:transparentBackground];
    
    
    UIImage *passedImage = [self maskImage:self.imageView.image toPath:self.pointsView.aPath];
    
    
    [self.pointsView removeFromSuperview];

    
    
    CALayer *faceLayer = [CALayer layer];
    faceLayer.contents = (id)passedImage.CGImage; //Size of Image is 320 x 427
    faceLayer.bounds = CGRectMake(0, 0, self.imageView.bounds.size.width, self.imageView.bounds.size.height);
    faceLayer.position = CGPointMake(CGRectGetMidX(self.imageView.bounds), CGRectGetMidY(self.imageView.bounds));
    faceLayer.shadowColor = [UIColor blackColor].CGColor;
    faceLayer.shadowOpacity = 1.0;
    faceLayer.shadowOffset = CGSizeMake(0, 1.0);
    
    
    
    
    
    [self.imageView.layer addSublayer:faceLayer];
    
    
}





- (UIImage *)maskImage:(UIImage *)originalImage toPath:(UIBezierPath *)path {
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0);
    
    
    
    [[UIColor redColor]setFill];
    [[UIColor whiteColor]setStroke];
    
    path.lineWidth = 16.0;
    
    [path fill];
    [path stroke];
    [path addClip];
    
    [originalImage drawAtPoint:CGPointZero blendMode:kCGBlendModeNormal alpha:1.0];
    
    UIImage *maskedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSLog(@"Masked Image Size:(%f,%f)",maskedImage.size.width,maskedImage.size.height);
    
    //    CAShapeLayer *containerLayer = [CAShapeLayer layer];
    //
    //    UIBezierPath *bPath = [UIBezierPath bezierPathWithCGPath:path.CGPath];
    //    [bPath applyTransform:CGAffineTransformMakeScale(1.1, 1.1)];
    //    containerLayer.path = bPath.CGPath;
    //    containerLayer.fillColor = [UIColor whiteColor].CGColor;
    //    containerLayer.strokeColor = [UIColor blackColor].CGColor;
    
    //    CALayer *imageLayer = [CALayer layer];
    //    imageLayer.frame = CGRectMake(0, 0, maskedImage.size.width, maskedImage.size.height);
    //    imageLayer.contents = (id)maskedImage.CGImage;
    
    //    imageLayer.position = CGPointMake(containerLayer.bounds.size.width/2.0f + 80, containerLayer.bounds.size.height/2.0f + 90);
    
    //    imageLayer.zPosition = 1.0f;
    
    
    //    [containerLayer addSublayer:imageLayer];
    
    //
    //    NSLog(@"self.containerLaeyer.position: %@",NSStringFromCGPoint(containerLayer.position));
    
    
    //    NSLog(@"self.imageLayer.position: %@",NSStringFromCGPoint(imageLayer.position));
    //
    //    NSLog(@"Containerlayerbounds:%@",NSStringFromCGRect(containerLayer.bounds));
    
    
    
    return maskedImage;
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    


    
}

-(void)performUnwindSegue {
        
    [self performSegueWithIdentifier:@"goBackToCameraView" sender:self];
}


-(void)setupElements {
  
    
    CameraOverlay *cameraOverlay = [[CameraOverlay alloc]initWithFrame:self.view.bounds];
    cameraOverlay.userInteractionEnabled = NO;
//    cameraOverlay.opaque = NO;
    
    
    self.pointsView = [[PointsView alloc]initWithImageView:self.imageView];
    self.pointsView.userInteractionEnabled = YES;
    
    
     [self.view addSubview:self.pointsView];

    [self.view addSubview:cameraOverlay];

    
 
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *backButtonImage = [UIImage imageNamed:@"BackToCameraButton"];
    UIImage *backButtonPressedImage = [UIImage imageNamed:@"BackToCameraButtonPressed"];

    
    backButton.frame = CGRectMake(10, 484, backButtonImage.size.width, backButtonImage.size.height);
    
    [backButton setImage:backButtonImage forState:UIControlStateNormal];
    [backButton setImage:backButtonPressedImage forState:UIControlStateHighlighted];

    
    [backButton addTarget:self action:@selector(performUnwindSegue) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backButton];
    
    
    UIButton *repositionPoints = [UIButton buttonWithType:UIButtonTypeCustom];
   
    UIImage *refreshButton = [UIImage imageNamed:@"RefreshButton"];
    repositionPoints.frame = CGRectMake(231, 444, refreshButton.size.width, refreshButton.size.height);
    [repositionPoints setImage:refreshButton forState:UIControlStateNormal];
    [repositionPoints setImage:[UIImage imageNamed:@"RefreshButtonPressed"] forState:UIControlStateHighlighted];
    [repositionPoints addTarget:self
                         action:@selector(resetPoints:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:repositionPoints];
    
    
    [self.view bringSubviewToFront:self.cropButton];
    [self.view bringSubviewToFront:repositionPoints];
    

    

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.imageView.image = self.faceImage;

    
    
    [self setupElements];
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)resetPoints:(id)sender {
    
    [self.pointsView repositionPoints];
    
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    
//    if ([segue.identifier isEqualToString:@"goToEditViewController"]) {
//        
//        UIImage *passedImage = [self maskImage:self.imageView.image toPath:self.pointsView.aPath];
//        
//        EditViewController *editViewController = (EditViewController *)segue.destinationViewController;
//        editViewController.faceImage = passedImage;
//        
//    }
//    
//}


@end
