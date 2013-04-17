//
//  RWCarModelChooseController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWCarModelChooseController.h"
#import "RWFilterTableViewController.h"
#import <CoreData/CoreData.h>
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import "RWCarSeries.h"
#import "RWCarModel.h"
#import "RWCarColor.h"
#import "RWClient.h"
#import "RWClientInfoController.h"

//#import "RWPopoverBackgroundView.h"
#import "KSCustomPopoverBackgroundView.h"

@interface RWCarModelChooseController () <NSFetchedResultsControllerDelegate>


//@property (nonatomic, strong) NSArray *carSeries;
//@property (nonatomic, strong) NSArray *carModels;
//@property (nonatomic, strong) NSArray *carColors;

@property (nonatomic, strong) UIPopoverController *modelPopover;
@property (nonatomic, strong) UIPopoverController *colorPopover;

@property (nonatomic, strong) RWFilterTableViewController *modelsTableViewController;
@property (nonatomic, strong) RWFilterTableViewController *colorsTableViewController;


@property (nonatomic, retain) NSFetchedResultsController *fetchedSeriesController;
@property (nonatomic, retain) NSManagedObjectContext *currentContext;

@property (nonatomic, retain) RWCarSeries *selectedSeries;
@property (nonatomic, retain) NSArray *currentModels;
@property (nonatomic, retain) RWCarModel *selectedModel;
@property (nonatomic, retain) NSArray *currentColors;
@property (nonatomic, retain) RWCarColor *selectedColor;


@end

@implementation RWCarModelChooseController

@synthesize seriesTableView = _seriesTableView;

//@synthesize carSeries = _carSeries;
//@synthesize carModels = _carModels;
//@synthesize carColors = _carColors;

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

    
//    
//    _carSeries = [NSArray arrayWithObjects:
//                  @"赛才",
//                  @"肯",
//                  @"zou",
//                  nil];
    
//    _carModels = [NSArray arrayWithObjects:@"Model1",@"Model2",@"Model3",@"Model4",@"Model5", nil];
//    _carColors = [NSArray arrayWithObjects:@"Red",@"Yellow",@"Green",@"Cyan",@"Gray", nil];

}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _seriesTableView) {
        return [self.fetchedSeriesController.fetchedObjects count];
    } else if (tableView == self.modelsTableViewController.tableView) {
        return [self.currentModels count];
    } else if(tableView == self.colorsTableViewController.tableView) {
        return [self.currentColors count];
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.seriesTableView) {
        return nil;//@"车系选择";
    } else if (tableView == self.modelsTableViewController.tableView) {
//        return @"车型选择";
    } else if(tableView == self.colorsTableViewController.tableView) {
//        return @"颜色选择";
    } else {
        return nil;
    }
    return nil;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"filter_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    NSString *title;
    
    if (tableView == _seriesTableView) {
        RWCarSeries *series = [self.fetchedSeriesController objectAtIndexPath:indexPath];
        title = series.seriesName;
    } else if (tableView == self.modelsTableViewController.tableView) {
        RWCarModel *carModel = [self.currentModels objectAtIndex:indexPath.row];
        title = carModel.modelName;
    } else if (tableView == self.colorsTableViewController.tableView) {
        RWCarColor *color = [self.currentColors objectAtIndex:indexPath.row];
        title = color.colorName;
    }

    cell.textLabel.text = title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _seriesTableView) {
        
        self.selectedSeries = [self.fetchedSeriesController objectAtIndexPath:indexPath];
            

        _seriesLabel.text =  self.selectedSeries.seriesName;
        self.modelsTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RWFilterTableViewController"];
        
        
        NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"createAt" ascending:NO]];
        self.currentModels = [[self.selectedSeries.models allObjects] sortedArrayUsingDescriptors:sortDescriptors];

        self.modelsTableViewController.tableView.delegate = self;
        self.modelsTableViewController.tableView.dataSource = self;
        self.modelsTableViewController.contentSizeForViewInPopover = CGSizeMake(213,300);
        self.modelPopover = [[UIPopoverController alloc] initWithContentViewController:self.modelsTableViewController];
        [self.modelsTableViewController.tableView reloadData];
        
        self.modelPopover.popoverBackgroundViewClass = [KSCustomPopoverBackgroundView class];
        
        self.modelsTableViewController.tableView.tableHeaderView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"model_choose_header"]];
        
        CGRect rect = [tableView rectForRowAtIndexPath:indexPath];
        CGRect rect0 = [self.view convertRect:rect fromView:tableView];
        
        [self.modelPopover presentPopoverFromRect:rect0 inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
        
    } else if (tableView == _modelsTableView || tableView == self.modelsTableViewController.tableView) {
        self.selectedModel = [self.currentModels objectAtIndex:indexPath.row];
        _modelLabel.text = self.selectedModel.modelName;
    
        NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"createAt" ascending:NO]];
        self.currentColors = [[self.selectedModel.colors allObjects] sortedArrayUsingDescriptors:sortDescriptors];
        
        self.colorsTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RWFilterTableViewController"];
        self.colorsTableViewController.tableView.delegate = self;
        self.colorsTableViewController.tableView.dataSource = self;
        self.colorsTableViewController.contentSizeForViewInPopover = CGSizeMake(150,300);
        self.colorPopover = [[UIPopoverController alloc] initWithContentViewController:self.colorsTableViewController];

        self.colorPopover.popoverBackgroundViewClass = [KSCustomPopoverBackgroundView class];
        
        CGRect rect = [tableView rectForRowAtIndexPath:indexPath];
        CGRect rect0 = [self.view convertRect:rect fromView:tableView];

        [self.colorPopover presentPopoverFromRect:rect0 inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];

    
    } else if (tableView == _colorsTableView || tableView == self.colorsTableViewController.tableView) {
        self.selectedColor = [self.currentColors objectAtIndex:indexPath.row];
        _colorLabel.text = self.selectedColor.colorName;
        
        [self.colorPopover dismissPopoverAnimated:YES];
        [self.modelPopover dismissPopoverAnimated:YES];
    }
    
}


- (void)updateModelsAndTable {
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"createAt" ascending:NO]];
    self.currentModels = [[self.selectedSeries.models allObjects] sortedArrayUsingDescriptors:sortDescriptors];
    self.modelsTableViewController.data = self.currentModels;
    
    [self.modelsTableViewController.tableView reloadData];
}

- (void)updateColorsAndTable {
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"createAt" ascending:NO]];
    self.currentColors = [[self.selectedModel.colors allObjects] sortedArrayUsingDescriptors:sortDescriptors];
    
    self.colorsTableViewController.data = self.currentColors;
    [self.colorsTableViewController.tableView reloadData];
    
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if (self.selectedColor == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请选择车型" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        
        
        
        
        return NO;
    }
    else return [super shouldPerformSegueWithIdentifier:identifier sender:sender];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RWClientInfoController *clientInfoController = (RWClientInfoController *)segue.destinationViewController;

    RWClient *client = [NSEntityDescription insertNewObjectForEntityForName:@"RWClient" inManagedObjectContext:self.currentContext];
    client.carColor = self.selectedColor;

    clientInfoController.currentClient = client;
    
    [super prepareForSegue:segue sender:sender];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
