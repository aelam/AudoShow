//
//  RWReadOnlyTabBarController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-4-17.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWReadOnlyTabBarController.h"

@interface RWReadOnlyTabBarController ()

@end

@implementation RWReadOnlyTabBarController

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

    for(UIViewController<ReadOnly> *v in self.viewControllers) {
        if ([v respondsToSelector:@selector(setReadOnly:)]) {
            [v setReadOnly:YES];
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
