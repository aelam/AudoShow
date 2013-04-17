//
//  NSString+Extension.m
//  AutoShow
//
//  Created by Ryan Wang on 13-4-17.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "NSString+Extension.h"

BOOL isEmpty(NSString *s) {
    if (s == nil || s.length == 0) {
        return YES;
    }
    return NO;
}

@implementation NSString (Extension)

@end
