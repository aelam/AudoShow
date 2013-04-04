//
//  RWCarModel.h
//  AutoShow
//
//  Created by Ryan Wang on 13-4-4.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RWCarColor, RWCarSeries;

@interface RWCarModel : NSManagedObject

@property (nonatomic, retain) NSDate * createAt;
@property (nonatomic, retain) NSNumber * hasNoTurboType;
@property (nonatomic, retain) NSNumber * hasTurboType;
@property (nonatomic, retain) NSString * modelName;
@property (nonatomic, retain) NSNumber * modelId;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSSet *colors;
@property (nonatomic, retain) RWCarSeries *series;
@end

@interface RWCarModel (CoreDataGeneratedAccessors)

- (void)addColorsObject:(RWCarColor *)value;
- (void)removeColorsObject:(RWCarColor *)value;
- (void)addColors:(NSSet *)values;
- (void)removeColors:(NSSet *)values;

@end
