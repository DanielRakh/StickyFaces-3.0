//
//  TutorialView.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 1/29/13.
//
//

#import "TutorialView.h"
#import "UIViewController+RECurtainViewController.h"
#import "UIDevice+Resolutions.h"

static NSUInteger kNumberOfPages = 4;

@interface TutorialView ()
{
    
    CGRect firstScreen;
    CGRect secondScreen;
    CGRect thirdScreen;
    CGRect fourthScreen;
 
    
    UIImage *upArrowImage;
    UIImage *downArrowImage;

    
}
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *tutorialImages;

@end

@implementation TutorialView


-(id)init {
    
    self = [super init];
    if (self) {
        [self awakeFromNib];
    }
    
    return self;
}





-(void)loadScrollViewWithPage:(int)page {
    
    if (page < 0) {
        return;
    }
    if (page>=kNumberOfPages) {
        return;
    }
    
    
    UIImageView *imageView = [self.tutorialImages objectAtIndex:page];
    
    if ((NSNull *)imageView == [NSNull null]) {
        CGRect frame = self.scrollView.frame;
        frame.origin.x =0;
        frame.origin.y = frame.size.height * page;

        imageView = [[UIImageView alloc]initWithFrame:frame];
   
    
        if ([UIDevice deviceType] & iPhone5) {
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Tutorial%d(5).png", page +1]];
        }
        else {
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Tutorial%d(4).png", page+1]];
        }
        
        imageView.tag = page;
        [self.tutorialImages replaceObjectAtIndex:page withObject:imageView];
        
    }
    
      [self.scrollView addSubview:imageView];


    switch (imageView.tag) {

        case 0:
        {
            
            firstScreen = imageView.frame;
            
            UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
            if ([UIDevice deviceType] &iPhone5) {
                secondButton.frame = CGRectMake(10, 500, downArrowImage.size.width, downArrowImage.size.height);

            } else {
        
            secondButton.frame = CGRectMake(10, 420, downArrowImage.size.width, downArrowImage.size.height);
            }
            
            
            [secondButton setBackgroundImage:downArrowImage forState:UIControlStateNormal];
            secondButton.userInteractionEnabled = YES;
            secondButton.showsTouchWhenHighlighted = YES;
            secondButton.tag =  1;
            [secondButton addTarget:self action:@selector(scrollDown:) forControlEvents:UIControlEventTouchUpInside];

            [imageView addSubview:secondButton];
            [imageView setUserInteractionEnabled:YES];
        }
        
            break;
            
        case 1:
        {
            secondScreen = imageView.frame;
            
            UIButton *thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if ([UIDevice deviceType] &iPhone5) {
                thirdButton.frame = CGRectMake(10, 500, downArrowImage.size.width, downArrowImage.size.height);

            } else {
                
            thirdButton.frame = CGRectMake(10, 420, downArrowImage.size.width, downArrowImage.size.height);
                
            }
            
            [thirdButton setBackgroundImage:downArrowImage forState:UIControlStateNormal];
            thirdButton.userInteractionEnabled = YES;
            thirdButton.showsTouchWhenHighlighted = YES;
            thirdButton.tag =  2;
            [thirdButton addTarget:self action:@selector(scrollDown:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *fourthButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if ([UIDevice deviceType] & iPhone5) {
            fourthButton.frame = CGRectMake(10, 200, upArrowImage.size.width, upArrowImage.size.height);

            }
            else {
            fourthButton.frame = CGRectMake(10, 140, upArrowImage.size.width, upArrowImage.size.height);
            }
            [fourthButton setBackgroundImage:upArrowImage forState:UIControlStateNormal];
            fourthButton.userInteractionEnabled = YES;
            fourthButton.showsTouchWhenHighlighted = YES;
            fourthButton.tag =  4;
            [fourthButton addTarget:self action:@selector(scrollDown:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [imageView addSubview:thirdButton];
            [imageView addSubview:fourthButton];
            
            [imageView setUserInteractionEnabled:YES];
        }
            break;
        
        case 2:
        
        {
            thirdScreen = imageView.frame;
            UIImage *unPressedButton = [UIImage imageNamed:@"AndThenNormal.png"];
            UIImage *pressedButton = [UIImage imageNamed:@"AndThenPressed.png"];
            
            UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if ([UIDevice deviceType] & iPhone5) {
                firstButton.frame = CGRectMake(65, 480, unPressedButton.size.width, unPressedButton.size.height);

            } else {
            
            firstButton.frame = CGRectMake(65, 400, unPressedButton.size.width, unPressedButton.size.height);
            }
            
            
            [firstButton setImage:unPressedButton forState:UIControlStateNormal];
            [firstButton setImage:pressedButton forState:UIControlStateHighlighted | UIControlStateSelected];
            firstButton.tag = 3;
            [firstButton addTarget:self action:@selector(scrollDown:) forControlEvents:UIControlEventTouchUpInside];
            firstButton.showsTouchWhenHighlighted = NO;
            firstButton.selected = YES;
            firstButton.enabled = YES;
            
            [imageView addSubview:firstButton];
            [imageView setUserInteractionEnabled:YES];


            
        }
        
            break;
        
        case 3:
        {
            fourthScreen = imageView.frame;
            UIImage *unPressedButton = [UIImage imageNamed:@"GotItNormal.png"];
            UIImage *pressedButton = [UIImage imageNamed:@"GotItPressed.png"];
            UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if ([UIDevice deviceType] & iPhone5) {

            firstButton.frame = CGRectMake(65, 480, unPressedButton.size.width, unPressedButton.size.height);
            }
            else {
                firstButton.frame = CGRectMake(65, 400, unPressedButton.size.width, unPressedButton.size.height);

            }
            [firstButton setImage:unPressedButton forState:UIControlStateNormal];
            [firstButton setImage:pressedButton forState:UIControlStateHighlighted | UIControlStateSelected];
            [firstButton addTarget:self action:@selector(dismissLast:) forControlEvents:UIControlEventTouchUpInside];
            firstButton.showsTouchWhenHighlighted = NO;
            firstButton.selected = YES;
            firstButton.enabled = YES;
            
            [imageView addSubview:firstButton];
            [imageView setUserInteractionEnabled:YES];

        }
            
            break;
            
        default:
        {
            NSLog(@"Nothing");
        }
            break;
    }
    
    
    
}


-(void)dismissLast:(id)sender {
    
    [self performSegueWithIdentifier:@"myUnwindSegue" sender:self];
}


-(void)scrollDown:(UIButton *)sender {
    
 
    switch (sender.tag) {
        case 1:
        {//This is the left bottom arrow on the first page 
            [self.scrollView scrollRectToVisible:secondScreen animated:YES];
            [self loadScrollViewWithPage:2];
        }
            break;
        
        case 2: // This is the left bottom arrow on the second page
        {
            [self.scrollView scrollRectToVisible:thirdScreen animated:YES];
            [self loadScrollViewWithPage:3];
        }
        
            break;
        case 3: //This is the right button the third page.
        {
            [self.scrollView scrollRectToVisible:fourthScreen animated:YES];
        }
            break;
        
        case 4://This is the top button on the second page.
        {
            [self.scrollView scrollRectToVisible:firstScreen animated:YES];
        }
            
        default:
        {
            NSLog(@"FAILED SCROLL RIGHt METHOD");
        }
            break;
    }
}



-(void)awakeFromNib {
    
    
    NSMutableArray *theArray = [NSMutableArray array];
    for (unsigned i = 0; i < kNumberOfPages; i++) {
        [theArray addObject:[NSNull null]];
    }
    self.tutorialImages = theArray;
    
    
    upArrowImage = [UIImage imageNamed:@"UpArrow.png"];
    downArrowImage = [UIImage imageNamed:@"DownArrow.png"];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height * kNumberOfPages);
    self.scrollView.delegate = self;
    
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];

    
   
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}












@end
