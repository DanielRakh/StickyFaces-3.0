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
#import "UIImage+Resize.h"
#import "UIColor+StickyFacesColors.h"

@interface ImagePreviewViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) PointsView *pointsView;

@property (weak, nonatomic) IBOutlet UIButton *cropButton;
@property (weak, nonatomic) IBOutlet UIButton *backToCamButton;
@property (weak, nonatomic) IBOutlet UIButton *resetPointsButton;


@property (nonatomic, strong) UIImage *croppedImage;

@end

@implementation ImagePreviewViewController




-(CAShapeLayer *)createTransparentBackground {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.imageView.bounds.size.width, self.imageView.bounds.size.height) cornerRadius:0];
    
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor whiteColor].CGColor;
    fillLayer.opacity = 0.30;
    
    return fillLayer;
    
}


-(UIImage *)renderImageFromLayer:(CALayer *)layer {
    
    UIGraphicsBeginImageContextWithOptions(layer.bounds.size, NO, [UIScreen mainScreen].scale);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *renderedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return renderedImage;
    
}


-(IBAction)cropFace:(id)sender {
    
    
//    CAShapeLayer *transparentBackground = [self createTransparentBackground];
//    [self.imageView.layer addSublayer:transparentBackground];
    
    
    
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
    
    
    self.croppedImage = [self renderImageFromLayer:faceLayer];

    
    [self performSegueWithIdentifier:@"goToEditView" sender:self];
    
    
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
    

    
    
    return maskedImage;
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    


    
}
- (IBAction)performUnwindSegue:(id)sender {
    
    [self performSegueWithIdentifier:@"goBackToCameraView" sender:self];

}


-(void)setupElements {
  

    
    self.pointsView = [[PointsView alloc]initWithImageView:self.imageView];
    self.pointsView.userInteractionEnabled = YES;
    
    
     [self.view addSubview:self.pointsView];
    
    
    [self.view bringSubviewToFront:self.cropButton];
    [self.view bringSubviewToFront:self.resetPointsButton];
    [self.view bringSubviewToFront:self.backToCamButton];
    

    

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.imageView.image = self.faceImage;

    
    UIView *bottomBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 427, 320, CGRectGetMaxY(self.view.bounds)- 427)];
    bottomBarView.backgroundColor = [UIColor cameraViewColor];
    [self.view addSubview:bottomBarView];
    
    
    [self setupElements];
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)resetPoints:(id)sender {
    
    [self.pointsView repositionPoints];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([segue.identifier isEqualToString:@"goToEditView"]) {
        
  
        
        EditViewController *editViewController = (EditViewController *)segue.destinationViewController;
        editViewController.faceImage = self.croppedImage;
        
    }
    
}


@end
