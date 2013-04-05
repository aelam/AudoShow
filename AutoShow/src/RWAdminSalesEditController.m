//
//  RWAdminSalesEditController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWAdminSalesEditController.h"
#import <CoreData/CoreData.h>
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import "RWManager.h"
#import "UIAlertView+Quick.h"
#import "IdentifierValidator.h"

@interface RWAdminSalesEditController () <NSFetchedResultsControllerDelegate, UITabBarControllerDelegate , UITableViewDataSource>

@property (nonatomic, retain) NSManagedObjectContext *currentContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) RWManager *selectedSales;

@end

@implementation RWAdminSalesEditController

@synthesize tableView;

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

    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"RWManager"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"self.isAdmin == %@",[NSNumber numberWithBool:NO]];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"username" ascending:NO];
    fetchRequest.sortDescriptors = @[descriptor];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.currentContext sectionNameKeyPath:nil cacheName:nil];
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    if (error) {
        NSLog(@"error : %@", error);
    }
    
    self.fetchedResultsController.delegate = self;
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.fetchedResultsController.fetchedObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"sales_cell"];
    
    RWManager *manager = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text =  manager.username;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedSales = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
}



- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [tableView beginUpdates];
}



- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
        
    if (type == NSFetchedResultsChangeInsert) {
        [tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (type == NSFetchedResultsChangeDelete) {
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        default:
            break;
    }
    
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
    
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addSalesAction:(id)sender {
    NSString *name = self.salesNameField.text;
    NSString *password = self.salesPasswordField.text;
    NSString *phone = self.salesPasswordField.text;
    if (name == nil || name.length == 0) {
        [UIAlertView alertWithTitle:@"用户名不能为空"];
    } else if (password == nil || password.length == 0) {
        [UIAlertView alertWithTitle:@"密码不能为空"];
    } else if (phone == nil || phone.length == 0) {
        [UIAlertView alertWithTitle:@"手机不能为空"];
    } else {
        
        RWManager *sales = (RWManager *)[NSEntityDescription insertNewObjectForEntityForName:@"RWManager" inManagedObjectContext:self.currentContext];
        
        sales.username = name;
        sales.password = password;

        
        NSError *error1= nil;
        
        if ([self.currentContext hasChanges]) {
            [self.currentContext save:&error1];
            if (error1) {
                NSLog(@"%@", error1);
            }
        }

        
    }
    
}


- (IBAction)updatePasswordAction:(id)sender {
    if (self.selectedSales == nil) {
        [UIAlertView alertWithTitle:@"请选择需要修改密码的人员"];
        return;
    }
    
    NSString *newPassword = self.passwordField.text;
    NSString *newPassword2 = self.password2Field.text;
    
    if (newPassword == nil || newPassword.length == 0) {
        [UIAlertView alertWithTitle:@"新密码不能为空"];
        return;
    } else if (![newPassword isEqualToString:newPassword2]) {
        [UIAlertView alertWithTitle:@"两次密码不一致"];
        return;
    }
    
    self.selectedSales.password = newPassword;
    NSError *error = nil;
    [self.currentContext save:&error];
    if (error) {
        [UIAlertView alertWithTitle:@"修改失败"];
    } else {
        [UIAlertView alertWithTitle:@"修改成功"];
    }

}

- (IBAction)updatePhoneAction:(id)sender {
    if (self.selectedSales == nil) {
        [UIAlertView alertWithTitle:@"请选择需要修改密码的人员"];
        return;
    }
    
    NSString *phone = self.phoneField.text;
    
    
    
    if (phone == nil || phone.length == 0) {
        [UIAlertView alertWithTitle:@"手机号码不能为空"];
        return;
    }
    BOOL isPhoneValid = [IdentifierValidator isValid:IdentifierTypePhone value:phone];
    if (!isPhoneValid) {
        [UIAlertView alertWithTitle:@"手机号码不合法"];
        return;
        
    }
    self.selectedSales.phone = phone;
    NSError *error = nil;
    [self.currentContext save:&error];
    if (error) {
        [UIAlertView alertWithTitle:@"修改失败"];
    } else {
        [UIAlertView alertWithTitle:@"修改成功"];
    }
    
}

@end
