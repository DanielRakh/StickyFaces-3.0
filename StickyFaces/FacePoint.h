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


@property (nonatomic, strong) UIView *controlPointView;
@property (nonatomic, strong) UIView *secondControlPointView;
@property (nonatomic, strong) UIView *thirdControlPointView;


@property (nonatomic, weak) id <FacePointDragged> delegate;

@end
