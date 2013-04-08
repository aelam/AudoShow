//
//  UIViewController+Navigation.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "UIViewController+Navigation.h"
#import "RWCarModelViewController.h"

@implementation UIViewController (Navigation)

- (IBAction)popViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)popRootViewController:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (IBAction)dismissModalViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)checkBoxAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}

- (IBAction)popToCarSeriesController:(id)sender {
    
    RWCarModelViewController *modelController = nil;
    
    if (self.navigationController.viewControllers.count <= 1) {
        return;
    }
    
    for(UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[RWCarModelViewController class]]) {
            modelController = (RWCarModelViewController *)vc;
            break;
        }
    }
    
    [self.navigationController popToViewController:modelController animated:YES];
    
    
    
}


@end
