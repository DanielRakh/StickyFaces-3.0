//
// UIViewController+RECurtainViewController.m
//
// Copyright (c) 2012 Roman Efimov (http://github.com/romaonthego)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "UIViewController+RECurtainViewController.h"
#import "StickyFacesAppDelegate.h"

@implementation UIViewController (RECurtainViewController)

- (UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)curtainRevealViewController:(UIViewController *)viewControllerToReveal withPresentingViewController:(UIViewController *)viewControllerToPresent andTransitionStyle:(RECurtainTransitionStyle)transitionStyle andIsUnwinding:(BOOL)unwinding
{
    StickyFacesAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    
    //Create Snapshot of the window. 
    UIImage *selfPortrait = [self imageWithView:appDelegate.window];
    
    //Create Snapshot of the Destination View Controller
    UIImage *controllerScreenshot = [self imageWithView:viewControllerToReveal.view];
    
    
    //Create a view that has the same frame as the snapshot of the window
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, selfPortrait.size.width, selfPortrait.size.height)];
//    coverView.backgroundColor = [UIColor colorWithRed:74.0 green:74.0 blue:74.0 alpha:1.0];
    coverView.backgroundColor = [UIColor blackColor];

    
    //Add this View to the TOP of the App Window.  //This is the View that user sees the animations take place on. 
    [appDelegate.window addSubview:coverView];
    
    
    //Create an offset of "20pts" but if the height of image of the destination VC is equal to the height of the actual screen of your device there is no offset.
    int offset = 20;
    if (controllerScreenshot.size.height == [UIScreen mainScreen].bounds.size.height) {
        offset = 0;
    }
    
    
    //Create padding that is 10% of the width of the screen. So that would be "32 pts"
    float padding = [UIScreen mainScreen].bounds.size.width * 0.1;
    
    
    //Create an imageView with the image of the destination VC at a frame of (32,32, 266, 484) and give it a 40% opactiy and add it as a subview of the CoverView. 
    UIImageView *fadedView = [[UIImageView alloc] initWithFrame:CGRectMake(padding, padding + offset, controllerScreenshot.size.width - padding * 2, controllerScreenshot.size.height - padding * 2 - 20)];
    fadedView.image = controllerScreenshot;
    fadedView.alpha = 0.4;
    [coverView addSubview:fadedView];
    
    
    //Create an ImageView with the image of the App Window. 
    UIImageView *leftCurtain = [[UIImageView alloc] initWithFrame:CGRectNull];
    leftCurtain.image = selfPortrait;
    leftCurtain.clipsToBounds = YES;
    
    
    //Create an ImageView with the image of the App Window. 
    UIImageView *rightCurtain = [[UIImageView alloc] initWithFrame:CGRectNull];
    rightCurtain.image = selfPortrait;
    rightCurtain.clipsToBounds = YES;
    
    
    //For The Vertical Transition the LeftCurtain ImageView content mode is set to Left,
    //the frame is set Origin and a width of half of the App Window Size and a height of the App Window.
    
    if (transitionStyle == RECurtainTransitionVertical) {
        leftCurtain.contentMode = UIViewContentModeLeft;
        leftCurtain.frame = CGRectMake(0, 0, selfPortrait.size.width / 2, selfPortrait.size.height);
        
        //The RightCurtain Imageview is set to "Right". With an 
        rightCurtain.contentMode = UIViewContentModeRight;
        rightCurtain.frame = CGRectMake(selfPortrait.size.width / 2, 0, selfPortrait.size.width / 2, selfPortrait.size.height);
    } else {
        leftCurtain.contentMode = UIViewContentModeTop;
        leftCurtain.frame = CGRectMake(0, 0, selfPortrait.size.width, selfPortrait.size.height / 2);
        rightCurtain.contentMode = UIViewContentModeBottom;
        rightCurtain.frame = CGRectMake(0, selfPortrait.size.height / 2, selfPortrait.size.width, selfPortrait.size.height / 2);
    }
    
    
    [coverView addSubview:leftCurtain];
    [coverView addSubview:rightCurtain];
    
    //So Now CoverView has 3 Subviews. An ImageView (FadedView) of the destinationVC and the two curtain ImageViews.
    
    
    //So we animate the frame property of the two Curtain ImageViews. 
    [UIView animateWithDuration:1.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        if (transitionStyle == RECurtainTransitionVertical) {
            leftCurtain.frame = CGRectMake(- selfPortrait.size.width / 2, 0, selfPortrait.size.width / 2, selfPortrait.size.height);
            rightCurtain.frame = CGRectMake(selfPortrait.size.width, 0, selfPortrait.size.width / 2, selfPortrait.size.height);
        } else {
            leftCurtain.frame = CGRectMake(0, - selfPortrait.size.height / 2, selfPortrait.size.width, selfPortrait.size.height / 2);
            rightCurtain.frame = CGRectMake(0, selfPortrait.size.height, selfPortrait.size.width, selfPortrait.size.height / 2);
        }
    } completion:nil];
    
    
    //We then animate the FadedView ImageView's Frame and Alpha after a 0.5 sec delay.  
    [UIView animateWithDuration:1.2 delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        fadedView.frame = CGRectMake(0, offset, controllerScreenshot.size.width, controllerScreenshot.size.height);
        fadedView.alpha = 1;
    } completion:^(BOOL finished){
//      StickyFacesAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//        appDelegate.window.rootViewController = viewControllerToReveal;
        if (unwinding) {
            [viewControllerToReveal dismissViewControllerAnimated:NO completion:nil];
        } else {
        
        [viewControllerToPresent presentViewController:viewControllerToReveal animated:NO completion:nil];
        }
        
        //Upon completion we remove all of the UI for this animation to take place. 
        [leftCurtain removeFromSuperview];
        [rightCurtain removeFromSuperview];
        [fadedView removeFromSuperview];
        [coverView removeFromSuperview];
    }];
}

@end
