//
//  EditViewController.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 2/25/13.
//
//

#import "EditViewController.h"
#import "JBCroppableView.h"
#import <QuartzCore/QuartzCore.h>

@interface EditViewController ()



@end

@implementation EditViewController
- (IBAction)goBackToCamera:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {

    }
    return self;
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


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    self.editImageView.image = self.passedImage;
//      self.editImageView.frame = [JBCroppableView scaleRespectAspectFromRect1:CGRectMake(0, 0, self.editImageView.image.size.width, self.editImageView.image.size.height) toRect2:self.editImageView.frame];
    
    
    
    
}







@end
