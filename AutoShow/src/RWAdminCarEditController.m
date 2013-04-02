//
//  RWAdminCarEditController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWAdminCarEditController.h"

@interface RWAdminCarEditController ()<UITableViewDataSource, UITableViewDelegate>

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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.seriesTable) {
        return 1;
    }  else if ( tableView == self.modelsTable){
            return 2;
    } else {
        return 4;
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
//    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //TODO
    
    //show car config image
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSeriersField:nil];
    [super viewDidUnload];
}

- (IBAction)addSeriesAction:(UIButton *)sender {
}

- (IBAction)addModelAction:(UIButton *)sender {
}

- (IBAction)addColorAction:(id)sender {
}
@end
