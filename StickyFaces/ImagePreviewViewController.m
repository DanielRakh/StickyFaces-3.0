//
//  ImagePreviewViewController.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 6/25/13.
//
//

#import "ImagePreviewViewController.h"
#import "PointsView.h"


@interface ImagePreviewViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) PointsView *pointsView;
@end

@implementation ImagePreviewViewController


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    self.imageView.image = self.faceImage;


    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.pointsView = [[PointsView alloc]initWithImageView:self.imageView];
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)resetPoints:(id)sender {
    
    [self.pointsView repositionPoints];
    
}

- (IBAction)cropTapped:(id)sender {
    
    //    self.faceImageView.image = [self.pointsView deleteBackgroundOfImage:self.faceImageView];
}


@end
