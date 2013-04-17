//
//  RWAddNewClientController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWClientInfoController.h"
#import "NSString+Extension.h"
#import "RWClient.h"
#import "RWCarColor.h"
#import "RWCarModel.h"
#import "RWTaxInfoController.h"

@interface RWClientInfoController ()

@end

@implementation RWClientInfoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    self.modelField.text = self.currentClient.carColor.model.modelName;
    
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if (isEmpty(self.clientNameField.text) ||
        isEmpty(self.chassisField.text) ||
        isEmpty(self.mobileField.text) ||
        isEmpty(self.addressField.text) ||
        isEmpty(self.postalCodeField.text)
        ) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"标*内容为必填" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        
        
        return NO;
    }
    else return [super shouldPerformSegueWithIdentifier:identifier sender:sender];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    self.currentClient.name = self.clientNameField.text;
    self.currentClient.name = self.clientNameField.text;
    self.currentClient.name = self.clientNameField.text;
    self.currentClient.name = self.clientNameField.text;
    
    
    
    RWTaxInfoController *taxInfoController = (RWTaxInfoController *)segue.destinationViewController;
    taxInfoController.currentClient = self.currentClient;
    
    [super prepareForSegue:segue sender:sender];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
