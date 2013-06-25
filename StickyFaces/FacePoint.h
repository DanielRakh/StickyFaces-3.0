//
//  FacePoint.h
//  TranslationTest
//
//  Created by Daniel Rakhamimov on 5/1/13.
//  Copyright (c) 2013 Daniel Rak. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FacePointDragged <NSObject>

-(void)refreshView;

@end


@interface FacePoint : UIView




@property (nonatomic) CGPoint origC;
@property (nonatomic) CGPoint delta;

@property (nonatomic, weak) id <FacePointDragged> delegate;

@end
