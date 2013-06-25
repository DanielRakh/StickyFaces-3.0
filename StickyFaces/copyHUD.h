//
//  copyHUD.h
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CopyHUD : UIView

+ (id)newHUD;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
