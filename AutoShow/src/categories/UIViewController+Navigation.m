//
//  UIViewController+Navigation.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)

- (IBAction)popViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)popRootViewController:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (IBAction)dismissModalViewController:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)checkBoxAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}


@end
