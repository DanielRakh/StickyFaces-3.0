//
//  SpringBoardLayoutAttributes.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 12/7/12.
//
//

#import "SpringBoardLayoutAttributes.h"

@implementation SpringBoardLayoutAttributes

- (id)copyWithZone:(NSZone *)zone
{
    SpringBoardLayoutAttributes *attributes = [super copyWithZone:zone];
    attributes.deleteButtonHidden = _deleteButtonHidden;
    return attributes;
}

@end
