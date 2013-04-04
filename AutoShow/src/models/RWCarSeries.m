//
//  RWCarSeries.m
//  AutoShow
//
//  Created by Ryan Wang on 13-4-4.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWCarSeries.h"
#import "RWCarModel.h"


@implementation RWCarSeries

@dynamic seriesId;
@dynamic seriesName;
@dynamic createAt;
@dynamic models;

- (void)awakeFromInsert {
    self.createAt = [NSDate date];
}

@end
