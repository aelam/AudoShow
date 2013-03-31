//
//  RWCarModelChooseController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWCarModelChooseController.h"

@interface RWCarModelChooseController ()


@property (nonatomic, strong) NSArray *carSeries;
@property (nonatomic, strong) NSArray *carModels;
@property (nonatomic, strong) NSArray *carColors;


@end

@implementation RWCarModelChooseController

@synthesize seriesTableView = _seriesTableView;
@synthesize modelsTableView = _modelsTableView;
@synthesize colorsTableView = _colorsTableView;

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
        
//        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:<#(UIViewController *)#>];
        
    } else if (tableView == _modelsTableView) {
    
    } else if (tableView == _colorsTableView ) {
    
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
