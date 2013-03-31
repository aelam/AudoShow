//
//  RWAdminPageController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWAdminPageController.h"
#import "RWAdminCarEditController.h"

@interface RWAdminPageController ()

@end

@implementation RWAdminPageController

@synthesize contentView = _contentView;

@synthesize adminCarEditController = _adminCarEditController;


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
    
//    _adminCarEditController = [self.storyboard instantiateViewControllerWithIdentifier:@"RWAdminCarEditController"];
//
//    [self.contentView addSubview:_adminCarEditController.view];
//    _adminCarEditController.view.frame = self.contentView.frame;

//    UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"myStoryBoardName" bundle:nil];
//    self.leftController = [mystoryboard instantiateViewControllerWithIdentifier:@"idyouassigned"];

//    adminCarEditController = [UIStoryboard]

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
