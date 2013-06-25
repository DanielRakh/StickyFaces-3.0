//
//  FaceFlowLayout.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 11/22/12.
//
//

#import "FaceFlowLayout.h"

@implementation FaceFlowLayout



-(void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.itemSize = CGSizeMake(95, 110);
    self.minimumLineSpacing = 3;
    self.minimumInteritemSpacing = 0;
//    self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
}

@end
