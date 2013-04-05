//
//  RWManager.m
//  AutoShow
//
//  Created by Ryan Wang on 13-4-5.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWManager.h"


@implementation RWManager

@dynamic isAdmin;
@dynamic password;
@dynamic userId;
@dynamic username;
@dynamic phone;


- (void)awakeFromInsert {
    self.isAdmin = [NSNumber numberWithBool:NO];
}

@end
