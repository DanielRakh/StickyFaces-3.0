//
//  UIColor+StickyFacesColors.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 7/7/13.
//
//

#import "UIColor+StickyFacesColors.h"


@implementation UIColor (StickyFacesColors)


// Create a color using a string with a webcolor
// ex. [UIColor colorWithHexString:@"#03047F"]
+ (UIColor *) colorWithHexString:(NSString *)hexstr {
    NSScanner *scanner;
    unsigned int rgbval;
    
    scanner = [NSScanner scannerWithString: hexstr];
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt: &rgbval];
    
    return [UIColor colorWithHexValue: rgbval];
}

// Create a color using a hex RGB value
// ex. [UIColor colorWithHexValue: 0x03047F]
+ (UIColor *) colorWithHexValue: (NSInteger) rgbValue {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0
                           green:((float)((rgbValue & 0xFF00) >> 8))/255.0
                            blue:((float)(rgbValue & 0xFF))/255.0
                           alpha:1.0];
    
}

+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha {
    return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:alpha];
}



+ (UIColor *)favoritesViewColor {
    return [UIColor colorWithRed:0.906 green:0.298 blue:0.235 alpha:1.000];

}


+ (UIColor *)cameraViewColor {
//    return [UIColor colorWithRed:0.204 green:0.596 blue:0.859 alpha:1.000];
//    return [UIColor colorWithRed:0.245 green:0.649 blue:0.877 alpha:1.000];
    return [UIColor colorWithR:83 G:190 B:127 A:1.0];
    
}


+ (UIColor *)catalogViewColor {
//    return [UIColor colorWithRed:1.000 green:0.757 blue:0.329 alpha:1.000];
    return [UIColor colorWithRed:0.200 green:0.231 blue:0.263 alpha:1.000];

}

+ (UIColor *)backgroundViewColor {
    
    return [UIColor colorWithRed:0.945 green:0.961 blue:0.976 alpha:1.000];

}

+ (UIColor *)flashCheckViewColor {
    
    return [UIColor colorWithRed:0.180 green:0.800 blue:0.443 alpha:1.000];
    
}


@end
