//
//  RWAddNewClientController.h
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RWClient;

@interface RWClientInfoController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *clientNameField;
@property (weak, nonatomic) IBOutlet UITextField *modelField;
@property (weak, nonatomic) IBOutlet UITextField *chassisField;
@property (weak, nonatomic) IBOutlet UITextField *mobileField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UITextField *postalCodeField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@property (weak, nonatomic) IBOutlet UIButton *prevButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (assign, nonatomic,getter = isReadOnly) BOOL readOnly;


@property (nonatomic,strong) RWClient *currentClient;


@end
