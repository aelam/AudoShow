//
//  RWCarDetailViewController.h
//  AutoShow
//
//  Created by Ryan Wang on 13-3-28.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWCarDetailViewController : UIViewController

@property (nonatomic,strong) IBOutlet UIView *contentView;

- (IBAction)tapOnScreen:(id)sender;
- (IBAction)imageBrowserTapped:(id)sender;
- (IBAction)colorChooseTapped:(id)sender;
- (IBAction)carConfigTapped:(id)sender;
- (IBAction)activityTapped:(id)sender;


@end
