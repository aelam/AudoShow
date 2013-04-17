//
//  RWChannel.h
//  AutoShow
//
//  Created by Ryan Wang on 13-4-17.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RWClient;

@interface RWChannel : NSManagedObject

@property (nonatomic, retain) NSNumber * channelId;
@property (nonatomic, retain) NSString * channelName;
@property (nonatomic, retain) NSSet *clients;
@end

@interface RWChannel (CoreDataGeneratedAccessors)

- (void)addClientsObject:(RWClient *)value;
- (void)removeClientsObject:(RWClient *)value;
- (void)addClients:(NSSet *)values;
- (void)removeClients:(NSSet *)values;

@end
