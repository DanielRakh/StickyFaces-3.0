//
//  EditViewController.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 2/25/13.
//
//

#import "EditViewController.h"
#import "UIImage+Resize.h"


@interface EditViewController ()



@end

@implementation EditViewController
- (IBAction)goBackToCamera:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.faceView.backgroundColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
    
    
    
    
    
    
    CALayer *faceLayer = [CALayer layer];
    faceLayer.contents = (id)self.faceImage.CGImage; //Size of Image is 320 x 427
    faceLayer.bounds = CGRectMake(0, 0, self.faceImage.size.width, self.faceImage.size.height);
    faceLayer.position = CGPointMake(CGRectGetMidX(self.faceView.bounds), CGRectGetMidY(self.faceView.bounds));
    faceLayer.shadowColor = [UIColor blackColor].CGColor;
    faceLayer.shadowOpacity = 1.0;
    faceLayer.shadowOffset = CGSizeMake(0, 1.0);
    
    [self.faceView.layer addSublayer:faceLayer];
    
    
    
    
    
    //
    //    CAShapeLayer *shape = [CAShapeLayer layer];
    //
    //    shape.path = self.facePath.CGPath;
    //
    //    shape.strokeColor = [UIColor blackColor].CGColor;
    //    shape.lineWidth  = 4.0f;
    //
    //    shape.fillColor = [UIColor greenColor].CGColor;
    //    shape.bounds = CGRectMake(0, 0, 320, 427);
    //    shape.position = CGPointMake(CGRectGetMidX(self.faceView.bounds), CGRectGetMidY(self.faceView.bounds));
    //    shape.zPosition = 0.0;
    //    [self.faceView.layer addSublayer:shape];
    
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
