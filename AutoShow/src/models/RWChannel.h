//
//  RWChannel.h
//  AutoShow
//
//  Created by Ryan Wang on 13-4-4.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RWChannel : NSManagedObject

@property (nonatomic, retain) NSNumber * channelId;
@property (nonatomic, retain) NSString * channelName;

@end
