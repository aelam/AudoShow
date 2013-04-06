//
//  RWResourceManager.m
//  AutoShow
//
//  Created by Ryan Wang on 13-4-6.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWResourceManager.h"

@implementation RWResourceManager

+ (RWResourceManager *)defaultManager {
    static dispatch_once_t onceToken;
    static RWResourceManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[RWResourceManager alloc] init];
    });
    return manager;
}

+ (NSString *)bundleName {
    return @"showingCars.bundle";
}

+ (NSString *)resourcePath {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"showingCars" ofType:@"bundle"];
    return bundlePath;
}

- (NSArray *)carSeries {
    NSString *plistPath = [[RWResourceManager resourcePath] stringByAppendingPathComponent:@"CarSeries.plist"];
    return [NSArray arrayWithContentsOfFile:plistPath];
}

@end
