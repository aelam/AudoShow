//
//  RWManager.h
//  AutoShow
//
//  Created by Ryan Wang on 13-4-5.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RWManager : NSManagedObject

@property (nonatomic, retain) NSNumber * isAdmin;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * phone;

@end
