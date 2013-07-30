//
//  TestCell.m
//  StickyFaces
//
//  Created by Daniel Rakhamimov on 7/28/13.
//
//

#import "TestCell.h"

@implementation TestCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
                
        self.backgroundColor = [UIColor blueColor];
        
        
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    
        [self addSubview:_textLabel];
        

        
        
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
