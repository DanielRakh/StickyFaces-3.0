//
//  Translation.h
//  TranslationTest
//
//  Created by Daniel Rakhamimov on 4/29/13.
//  Copyright (c) 2013 Daniel Rak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacePoint.h"


@interface PointsView : UIView <FacePointDragged>

-(id)initWithImageView:(UIImageView *)imageView;

-(void)repositionPoints;

@end
