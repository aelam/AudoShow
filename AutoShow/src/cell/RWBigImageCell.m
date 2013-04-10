//
//  RWBigImageCell.m
//  AutoShow
//
//  Created by Ryan Wang on 13-4-10.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWBigImageCell.h"

@implementation RWBigImageCell


-(void)prepareForReuse {
    self.selected = FALSE;
}


- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    
}

@end
