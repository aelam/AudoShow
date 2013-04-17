//
//  RWAdminCarEditController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWAdminCarEditController.h"
#import <CoreData/CoreData.h>
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import "RWCarSeries.h"
#import "RWCarModel.h"
#import "RWCarColor.h"


//#define HAS_NONE_TURBO_BUTTON_TAG   100
//#define HAS_TURBO_BUTTON_TAG        101


@interface RWAdminCarEditController ()<UITableViewDataSource, UITableViewDelegate,NSFetchedResultsControllerDelegate,UIAlertViewDelegate>

@property (nonatomic, retain) NSFetchedResultsController *fetchedSeriesController;
@property (nonatomic, retain) NSFetchedResultsController *fetchedModelsController;
@property (nonatomic, retain) NSFetchedResultsController *fetchedColorsController;


@property (nonatomic, retain) NSManagedObjectContext *currentContext;


@property (nonatomic, retain) RWCarSeries *selectedSeries;
@property (nonatomic, retain) NSArray *currentModels;
@property (nonatomic, retain) RWCarModel *selectedModel;
@property (nonatomic, retain) NSArray *currentColors;



@end

@implementation RWAdminCarEditController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    UINib *cellNib = [UINib nibWithNibName:@"BaseCell" bundle:nil];
    [self.modelsTable registerNib:cellNib forCellReuseIdentifier:@"BaseCell"];
    [self.seriesTable registerNib:cellNib forCellReuseIdentifier:@"BaseCell"];
    [self.colorsTable registerNib:cellNib forCellReuseIdentifier:@"BaseCell"];
    
    
    self.currentContext = [RKManagedObjectStore defaultStore].persistentStoreManagedObjectContext;
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"RWCarSeries"];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"createAt" ascending:NO];
    fetchRequest.sortDescriptors = @[descriptor];
    
    // Setup fetched results
    self.fetchedSeriesController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:self.currentContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    [self.fetchedSeriesController setDelegate:self];
    NSError *error = nil;
    [self.fetchedSeriesController performFetch:&error];

    // 2
//    NSFetchRequest *fetchRequest2 = [NSFetchRequest fetchRequestWithEntityName:@"RWCarModel"];
////    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"createAt" ascending:NO];
//    fetchRequest2.sortDescriptors = @[descriptor];
//    
//    // Setup fetched results
//    self.fetchedModelsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest2
//                                                                       managedObjectContext:context
//                                                                         sectionNameKeyPath:nil
//                                                                                  cacheName:nil];
//    [self.fetchedModelsController setDelegate:self];
//    NSError *error = nil;
//    [self.fetchedSeriesController performFetch:&error];

    
    
}


- (void)updateModelsAndTable {
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"createAt" ascending:NO]];
    self.currentModels = [[self.selectedSeries.models allObjects] sortedArrayUsingDescriptors:sortDescriptors];
    [self.modelsTable reloadData];
}

- (void)updateColorsAndTable {
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"createAt" ascending:NO]];
    self.currentColors = [[self.selectedModel.colors allObjects] sortedArrayUsingDescriptors:sortDescriptors];
    [self.colorsTable reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.seriesTable) {
        return [self.fetchedSeriesController.fetchedObjects count];
    }  else if ( tableView == self.modelsTable){
        return [self.selectedSeries.models count];
    } else {
        return [self.currentColors count];
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseCell"];

//    
//    if (tableView == self.seriesTable) {
//        cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
//    } else if (tableView == self.modelsTable) {
//        cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
//        
//
//    } else if (tableView == self.colorsTable) {
//        cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
//    
//    }
//   
//    cell = [tableView dequeueReusableCellWithIdentifier:@"good_cell"];

    cell.textLabel.text = indexPath.description;
    if (tableView == self.seriesTable) {
        RWCarSeries *series = [self.fetchedSeriesController objectAtIndexPath:indexPath];
        cell.textLabel.text =  series.seriesName;

    } else if (tableView == self.modelsTable) {
        RWCarModel *model = [self.currentModels objectAtIndex:indexPath.row];
        cell.textLabel.text =  model.modelName;
    } else if (tableView == self.colorsTable) {
        RWCarColor *color = [self.currentColors objectAtIndex:indexPath.row];
        cell.textLabel.text = color.colorName;
    }
    
    return cell;
}


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    UITableView *tableView = nil;
    if (controller == self.fetchedSeriesController) {
        tableView = self.seriesTable;
    }
    
    [tableView beginUpdates];
    

}



- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    
    UITableView *tableView =nil;
    if (controller == self.fetchedSeriesController) {
        tableView = self.seriesTable;
    } else if (controller == self.fetchedModelsController) {
        tableView = self.modelsTable;
    } else if (controller == self.fetchedColorsController) {
        tableView = self.colorsTable;
    }

    
    if (type == NSFetchedResultsChangeInsert) {
        [tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (type == NSFetchedResultsChangeDelete) {
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.seriesTable;

    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        default:
            break;
    }
    
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    UITableView *tableView = nil;
    if (controller == self.fetchedSeriesController) {
        tableView = self.seriesTable;
    }
    
    [tableView endUpdates];
    
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.seriesTable) {
        self.selectedSeries = [self.fetchedSeriesController objectAtIndexPath:indexPath];
        [self updateModelsAndTable];
    } else if (tableView == self.modelsTable) {
         self.selectedModel = [self.currentModels objectAtIndex:indexPath.row];
        [self updateColorsAndTable];
    }
    
    
}


//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        NSError *error = nil;
//        RWCarSeries *series = [self.fetchedSeriesController objectAtIndexPath:indexPath];
//        
//        NSLog(@"[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext = %@",[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext);
//        NSLog(@"series.managedObjectContext = %@",series.managedObjectContext);
//        [series.managedObjectContext deleteObject:series];
//        [series.managedObjectContext save:&error];
//        if (error) {
//            NSLog(@"delete series with error");
//        }
////        [self.seriesTable reloadData];
//    }
//}
//

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSeriersField:nil];
    [self setHasNoneTurboButton:nil];
    [self setHasTurboButton:nil];
    [super viewDidUnload];
}

- (IBAction)addSeriesAction:(UIButton *)sender {
    
    NSString *newSeries = self.seriersField.text;
    
    if (newSeries == nil || newSeries.length == 0) {
        
    } else {
        
        RWCarSeries *carSeries = (RWCarSeries *)[NSEntityDescription insertNewObjectForEntityForName:@"RWCarSeries" inManagedObjectContext:self.currentContext];
        
        carSeries.seriesName = newSeries;
        
        NSError *error1= nil;
        
        if ([self.currentContext hasChanges]) {
            [self.currentContext save:&error1];
            if (error1) {
                NSLog(@"%@", error1);
            }
        }
        
    }
    

    
    
}

- (IBAction)addModelAction:(UIButton *)sender {
  
    if (self.modelField.text == nil || self.modelField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入车型" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if (self.selectedSeries == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请先选择车系" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    RWCarModel *carModel = (RWCarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"RWCarModel" inManagedObjectContext:self.currentContext];
    carModel.hasNoTurboType = [NSNumber numberWithBool:self.hasNoneTurboButton.selected];
    carModel.hasTurboType = [NSNumber numberWithBool:self.hasTurboButton.selected];
    carModel.modelName = self.modelField.text;
    carModel.price = [NSNumber numberWithInt:[self.priceField.text intValue]];
    carModel.series = self.selectedSeries;
    
    [self.selectedSeries addModelsObject:carModel];
    
    NSError *error1 = nil;
    if ([self.currentContext hasChanges]) {
        [self.currentContext save:&error1];
        if (error1) {
            NSLog(@"%@", error1);
        } else {
            [self updateModelsAndTable];
        }
        
        
    }
}

- (IBAction)addColorAction:(id)sender {
    NSString *colorText = self.colorField.text;
    if (colorText == nil || colorText.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入颜色" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (self.selectedModel == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请先选择车型" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
        return;
    }

    RWCarColor *color = [NSEntityDescription insertNewObjectForEntityForName:@"RWCarColor" inManagedObjectContext:self.currentContext];
    color.colorName = colorText;
    [self.selectedModel addColorsObject:color];
    NSError *error1 = nil;
    if ([self.currentContext hasChanges]) {
        [self.currentContext save:&error1];
        if (error1) {
            NSLog(@"%@", error1);
        } else {
            [self updateColorsAndTable];
        }
    }

}

//- (IBAction)addColorAction:(id)sender {
//    
//    NSArray *colors = @[@"塞纳金",@"纳斯达克银"];
//    for(NSString *c in colors) {
//        RWCarColor *color = [NSEntityDescription insertNewObjectForEntityForName:@"RWCarColor" inManagedObjectContext:self.currentContext];
//        color.colorName = c;
//        [self.selectedModel addColorsObject:color];
//        NSError *error1 = nil;
//        if ([self.currentContext hasChanges]) {
//            [self.currentContext save:&error1];
//            if (error1) {
//                NSLog(@"%@", error1);
//            } else {
//                [self updateColorsAndTable];
//            }
//        }
//        
//    }
//
//}

@end
