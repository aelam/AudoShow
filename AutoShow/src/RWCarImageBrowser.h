//
//  RWCarImageBrowser.h
//  AutoShow
//
//  Created by Ryan Wang on 13-4-1.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWCarImageBrowser : UIViewController


@property (nonatomic, strong)IBOutlet UICollectionView *bigImageView;
@property (nonatomic, strong)IBOutlet UICollectionView *smallImageView;


@end