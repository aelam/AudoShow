//
//  RWAdminPageController.h
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RWAdminCarEditController;
@class RWAdminSalesEditController;


@interface RWAdminPageController : UIViewController

@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) RWAdminCarEditController *adminCarEditController;
@property (nonatomic, strong) RWAdminSalesEditController *salesEditController;
//@property (nonatomic, strong) RWAdminCarEditController *adminCarEditController;
//@property (nonatomic, strong) RWAdminCarEditController *adminCarEditController;
//@property (nonatomic, strong) RWAdminCarEditController *adminCarEditController;
//@property (nonatomic, strong) RWAdminCarEditController *adminCarEditController;

@end
