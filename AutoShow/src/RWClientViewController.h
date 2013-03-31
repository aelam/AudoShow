//
//  RWClientViewController.h
//  AutoShow
//
//  Created by Ryan Wang on 13-3-29.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWClientViewController : UIViewController


@property (nonatomic, strong) IBOutlet UINavigationController *embeddedNavigator;

- (IBAction)switchAction:(id)sender;
- (IBAction)pop:(id)sender;


@end
