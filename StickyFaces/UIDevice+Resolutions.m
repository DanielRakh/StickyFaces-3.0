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

#import "UIDevice+Resolutions.h"

@implementation UIDevice (Screen)


+ (DeviceType)deviceType
{
    DeviceType thisDevice = 0;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        thisDevice |= iPhone;
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)])
        {
            thisDevice |= iPhoneRetina;
            if ([[UIScreen mainScreen] bounds].size.height == 568)
                thisDevice |= iPhone5;
        }
    }
    else
    {
        thisDevice |= iPad;
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)])
            thisDevice |= iPadRetnia;
    }
    return thisDevice;
}



@end