//
//  RWCarModelChooseController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWCarModelChooseController.h"
#import "RWFilterTableViewController.h"

@interface RWCarModelChooseController ()


@property (nonatomic, strong) NSArray *carSeries;
@property (nonatomic, strong) NSArray *carModels;
@property (nonatomic, strong) NSArray *carColors;

@property (nonatomic, strong) UIPopoverController *modelPopover;
@property (nonatomic, strong) UIPopoverController *colorPopover;

@property (nonatomic, strong) RWFilterTableViewController *modelsTableViewController;
@property (nonatomic, strong) RWFilterTableViewController *colorsTableViewController;

@end

@implementation RWCarModelChooseController

@synthesize seriesTableView = _seriesTableView;
//@synthesize modelsTableView = _modelsTableView;
//@synthesize colorsTableView = _colorsTableView;

@synthesize carSeries = _carSeries;
@synthesize carModels = _carModels;
@synthesize carColors = _carColors;

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
 
    _carSeries = [NSArray arrayWithObjects:
                  @"赛才",
                  @"肯",
                  @"zou",
                  nil];
    
    _carModels = [NSArray arrayWithObjects:@"Model1",@"Model2",@"Model3",@"Model4",@"Model5", nil];
    _carColors = [NSArray arrayWithObjects:@"Red",@"Yellow",@"Green",@"Cyan",@"Gray", nil];

}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _seriesTableView) {
        return [_carSeries count];
    } else if (tableView == _modelsTableView) {
        return [_carModels count];
    } else if (tableView == _colorsTableView ) {
        return [_carColors count];
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"车系选择";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"filter_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    NSString *title;
    
    if (tableView == _seriesTableView) {
        title = [_carSeries objectAtIndex:indexPath.row];
    } else if (tableView == _modelsTableView) {
        title = [_carModels objectAtIndex:indexPath.row];
    } else if (tableView == _colorsTableView ) {
        title = [_carColors objectAtIndex:indexPath.row];
    }

    cell.textLabel.text = title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _seriesTableView) {
        
        _seriesLabel.text = [_carSeries objectAtIndex:indexPath.row];
        
        self.modelsTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RWFilterTableViewController"];//[[RWFilterTableViewController alloc] init];
        self.modelsTableViewController.tableView.delegate = self;
        self.modelsTableViewController.data = _carModels;
        self.modelsTableViewController.contentSizeForViewInPopover = CGSizeMake(150,300);
        self.modelPopover = [[UIPopoverController alloc] initWithContentViewController:self.modelsTableViewController];
        
        CGRect rect = [tableView rectForRowAtIndexPath:indexPath];
        CGRect rect0 = [self.view convertRect:rect fromView:tableView];
        
        [self.modelPopover presentPopoverFromRect:rect0 inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
        
    } else if (tableView == _modelsTableView || tableView == self.modelsTableViewController.tableView) {
        _modelLabel.text = [_carModels objectAtIndex:indexPath.row];

    
        self.colorsTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RWFilterTableViewController"];//[[RWFilterTableViewController alloc] init];
        self.colorsTableViewController.tableView.delegate = self;
        self.colorsTableViewController.data = _carColors;
        self.colorsTableViewController.contentSizeForViewInPopover = CGSizeMake(150,300);
        self.colorPopover = [[UIPopoverController alloc] initWithContentViewController:self.colorsTableViewController];
        
        CGRect rect = [tableView rectForRowAtIndexPath:indexPath];
        CGRect rect0 = [self.view convertRect:rect fromView:tableView];

        [self.colorPopover presentPopoverFromRect:rect0 inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];

    
    } else if (tableView == _colorsTableView || tableView == self.colorsTableViewController.tableView) {
        _colorLabel.text = [_carColors objectAtIndex:indexPath.row];
        
        [self.colorPopover dismissPopoverAnimated:YES];
        [self.modelPopover dismissPopoverAnimated:YES];
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
