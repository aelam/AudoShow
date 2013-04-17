//
//  RWTaxInfoController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWTaxInfoController.h"
#import "RWClient.h"
#import "RWCarColor.h"
#import "RWCarModel.h"
#import "NSString+Extension.h"
#import <CoreData/CoreData.h>
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import "RWCarSeries.h"
#import "RWClient.h"
#import "RWOrderDayType.h"

#define kChannelOffset      1000
#define kFirstBuyOffset     2000
#define kOrderDateOffset    3000


@interface RWTaxInfoController ()

@property (nonatomic, strong) NSManagedObjectContext *currentContext;
@property (nonatomic, weak) UIButton *currentOrderDateButton;



@end

@implementation RWTaxInfoController

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
    
    self.currentContext = [RKManagedObjectStore defaultStore].persistentStoreManagedObjectContext;

//    self.modelField.text = self.currentClient.carColor.model.modelName;
    self.modelField.enabled = NO;
    self.colorField.text = self.currentClient.carColor.colorName;
    self.colorField.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)channelAction:(UIButton *)sender {
    sender.selected = !sender.selected;
   NSInteger channelId = sender.tag - kChannelOffset;
   
    NSLog(@" sender.selected = %d",sender.selected);
    

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"RWChannel" inManagedObjectContext:self.currentContext];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"self.channelId == %d", channelId];
    fetchRequest.fetchLimit = 1;
    
    NSError *error = nil;
    NSArray *channels = [self.currentContext executeFetchRequest:fetchRequest error:&error];
    NSSet *set = [NSSet setWithArray:channels];
    
    if (sender.selected) {
        [self.currentClient addChannels:set];
    } else {
        [self.currentClient removeChannels:set];
    }

    
}

- (IBAction)fisrtBuyAction:(UIButton *)sender {
    UIButton *yes = (UIButton *)[self.view viewWithTag:kFirstBuyOffset + 1];
    UIButton *no = (UIButton *)[self.view viewWithTag:kFirstBuyOffset];
    
    if (sender == yes) {
        no.selected = NO;
        yes.selected = YES;
    } else {
        no.selected = YES;
        yes.selected = NO;
    }
    
    self.currentClient.isFirstlyBuy = [NSNumber numberWithBool:yes.selected];
    
}

- (IBAction)buyTimeAction:(UIButton *)sender {
    NSInteger orderTimeId = sender.tag - kOrderDateOffset;
    if (sender != self.currentOrderDateButton) {
        self.currentOrderDateButton.selected = NO;
        self.currentOrderDateButton = sender;
        self.currentOrderDateButton.selected = YES;
        
        
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        fetchRequest.entity = [NSEntityDescription entityForName:@"RWOrderDayType" inManagedObjectContext:self.currentContext];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"self.typeId == %d", orderTimeId];
        fetchRequest.fetchLimit = 1;
        
        NSError *error = nil;
        NSArray *orderType = [self.currentContext executeFetchRequest:fetchRequest error:&error];
        
        self.currentClient.orderDay = [orderType lastObject];
        
    }
    
}

- (IBAction)submitAction:(id)sender {
    if (!isEmpty(self.budgetField.text)) {
        self.currentClient.budget = self.budgetField.text;
    }
    
    if (!isEmpty(self.oldCarModelField.text)) {
        self.currentClient.oldCar = self.oldCarModelField.text;
    }
    
    if (!isEmpty(self.oldCarEvaluatorField.text)) {
        self.currentClient.oldCarEvaluator = self.oldCarEvaluatorField.text;
    }

    if (!isEmpty(self.oldCarPriceField.text)) {
        self.currentClient.oldCarPrice = [NSNumber numberWithInt:[self.oldCarPriceField.text integerValue]];
    }
    
    if (!isEmpty(self.comparingField.text)) {
        self.currentClient.comparingModel = self.comparingField.text;
    }
    
    
    if([self.currentContext hasChanges]) {
        NSError *eror = nil;
        [self.currentContext save:&eror];
        if (eror) {
            NSLog(@"%@",eror);
            
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            
        }
    }
    
}



@end
