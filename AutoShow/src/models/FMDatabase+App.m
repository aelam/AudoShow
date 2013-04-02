//
//  FMDatabase+App.m
//  AutoShow
//
//  Created by Ryan Wang on 13-4-2.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "FMDatabase+App.h"

@implementation FMDatabase (App)


#define DB_NAME_IN_BUNDLE @"content.sqlite"


+ (FMDatabase *)mainDatabase {
    NSString *dbPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/content.db"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbPath]) {
//        NSString *bundleDB = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"content.sqlite"];

        NSString *bundleDB = [[NSBundle mainBundle] pathForResource:@"content.sqlite" ofType:nil];
        NSLog(@"%@",bundleDB);
        
        NSError *error = NULL;
        [[NSFileManager defaultManager] copyItemAtPath:bundleDB toPath:dbPath error:&error];
        if (error) {
            NSLog(@"%@",error);
        }
        
    }
    
    return [self databaseWithPath:dbPath];
}


@end
