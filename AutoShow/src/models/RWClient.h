//
//  RWClient.h
//  AutoShow
//
//  Created by Ryan Wang on 13-4-17.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RWCarColor, RWChannel, RWOrderDayType;

@interface RWClient : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * budget;
@property (nonatomic, retain) NSString * channel;
@property (nonatomic, retain) NSString * comparingModel;
@property (nonatomic, retain) NSData * head;
@property (nonatomic, retain) NSNumber * isFirstlyBuy;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * oldCar;
@property (nonatomic, retain) NSString * oldCarEvaluator;
@property (nonatomic, retain) NSNumber * oldCarPrice;
@property (nonatomic, retain) NSString * other;
@property (nonatomic, retain) NSString * tel;
@property (nonatomic, retain) NSString * chassis;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * oldCarReplace;
@property (nonatomic, retain) NSSet *channels;
@property (nonatomic, retain) RWOrderDayType *orderDay;
@property (nonatomic, retain) RWCarColor *carColor;
@end

@interface RWClient (CoreDataGeneratedAccessors)

- (void)addChannelsObject:(RWChannel *)value;
- (void)removeChannelsObject:(RWChannel *)value;
- (void)addChannels:(NSSet *)values;
- (void)removeChannels:(NSSet *)values;

@end
