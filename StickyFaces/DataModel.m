//
//  DataModel.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 12/13/12.
//
//

#define NUMBER_OF_FACES 85
#import "DataModel.h"

static NSString *const FAVORITES_KEY = @"Favorites";
static NSString *const SELECTED_FAVORITES = @"SelectedFavorites";
static NSString *const COPY_FACES = @"CopyFaces";


@interface DataModel ()

@property (nonatomic, strong) NSMutableArray *faces;

@property (nonatomic, strong) NSMutableArray *selectedFaces;

@property (nonatomic, strong) NSMutableArray *selectedFavorites;

@property (nonatomic, strong) NSMutableArray *copiedFaces;

@property (nonatomic, strong) NSMutableArray *customFaces; 

@end


@implementation DataModel

- (id)init {
    
    self = [super init];
    if (self) {
        _faces = [[NSMutableArray alloc]initWithCapacity:NUMBER_OF_FACES];
        
        for (int i = 1; i<NUMBER_OF_FACES; i++) {
            
            NSString *imageString = [NSString stringWithFormat:@"image%d@2x",i];
            
            UIImage *faceImage = [self formatFaceImageForButtonWithName:imageString];
            
            [_faces addObject:faceImage];
            
        }
        

        
        _selectedFaces = [[NSMutableArray alloc]initWithCapacity:NUMBER_OF_FACES];
        
        for (int i = 1; i<NUMBER_OF_FACES; i++) {
            
            NSString *imageString = [NSString stringWithFormat:@"image%dHi@2x",i];
            
            UIImage *faceImage = [self formatFaceImageForButtonWithName:imageString];
            
            [_selectedFaces addObject:faceImage];
        }
        
      
        
        NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:FAVORITES_KEY];
        _favorites = [NSMutableArray arrayWithArray:array];
        
        NSArray *favoritesArray = [[NSUserDefaults standardUserDefaults]objectForKey:SELECTED_FAVORITES];
        _selectedFavorites = [NSMutableArray arrayWithArray:favoritesArray];
        
        NSArray *copyArray = [[NSUserDefaults standardUserDefaults]objectForKey:COPY_FACES];
        _copiedFaces = [NSMutableArray arrayWithArray:copyArray];
        
        
        
    }
    
    return self;
}





-(UIImage *)formatFaceImageForButtonWithName:(NSString *)string {
    
    NSString *imageString = [NSString stringWithString:string];
    NSString* path = [[NSBundle mainBundle] pathForResource:imageString ofType:@"png" inDirectory:nil];
    
    
    UIImage *productImage = [UIImage imageWithContentsOfFile:path];
    
    
    
    CGSize imageSize = productImage.size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    [productImage drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    productImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return productImage;
    
    
}


-(int)faceCount {
    return self.faces.count;
    
}

-(UIImage *)faceAtIndex:(int)index {
    
    return [self.faces objectAtIndex:index];
    
}

-(UIImage *)selectedFaceAtIndex:(int)index {
    
    return [self.selectedFaces objectAtIndex:index];
    
    
}



-(int)favoritesFaceCount {
    
    return [self.favorites count];
    
}

-(UIImage *)favoriteFaceAtIndex:(int)index {
    
    
    return [self.favorites objectAtIndex:index];
    
}



-(void)addToFavorites:(int)indexPathItem {

    
    NSString *imageString = [NSString stringWithFormat:@"image%d@2x",indexPathItem+1];
    
    NSString *favoriteString = [NSString stringWithFormat:@"image%dHi@2x",indexPathItem + 1];
    
    NSString *copyString = [NSString stringWithFormat:@"sticky%d@2x",indexPathItem + 1];
    
    if (![self.favorites containsObject:imageString]) {
    
    [self.favorites addObject:imageString];
    [self.selectedFavorites addObject:favoriteString];
    [self.copiedFaces addObject:copyString];
    
    [[NSUserDefaults standardUserDefaults]setObject:self.favorites forKey:FAVORITES_KEY];
    
    [[NSUserDefaults standardUserDefaults]setObject:self.selectedFavorites forKey:SELECTED_FAVORITES];
    
    [[NSUserDefaults standardUserDefaults]setObject:self.copiedFaces forKey:COPY_FACES];
    
    [[NSUserDefaults standardUserDefaults]synchronize];

    }
}

-(void)removeFromFavorites:(int)indexPathItem {
    
   NSString *imageString = [self.favorites objectAtIndex:indexPathItem];
   
   NSString *favoriteString = [self.selectedFavorites objectAtIndex:indexPathItem];
    
   NSString *copyString = [self.copiedFaces objectAtIndex:indexPathItem];
    

    
    
    [self.favorites removeObject:imageString];
    [self.selectedFavorites removeObject:favoriteString];
    [self.copiedFaces removeObject:copyString];

    
    [[NSUserDefaults standardUserDefaults]setObject:self.favorites forKey:FAVORITES_KEY];
    
    [[NSUserDefaults standardUserDefaults]setObject:self.selectedFavorites forKey:SELECTED_FAVORITES];
    
    [[NSUserDefaults standardUserDefaults]setObject:self.copiedFaces forKey:COPY_FACES];
    
    
    [[NSUserDefaults standardUserDefaults]synchronize];
}


-(UIImage *)getImageAtIndex:(int)indexPathItem {
    
  NSArray *favoritesArray = [NSArray arrayWithArray:(NSMutableArray *)[[NSUserDefaults standardUserDefaults]objectForKey:FAVORITES_KEY]];
    
    NSString *imageString = [favoritesArray objectAtIndex:indexPathItem];
    
    UIImage *faceImage = [self formatFaceImageForButtonWithName:imageString];
    
    
    return faceImage;
    
}

-(UIImage *)getSelectedFaceAtIndex:(int)indexPathItem {
    
    
    
    NSArray *favoritesArray = [NSArray arrayWithArray:(NSMutableArray *)[[NSUserDefaults standardUserDefaults]objectForKey:SELECTED_FAVORITES]];
    
    NSString *imageString = [favoritesArray objectAtIndex:indexPathItem];
    

    UIImage *faceImage = [self formatFaceImageForButtonWithName:imageString];
    
    
    
    return faceImage;
    
}



-(UIImage *)getCopyFaceAtIndex:(int)indexPathItem {
    
    
    
    NSArray *favoritesArray = [NSArray arrayWithArray:(NSMutableArray *)[[NSUserDefaults standardUserDefaults]objectForKey:COPY_FACES]];
    
    NSString *imageString = [favoritesArray objectAtIndex:indexPathItem];
    
    
    UIImage *faceImage = [self formatFaceImageForButtonWithName:imageString];

    
    
    return faceImage;
}


@end
