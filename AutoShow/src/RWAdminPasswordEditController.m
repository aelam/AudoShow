//
//  RWAdminPasswordEditController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWAdminPasswordEditController.h"
#import "UIAlertView+Quick.h"
#import <CoreData/CoreData.h>
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import "RWManager.h"

@interface RWAdminPasswordEditController ()

@property (nonatomic, retain) NSManagedObjectContext *currentContext;
@property (nonatomic, retain) RWManager *admin;

@end

@implementation RWAdminPasswordEditController

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
}

- (IBAction)updatePasswordAction:(id)sender {

    NSString *oldPassword = self.oldPasswordField.text;
    NSString *newPassword = self.passwordField.text;
    NSString *newPassword2 = self.password2Field.text;

    if (oldPassword == nil || oldPassword.length == 0) {
        [UIAlertView alertWithTitle:@"旧密码不能为空"];
        return;
    } else if (newPassword == nil || newPassword.length == 0) {
        [UIAlertView alertWithTitle:@"新密码不能为空"];
        return;
    } else if (![newPassword isEqualToString:newPassword2]) {
        [UIAlertView alertWithTitle:@"两次密码不一致"];
        return;
    }
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"RWManager" inManagedObjectContext:self.currentContext];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"self.username == %@ AND self.isAdmin == %@", @"admin", [NSNumber numberWithBool:YES]];
    fetchRequest.fetchLimit = 1;
    
    NSError *error = nil;
    NSArray *users = [self.currentContext executeFetchRequest:fetchRequest error:&error];
    self.admin = [users lastObject];
    
    if (![self.admin.password isEqualToString:oldPassword]) {
        [UIAlertView alertWithTitle:@"旧密码不正确"];
        return;
    }
    
    self.admin.password = newPassword;
    [self.currentContext save:&error];
    if (error) {
        [UIAlertView alertWithTitle:@"修改失败"];
    } else {
        [UIAlertView alertWithTitle:@"修改成功"];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
