//
//  RWTaxInfoController.h
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RWClient;

@interface RWTaxInfoController : UIViewController

@property (nonatomic,strong) RWClient *currentClient;

@property (weak, nonatomic) IBOutlet UITextField *modelField;
@property (weak, nonatomic) IBOutlet UITextField *colorField;
@property (weak, nonatomic) IBOutlet UITextField *budgetField;

@property (weak, nonatomic) IBOutlet UITextField *oldCarReplaceField;
@property (weak, nonatomic) IBOutlet UITextField *comparingField;
@property (weak, nonatomic) IBOutlet UITextField *othersField;

@property (weak, nonatomic) IBOutlet UITextField *oldCarModelField;
@property (weak, nonatomic) IBOutlet UITextField *oldCarPriceField;
@property (weak, nonatomic) IBOutlet UITextField *oldCarEvaluatorField;
@property (assign, nonatomic,getter = isReadOnly) BOOL readOnly;


- (IBAction)channelAction:(id)sender;

- (IBAction)fisrtBuyAction:(id)sender;

- (IBAction)buyTimeAction:(id)sender;

- (IBAction)submitAction:(id)sender;


@end
