//
//  CustomDataModel.h
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 7/28/13.
//
//

#import <Foundation/Foundation.h>

@interface CustomDataModel : NSObject


@property (nonatomic, strong) NSMutableArray *arrayOfFaces;


-(void)removeFaceAtIndexPosition:(int)position;



@end
