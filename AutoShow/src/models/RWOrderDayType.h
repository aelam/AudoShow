//
//  RWOrderDayType.h
//  AutoShow
//
//  Created by Ryan Wang on 13-4-4.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RWOrderDayType : NSManagedObject

@property (nonatomic, retain) NSNumber * typeId;
@property (nonatomic, retain) NSString * typeName;

@end
