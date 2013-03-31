//
//  RWClientListViewController.h
//  AutoShow
//
//  Created by Ryan Wang on 13-3-30.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWClientListViewController : UIViewController<UITableViewDataSource, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
