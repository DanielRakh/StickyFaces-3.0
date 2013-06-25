//
//  copyHUD.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CopyHUD.h"

@implementation CopyHUD

+ (id) newHUD
{
	UINib *nib = [UINib nibWithNibName:@"copyHUD" bundle:nil];
	NSArray *nibArray = [nib instantiateWithOwner:self options:nil];
    CopyHUD *me = [nibArray objectAtIndex: 0];
    
	return me;
}




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
