//
//  RWClient.h
//  AutoShow
//
//  Created by Ryan Wang on 13-4-4.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RWChannel, RWOrderDayType;

@interface RWClient : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * tel;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * budget;
@property (nonatomic, retain) NSData * head;
@property (nonatomic, retain) NSString * other;
@property (nonatomic, retain) NSString * comparingModel;
@property (nonatomic, retain) NSNumber * isFirstlyBuy;
@property (nonatomic, retain) NSString * channel;
@property (nonatomic, retain) NSString * oldCar;
@property (nonatomic, retain) NSNumber * oldCarPrice;
@property (nonatomic, retain) NSString * oldCarEvaluator;
@property (nonatomic, retain) RWOrderDayType *orderDay;
@property (nonatomic, retain) NSSet *channels;
@end

@interface RWClient (CoreDataGeneratedAccessors)

- (void)addChannelsObject:(RWChannel *)value;
- (void)removeChannelsObject:(RWChannel *)value;
- (void)addChannels:(NSSet *)values;
- (void)removeChannels:(NSSet *)values;

@end
