//
//  LogoViewController.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 2/5/13.
//
//

#import "LogoViewController.h"
#import "UIViewController+RECurtainViewController.h"
#import "TutorialView.h"
#import "MyUnwindSegue.h"
#import "UIDevice+Resolutions.h"

@interface LogoViewController ()

@end

@implementation LogoViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
}


-(void)awakeFromNib {
    
    if ([UIDevice deviceType] & iPhone5) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LogoBackground(5).png"]];
    }

    else  {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LogoBackground(4).png"]];
    }
    
    
    UIImage *unPressedButton = [UIImage imageNamed:@"LogoButton.png"];
    UIImage *pressedButton = [UIImage imageNamed:@"LogoButtonPressed.png"];
    UIImage *closeButtonImage = [UIImage imageNamed:@"CloseButton.png"];
    
    
    
    
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.frame = CGRectMake(0,0 ,unPressedButton.size.width, unPressedButton.size.height);
    firstButton.center = CGPointMake(self.view.center.x, self.view.center.y + 8);
    [firstButton setImage:unPressedButton forState:UIControlStateNormal];
    [firstButton setImage:pressedButton forState:UIControlStateHighlighted | UIControlStateSelected];
    
    firstButton.showsTouchWhenHighlighted = NO;
    firstButton.selected = YES;
    firstButton.enabled = YES;
    firstButton.tag = 1;
    [firstButton addTarget:self action:@selector(openHorizontalPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(5, 5, closeButtonImage.size.width, closeButtonImage.size.height);
    [closeButton setBackgroundImage:closeButtonImage forState:UIControlStateNormal];
    closeButton.showsTouchWhenHighlighted = YES;
    [closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:firstButton];
    [self.view addSubview:closeButton];
}

-(void)openHorizontalPressed:(id)sender {

    
    [self performSegueWithIdentifier:@"LVCustomSegue" sender:self];

}

-(void)dismiss {

    [[UIApplication sharedApplication]setStatusBarHidden:NO];

    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}



@end
