//
//  RWAppDelegate.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-28.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWAppDelegate.h"
//#import "FMDatabase+App.h"
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>

#import "RWCarSeries.h"


@implementation RWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    objectManager.managedObjectStore = managedObjectStore;
    
    
    

    NSError *error;

#define GENERATE_SEED_DB  0
#if GENERATE_SEED_DB
    RKEntityMapping *userMapping = [RKEntityMapping mappingForEntityForName:@"RWManager" inManagedObjectStore:managedObjectStore];
    [userMapping addAttributeMappingsFromArray:@[ @"userId",@"username",@"password",@"isAdmin",@"phone"]];
    [userMapping setIdentificationAttributes:@[@"userId",@"username"]];

    RKEntityMapping *channelMapping = [RKEntityMapping mappingForEntityForName:@"RWChannel" inManagedObjectStore:managedObjectStore];
    [channelMapping addAttributeMappingsFromArray:@[ @"channelId",@"channelName"]];
    
    RKEntityMapping *orderDateMapping = [RKEntityMapping mappingForEntityForName:@"RWOrderDayType" inManagedObjectStore:managedObjectStore];
    [orderDateMapping addAttributeMappingsFromArray:@[ @"typeId",@"typeName"]];

    
    NSString *seedPath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"RKSeedDatabase.sqlite"];

    RKManagedObjectImporter *importer = [[RKManagedObjectImporter alloc] initWithManagedObjectModel:managedObjectModel storePath:seedPath];
    
    [importer importObjectsFromItemAtPath:[[NSBundle mainBundle] pathForResource:@"user" ofType:@"json"]
                              withMapping:userMapping
                                  keyPath:nil
                                    error:&error];

    [importer importObjectsFromItemAtPath:[[NSBundle mainBundle] pathForResource:@"channel" ofType:@"json"]
                              withMapping:channelMapping
                                  keyPath:nil
                                    error:&error];

    [importer importObjectsFromItemAtPath:[[NSBundle mainBundle] pathForResource:@"order_type" ofType:@"json"]
                              withMapping:orderDateMapping
                                  keyPath:nil
                                    error:&error];

    
    BOOL success = [importer finishImporting:&error];
    if (success) {
        [importer logSeedingInfo];
    }
    if (error) {
        NSLog(@"error : %@",error);
        
    }

#else

    [managedObjectStore createPersistentStoreCoordinator];
    
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"AutoShow-3.sqlite"];

    NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"RKSeedDatabase" ofType:@"sqlite"];

    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    // Create the managed object contexts
    [managedObjectStore createManagedObjectContexts];

    // Configure a managed object cache to ensure we do not create duplicate objects
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];

#endif
    
    return YES;
    
}

/*
- (void)insertObject{
    
    RWCarSeries *carSeries = (RWCarSeries *)[NSEntityDescription insertNewObjectForEntityForName:@"RWCarSeries" inManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
    
    carSeries.seriesName = @"奇瑞QQ";
    
    NSError *error1= nil;
    
    if ([managedObjectStore.persistentStoreManagedObjectContext hasChanges]) {
        [managedObjectStore.persistentStoreManagedObjectContext save:&error1];
        if (error1) {
            NSLog(@"%@", error1);
        }
    }
    
}
 */

- (void)addAdmin {
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
