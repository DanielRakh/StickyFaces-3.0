//
//  V9Layout.h
//  testProject
//
//  Created by Bogdan Weidmann on 10.04.13.
//  Copyright (c) 2013 nexiles. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol V9LayoutDelegate <UICollectionViewDelegate>

@required

- (BOOL)isDeletionModeActiveForCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout;


@end

@interface V9Layout : UICollectionViewLayout

@property (nonatomic, assign) NSInteger itemsInOneRow;

-(id)initWithItemsInOneRow:(NSInteger)itemsInOneRow;

@end
