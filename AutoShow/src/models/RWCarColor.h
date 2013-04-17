//
//  RWCarColor.h
//  AutoShow
//
//  Created by Ryan Wang on 13-4-17.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RWCarModel;

@interface RWCarColor : NSManagedObject

@property (nonatomic, retain) NSDate * colorId;
@property (nonatomic, retain) NSString * colorName;
@property (nonatomic, retain) NSDate * createAt;
@property (nonatomic, retain) NSSet *models;
@end

@interface RWCarColor (CoreDataGeneratedAccessors)

- (void)addModelsObject:(RWCarModel *)value;
- (void)removeModelsObject:(RWCarModel *)value;
- (void)addModels:(NSSet *)values;
- (void)removeModels:(NSSet *)values;

@end
