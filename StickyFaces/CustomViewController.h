//
//  CustomViewController.h
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 2/23/13.
//
//

#import <UIKit/UIKit.h>

@interface CustomViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>


+ (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSizeWithSameAspectRatio:(CGSize)targetSize;

@end
