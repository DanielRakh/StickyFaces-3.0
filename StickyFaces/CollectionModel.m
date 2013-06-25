//
//  CollectionModel.m
//  FuckingCollectionView
//
//  Created by Daniel Rakhamimov on 11/24/12.
//  Copyright (c) 2012 Daniel Rakhamimov. All rights reserved.
//

#import "CollectionModel.h"

@implementation CollectionModel

- (id)init {
    
    if (self = [super init]) {
        [self populateSection0Array];
        [self populateSection1Array];
    }
    
    return self;
}



-(void)populateSection0Array {
    
    self.section0face = [[NSMutableArray alloc]initWithCapacity:9];
        
    for (int i = 1; i < 10; i++) {
        NSString *imageString = [NSString stringWithFormat:@"image%d.png", i];
        
        UIImage *faceImage = [UIImage imageNamed:imageString];
        
        [self.section0face addObject:faceImage];
        
    }
    
    NSLog(@"Number of Objects in array are: %d",[self.section0face count]);

    
    self.section0selectedFace = [[NSMutableArray alloc]initWithCapacity:9];
    
    for (int i = 1; i < 10; i++) {
        NSString *imageString = [NSString stringWithFormat:@"image%dHi.png", i];
        
        UIImage *facImage = [UIImage imageNamed:imageString];
        
        [self.section0selectedFace addObject:facImage];
    }
    
    NSLog(@"Number of objects in selected array are: %d",[self.section0selectedFace count]);
    
    
    
    self.section0Array = [[NSMutableArray alloc]initWithObjects:self.section0face,self.section0selectedFace, nil];
    
    NSLog(@"The elements of Section 0 are: %@ and %@",[self.section0Array objectAtIndex:0], [self.section0Array objectAtIndex:1]);
    
}





-(void)populateSection1Array {
    
    self.section1face = [[NSMutableArray alloc]initWithCapacity:9];
    
    for (int i = 10; i < 19; i++) {
        NSString *imageString = [NSString stringWithFormat:@"image%d.png", i];
        
        UIImage *faceImage = [UIImage imageNamed:imageString];
        
        [self.section1face addObject:faceImage];
        
    }
    
    NSLog(@"Number of Objects in array are: %d",[self.section1face count]);
    
    
    self.section1selectedFace = [[NSMutableArray alloc]initWithCapacity:9];
    
    for (int i = 10; i < 19; i++) {
        NSString *imageString = [NSString stringWithFormat:@"image%dHi.png", i];
        
        UIImage *facImage = [UIImage imageNamed:imageString];
        
        [self.section1selectedFace addObject:facImage];
    }
    
    NSLog(@"Number of objects in selected array are: %d",[self.section1selectedFace count]);
    
    
    
    self.section1Array = [[NSMutableArray alloc]initWithObjects:self.section1face,self.section1selectedFace, nil];
    
    NSLog(@"The elements of Section 1 are: %@ and %@",[self.section1Array objectAtIndex:0], [self.section1Array objectAtIndex:1]);
    
}


@end
