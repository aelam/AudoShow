//
//  RWCarModel.m
//  AutoShow
//
//  Created by Ryan Wang on 13-4-4.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWCarModel.h"
#import "RWCarColor.h"
#import "RWCarSeries.h"


@implementation RWCarModel

@dynamic createAt;
@dynamic hasNoTurboType;
@dynamic hasTurboType;
@dynamic modelName;
@dynamic modelId;
@dynamic price;
@dynamic colors;
@dynamic series;

- (void)awakeFromInsert {
    self.createAt = [NSDate date];
}

@end
