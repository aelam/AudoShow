//
//  RWCarColor.m
//  AutoShow
//
//  Created by Ryan Wang on 13-4-4.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWCarColor.h"
#import "RWCarModel.h"


@implementation RWCarColor

@dynamic colorId;
@dynamic colorName;
@dynamic createAt;
@dynamic model;

- (void)awakeFromInsert {
    self.createAt = [NSDate date];
}

@end
