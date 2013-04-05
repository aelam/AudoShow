//
//  RWCarModelChooseController.h
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWCarModelChooseController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *seriesTableView;

@property (nonatomic, strong) IBOutlet UITableView *modelsTableView;
@property (nonatomic, strong) IBOutlet UITableView *colorsTableView;

@property (nonatomic, strong) IBOutlet UILabel *seriesLabel;
@property (nonatomic, strong) IBOutlet UILabel *modelLabel;
@property (nonatomic, strong) IBOutlet UILabel *colorLabel;

@end
