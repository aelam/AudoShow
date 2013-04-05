//
//  UIAlertView+Quick.m
//  AutoShow
//
//  Created by Ryan Wang on 13-4-5.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "UIAlertView+Quick.h"

@implementation UIAlertView (Quick)

+ (UIAlertView *)alertWithTitle:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alert show];
    return alert;
}
@end
