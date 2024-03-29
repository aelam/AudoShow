//
//  RWResourceManager.h
//  AutoShow
//
//  Created by Ryan Wang on 13-4-6.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kJingFolderKey          @"colors"
#define kJingSmallImagesKey     @"jing/xiao"
#define kJingBigImagesKey       @"jing/da"

#define kColorInfoKey           @"colorInfo"




@interface RWResourceManager : NSObject

+ (RWResourceManager *)defaultManager;

+ (NSString *)bundleName;

+ (NSString *)resourcePath;

- (NSArray *)carSeries;

@end
