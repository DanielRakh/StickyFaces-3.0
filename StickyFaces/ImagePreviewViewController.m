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


@interface ImagePreviewViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) PointsView *pointsView;


@end

@implementation ImagePreviewViewController

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
    
    self.imageView.image = self.faceImage;


    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.pointsView = [[PointsView alloc]initWithImageView:self.imageView];
    
    [self.view addSubview:self.pointsView];
    
    
    
    
    
    
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
    
    
    if ([segue.identifier isEqualToString:@"goToEditViewController"]) {
        
        UIImage *passedImage = [self maskImage:self.imageView.image toPath:self.pointsView.aPath];
        
        EditViewController *editViewController = (EditViewController *)segue.destinationViewController;
        editViewController.faceImage = passedImage;
        
    }
    
}


@end
