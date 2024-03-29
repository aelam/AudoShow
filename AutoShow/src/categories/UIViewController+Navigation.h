//
//  UIViewController+Navigation.h
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Navigation)

- (IBAction)popViewController:(id)sender;
- (IBAction)popRootViewController:(id)sender;

- (IBAction)dismissModalViewController:(id)sender;


- (IBAction)popToCarSeriesController:(id)sender;

- (IBAction)checkBoxAction:(UIButton *)sender;

@end
