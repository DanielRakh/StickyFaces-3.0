//
//  FlashCheckView.h
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 8/4/13.
//
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSUInteger, MyStyleEnum) {
    kDefaultStyle,
    kConfirmedToPaste,
    kFavorites,
};



@interface FlashCheckView : UIView


-(id)initWithFrame:(CGRect)frame andStyle:(MyStyleEnum)myStyleEnum;

@end
