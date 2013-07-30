//
//  CustomDataModel.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 7/28/13.
//
//

#import "CustomDataModel.h"
#import "EditViewController.h"

@interface CustomDataModel ()

@property (nonatomic, strong) NSString *customFacesPath;


@end

@implementation CustomDataModel



// The concept is to have an array that is filled with all of the images in a directory. The array constantly gets updated when a picture is confirmed or deleted.



//The collectionview then calls on the Array to display the image.






-(id)init {
    
    self = [super init];
    
    if (self) {
       
        _customFacesPath = [self createAndReturnDirectoryPathWithName];
        
        _transferArray = [[NSMutableArray alloc]initWithCapacity:9];
        
        [self registerForNotifications];
        
        
        
    }
    return self;
    
}


-(void)registerForNotifications {
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveImageWithData:) name:@"imageSaved" object:nil];
    
    
}


//This method should be called 
-(NSString *)createAndReturnDirectoryPathWithName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //Get the docs directory
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *folderPath = [documentsPath
                            stringByAppendingPathComponent:@"CustomFaces"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath]) {
        
        NSLog(@"There are no files at this folderPath");
    
    [[NSFileManager defaultManager] createDirectoryAtPath:folderPath
                              withIntermediateDirectories:NO attributes:nil error:nil];
}

    
    return folderPath;
    
}






-(UIImage *)retrieveFaceAtIndexPosition:(int)position {

    
    NSString *folderPath = self.customFacesPath;
    NSString *fileName = [self.transferArray objectAtIndex:position];
    
    NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
        
    UIImage *faceImage = [UIImage imageWithContentsOfFile:filePath];
   
    return faceImage;
    
}



#pragma mark - Edit View Controller Delegate Method

-(void)saveImageWithData:(NSNotification *)notifcation {

    //Get the path in the documents directory
    NSString *folderPath = self.customFacesPath;
    
    
    
    //Check if there are any files within the actual path
    NSArray *contentsOfDirectory = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:folderPath error:nil];
    
    NSData *imageData = [notifcation.userInfo valueForKey:@"faceKey"];
    
    
    if (contentsOfDirectory.count < 1) {
        NSLog(@"Array is empty. ");
        
        
        NSString *filePath = [folderPath stringByAppendingPathComponent:[@"faceImage0" stringByAppendingFormat:@"%@",@"@2x.png"]];
        
        [imageData writeToFile:filePath atomically:YES];
            
        contentsOfDirectory =  [[NSFileManager defaultManager]contentsOfDirectoryAtPath:folderPath error:nil];
        
        NSLog(@"The contents directory initially:%@", contentsOfDirectory);

        
        //Initialize the local array of faces
        
        
        [self.transferArray insertObject:[contentsOfDirectory objectAtIndex:0] atIndex:0];
        
        
    }
    else if (contentsOfDirectory.count  >= 1) {
        
        int newFileInteger = contentsOfDirectory.count;
        
        
        NSString *newPathName = [NSString stringWithFormat:@"faceImage%d",newFileInteger];
        
        
        NSString *filePath = [folderPath stringByAppendingPathComponent:[newPathName stringByAppendingFormat:@"%@",@"@2x.png"]];
        
        
        [imageData writeToFile:filePath atomically:YES];
        
        
        contentsOfDirectory = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:folderPath error:nil];
        
        contentsOfDirectory = [contentsOfDirectory sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:[obj2 description] options:NSNumericSearch];
        }];
        
        
        [self.transferArray addObject:[contentsOfDirectory objectAtIndex:contentsOfDirectory.count-1]];
        
        NSLog(@"The contents Directory:%@", contentsOfDirectory);
        
    }

    
}



















@end