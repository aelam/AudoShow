//
//  RWCarModelChooseController.h
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWCarModelChooseController : UIViewController

@property (nonatomic, strong) IBOutlet UITableView *seriesTableView;

@property (nonatomic, strong) IBOutlet UITableView *modelsTableView;
@property (nonatomic, strong) IBOutlet UITableView *colorsTableView;

@end
