//
//  RWReadOnlyTabBarController.h
//  AutoShow
//
//  Created by Ryan Wang on 13-4-17.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReadOnly <NSObject>

- (void)setReadOnly:(BOOL)flag;

@end


@interface RWReadOnlyTabBarController : UITabBarController


@property (assign, nonatomic,getter = isReadOnly) BOOL readOnly;

@end
