//
//  RWCarColor.h
//  AutoShow
//
//  Created by Ryan Wang on 13-4-4.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RWCarModel;

@interface RWCarColor : NSManagedObject

@property (nonatomic, retain) NSDate * colorId;
@property (nonatomic, retain) NSString * colorName;
@property (nonatomic, retain) NSDate * createAt;
@property (nonatomic, retain) RWCarModel *model;

@end
