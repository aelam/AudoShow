//
//  RWCarSeries.h
//  AutoShow
//
//  Created by Ryan Wang on 13-4-4.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RWCarModel;

@interface RWCarSeries : NSManagedObject

@property (nonatomic, retain) NSNumber * seriesId;
@property (nonatomic, retain) NSString * seriesName;
@property (nonatomic, retain) NSDate * createAt;
@property (nonatomic, retain) NSSet *models;
@end

@interface RWCarSeries (CoreDataGeneratedAccessors)

- (void)addModelsObject:(RWCarModel *)value;
- (void)removeModelsObject:(RWCarModel *)value;
- (void)addModels:(NSSet *)values;
- (void)removeModels:(NSSet *)values;

@end
