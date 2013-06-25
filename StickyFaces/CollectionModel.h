//
//  CollectionModel.h
//  FuckingCollectionView
//
//  Created by Daniel Rakhamimov on 11/24/12.
//  Copyright (c) 2012 Daniel Rakhamimov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionModel : NSObject

@property (nonatomic, strong) NSMutableArray *section0Array;
@property (nonatomic, strong) NSMutableArray *section1Array;
@property (nonatomic, strong) NSMutableArray *section0face;
@property (nonatomic, strong) NSMutableArray *section0selectedFace;
@property (nonatomic, strong) NSMutableArray *section1face;
@property (nonatomic, strong) NSMutableArray *section1selectedFace;

@end

