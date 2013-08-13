//
//  CustomDataModel.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 7/28/13.
//
//

#import "CustomDataModel.h"
#import "EditViewController.h"
#import "UIImage+Resize.h"


@interface CustomDataModel ()

@property (nonatomic, strong) NSString *customFacesPath;

@property (nonatomic, strong) NSMutableArray *filePathArray; 



@end

@implementation CustomDataModel



-  (NSString *)getUniqueFilenameInFolder:(NSString *)folder forFileExtension:(NSString *)fileExtension {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *existingFiles = [fileManager contentsOfDirectoryAtPath:folder error:nil];
    NSString *uniqueFilename;
    
    do {
        CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
        CFStringRef newUniqueIdString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
        
        uniqueFilename = [[folder stringByAppendingPathComponent:(__bridge NSString *)newUniqueIdString] stringByAppendingPathExtension:fileExtension];
        
        CFRelease(newUniqueId);
        CFRelease(newUniqueIdString);
    } while ([existingFiles containsObject:uniqueFilename]);
    
    return uniqueFilename;
}


-(void)createPlist {
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"CustomFacePaths.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:path]) {
        NSString *bundle = [[NSBundle mainBundle]pathForResource:@"CustomFacePaths" ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath:path error:&error];
        if (error) {
            NSLog(@"There was an error copying the plist from the bundle to the directory:%@",error);
        }
    }
}

-(NSString *)returnPathForPlist {
    
    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    destPath = [destPath stringByAppendingPathComponent:@"CustomFacePaths.plist"];
    
    // If the file doesn't exist in the Documents Folder, copy it.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:destPath]) {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"CustomFacePaths" ofType:@"plist"];
        [fileManager copyItemAtPath:sourcePath toPath:destPath error:nil];
    }
 
    return destPath;
}


-(id)init {
    
    self = [super init];
    
    if (self) {
        
       
        [self createPlist];

        //This returns a path to the directory where all images will be stored.
        _customFacesPath = [self createAndReturnDirectoryPathWithName];
        
        
        _arrayOfFaces = [[NSMutableArray alloc]initWithCapacity:9];
  
        [self registerForNotifications];
        
        [self createImagesFromPaths];

    }
    return self;
    
}



-(void)createImagesFromPaths {
    
    
    
    
    NSString *plistPath = [self returnPathForPlist];
    self.filePathArray = [NSMutableArray arrayWithContentsOfFile:plistPath];

    
    if (self.filePathArray.count >= 1) {
    
    
    [self.filePathArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filePath = obj;
        
        UIImage *faceImage = [UIImage imageWithContentsOfFile:filePath];
        [self.arrayOfFaces addObject:faceImage];
        
    }];
        
    }
    
    NSLog(@"Contents of self.arrayOffaces:%@",[self.arrayOfFaces description]);

}



-(void)registerForNotifications {
    
    //Fires off a selector upon notification "faceWasInserted". 
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveImageWithData:) name:@"faceWasInserted" object:nil];
    
}


//This method should be called 
-(NSString *)createAndReturnDirectoryPathWithName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //Get the docs directory
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *folderPath = [documentsPath stringByAppendingPathComponent:@"CustomFaces"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath]) {
        
        NSLog(@"There are no files at this folderPath");
    
    [[NSFileManager defaultManager] createDirectoryAtPath:folderPath
                              withIntermediateDirectories:NO attributes:nil error:nil];
}

    
    return folderPath;
    
}



#pragma mark - Edit View Controller Delegate Method

-(void)saveImageWithData:(NSNotification *)notifcation {

    //Get the path in the documents directory
    NSString *folderPath = self.customFacesPath;
    
    //Get the data (image) that was passed with the notification posted in "EditViewController".
    NSData *imageData = [notifcation.userInfo valueForKey:@"faceKey"];

        NSString *filePath = [self getUniqueFilenameInFolder:folderPath forFileExtension:@"png"];
    
        [self.filePathArray addObject:filePath];
   
    
    
        NSLog(@"The filePath is: %@", filePath);
    
    

    
    
        //Save image to file.
        [imageData writeToFile:filePath atomically:YES];
        

        UIImage *faceImage = [UIImage imageWithContentsOfFile:filePath];

        [self.arrayOfFaces addObject:faceImage];
    
        NSLog(@"ArrayOFfacesContents:%@",[self.arrayOfFaces description]);

    
    
    
        NSString *plistPath = [self returnPathForPlist];
        [self.filePathArray writeToFile:plistPath atomically:YES];
    
}


-(void)removeFaceAtIndexPosition:(int)position {
    
    NSString *pathToBeRemoved = [self.filePathArray objectAtIndex:position];
  
    NSError *newError = nil;
    [[NSFileManager defaultManager] removeItemAtPath:pathToBeRemoved error:&newError];

    
    [self.filePathArray removeObjectAtIndex:position];
    [self.arrayOfFaces removeObjectAtIndex:position];
    NSLog(@"The Contents of self.arrayOfFaces after deletion:%@",[self.arrayOfFaces description]);
    
    
    NSString *plistPath = [self returnPathForPlist];
    [self.filePathArray writeToFile:plistPath atomically:YES];

    
    
}


-(UIImage *)getCopyFaceAtIndex:(int)indexPath {
    
    UIImage *faceImage = [self.arrayOfFaces objectAtIndex:indexPath];
    
    NSLog(@"Size of faceImageBefore Copy:%@",NSStringFromCGSize(faceImage.size));
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(faceImage.size.width, faceImage.size.height), NO, 0);
    [faceImage drawAtPoint:CGPointMake(-10, -60)];

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();


    UIGraphicsEndImageContext();
    
//    UIImage *scaledImage = [faceImage resizedImageToSize:CGSizeMake(faceImage.size.width/4, faceImage.size.height/4)];
    
//    NSLog(@"Scaled Image Size:(%f,%f)",scaledImage.size.width,scaledImage.size.height);
    
    return newImage;
    
    
    
    
    
}




@end