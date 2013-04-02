//
//  RWAdminCarEditController.h
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWAdminCarEditController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *seriersField;

@property (strong, nonatomic) IBOutlet UITextField *modelField;
@property (strong, nonatomic) IBOutlet UITextField *priceField;
@property (strong, nonatomic) IBOutlet UITextField *colorField;

@property (strong, nonatomic) IBOutlet UITableView *seriesTable;
@property (strong, nonatomic) IBOutlet UITableView *modelsTable;
@property (strong, nonatomic) IBOutlet UITableView *colorsTable;

- (IBAction)addSeriesAction:(UIButton *)sender;
- (IBAction)addModelAction:(UIButton *)sender;
- (IBAction)addColorAction:(id)sender;

@end
