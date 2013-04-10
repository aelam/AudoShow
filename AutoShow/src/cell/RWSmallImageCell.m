//
//  RWSmallImageCell.m
//  AutoShow
//
//  Created by Ryan Wang on 13-4-10.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWSmallImageCell.h"

@implementation RWSmallImageCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)prepareForReuse {
    self.selected = NO;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    self.bottomLine.hidden = !selected;
    
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
