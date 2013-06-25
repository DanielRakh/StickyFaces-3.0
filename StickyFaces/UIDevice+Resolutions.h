//
//  UIDevice+Resolutions.m
//  Simple UIDevice Category for handling different iOSs hardware resolutions
//
//  Created by Daniele Margutti on 9/13/12.
//  web: http://www.danielemargutti.com
//  mail: daniele.margutti@gmail.com
//  Copyright (c) 2012 Daniele Margutti. All rights reserved.
//  Improvements by Evan Schoenberg (www.regularrateandrhythm.com). No rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Screen)
typedef enum
{
    iPhone          = 1 << 1,
    iPhoneRetina    = 1 << 2,
    iPhone5         = 1 << 3,
    iPad            = 1 << 4,
    iPadRetnia      = 1 << 5
    
} DeviceType;

+ (DeviceType)deviceType;
@end


