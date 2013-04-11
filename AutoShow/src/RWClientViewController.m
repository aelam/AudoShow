//
//  RWClientViewController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-29.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWClientViewController.h"

@interface RWClientViewController ()

@end


@implementation RWClientViewController

@synthesize embeddedNavigator = _embeddedNavigator;

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
	// Do any additional setup after loading the view.
    _embeddedNavigator = [self.childViewControllers lastObject];

    [self switchAction:nil];

}

- (IBAction)switchAction:(UIButton *)sender {
    
    UIViewController *v;

    if (self.clientNewButton == sender) {
        if (self.clientNewButton.selected) {
            return;
        }
        
        self.clientNewButton.selected = YES;
        self.clientListButton.selected = NO;
        v = [self.storyboard instantiateViewControllerWithIdentifier:@"model_choose"];
    } else {
        if (self.clientListButton.selected) {
            return;
        }
        
        
        self.clientNewButton.selected = NO;
        self.clientListButton.selected = YES;
        v = [self.storyboard instantiateViewControllerWithIdentifier:@"client_list"];
    }
    
//    UIViewController *v;
//    if (sender.selectedSegmentIndex == 1) {
//        v = [self.storyboard instantiateViewControllerWithIdentifier:@"client_list"];
//    } else {
//        v = [self.storyboard instantiateViewControllerWithIdentifier:@"model_choose"];
//    }
    
    [_embeddedNavigator setViewControllers:[NSArray arrayWithObject:v]];

}

- (IBAction)pop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
