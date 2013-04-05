//
//  RWAdminSalesEditController.h
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWAdminSalesEditController : UIViewController 

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// add sales tags
@property (weak, nonatomic) IBOutlet UITextField *salesNameField;
@property (weak, nonatomic) IBOutlet UITextField *salesPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *salesPhoneField;

- (IBAction)addSalesAction:(id)sender;

// update password tags
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *password2Field;

- (IBAction)updatePasswordAction:(id)sender;


// update mobile tags
@property (weak, nonatomic) IBOutlet UITextField *phoneField;

- (IBAction)updatePhoneAction:(id)sender;

@end
