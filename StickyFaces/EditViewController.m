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



@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UIButton *checkMarkButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;



@end

@implementation EditViewController
- (IBAction)goBackToCamera:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if ([UIDevice deviceType] & iPhone5) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background(5).png"]];
    }
    else {
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background(4).png"]];
    }
    
  
    CameraOverlay *overlayView = [[CameraOverlay alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:overlayView];
    
    

    
    
    
    CALayer *faceLayer = [CALayer layer];
    faceLayer.contents = (id)self.faceImage.CGImage; //Size of Image is 320 x 427
    faceLayer.bounds = CGRectMake(0, 0, self.faceImage.size.width, self.faceImage.size.height);
    faceLayer.position = CGPointMake(CGRectGetMidX(self.faceView.bounds), CGRectGetMidY(self.faceView.bounds));
    faceLayer.shadowColor = [UIColor blackColor].CGColor;
    faceLayer.shadowOpacity = 1.0;
    faceLayer.shadowOffset = CGSizeMake(0, 1.0);
    
    [self.faceView.layer addSublayer:faceLayer];
    
    [self.view bringSubviewToFront:self.closeButton];
    [self.view bringSubviewToFront:self.checkMarkButton];

    
}



-(CAShapeLayer *)createTransparentBackground {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.faceView.bounds.size.width, self.faceView.bounds.size.height) cornerRadius:0];

    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor colorWithWhite:0.000 alpha:0.750].CGColor;
    fillLayer.opacity = 0.5;
    
    return fillLayer;
    
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
