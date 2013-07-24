//
//  EditViewController.h
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 2/25/13.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface EditViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *faceImageView;
@property (nonatomic, strong) UIImage *faceImage;

@end
