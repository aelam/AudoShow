//
//  RWAdminLoginViewController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWAdminLoginViewController.h"
#import <CoreData/CoreData.h>
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import "RWManager.h"

#define LOGIN_BUTTON_TAG 10101

@interface RWAdminLoginViewController ()

@property (nonatomic, strong) NSManagedObjectContext *currentContext;

@end

@implementation RWAdminLoginViewController

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
    
//    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"RWManager"];
//    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"createAt" ascending:NO];
//    fetchRequest.sortDescriptors = @[descriptor];
    
//    self.fetchedSeriesController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
//                                                                       managedObjectContext:self.currentContext
//                                                                         sectionNameKeyPath:nil
//                                                                                  cacheName:nil];
//
//    [self.fetchedSeriesController performFetch:&error];

    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(UIButton *)sender {
    
    if ([sender isKindOfClass:[UIButton class]] && sender.tag == LOGIN_BUTTON_TAG) {

        NSString *username = self.usernameField.text;
        NSString *password = self.passwordField.text;
        [self.passwordField endEditing:YES];
        [self.usernameField endEditing:YES];
        
        if (username == nil || username.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名不能为空" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alert show];
            
            return NO;
        } else if (password == nil || password.length == 0) {
            NSLog(@"密码为空");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不能为空" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alert show];
            
            return NO;
        } else {
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            fetchRequest.entity = [NSEntityDescription entityForName:@"RWManager" inManagedObjectContext:self.currentContext];
            fetchRequest.predicate = [NSPredicate predicateWithFormat:@"self.username == %@ AND self.password == %@", username, password];
            fetchRequest.fetchLimit = 1;
            
            NSError *error = nil;
            NSArray *users = [self.currentContext executeFetchRequest:fetchRequest error:&error];
            
            if ([users count]==  0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不正确" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
                [alert show];

                return NO;
            }
            
        }

    }
    
    return [super shouldPerformSegueWithIdentifier:identifier sender:sender];
}


//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    [super prepareForSegue:segue sender:sender];
//}

@end
