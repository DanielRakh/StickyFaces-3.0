//
//  DataModel.h
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 12/13/12.
//
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject


//Returns how many faces are in the array

@property (nonatomic, assign) int faceTag;
@property (nonatomic, strong) NSMutableArray *favorites;


-(int)faceCount;

-(UIImage *)faceAtIndex:(int)index;

-(UIImage *)selectedFaceAtIndex:(int)index;

-(int)favoritesFaceCount;

-(UIImage *)favoriteFaceAtIndex:(int)index;

-(void)addToFavorites:(int)indexPathItem;

-(void)removeFromFavorites:(int)indexPathItem;

-(UIImage *)getImageAtIndex:(int)indexPathItem;

-(UIImage *)getSelectedFaceAtIndex:(int)indexPathItem;

-(UIImage *)getCopyFaceAtIndex:(int)indexPathItem;


@end
