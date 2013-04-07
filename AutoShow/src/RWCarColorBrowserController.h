//
//  RWCarColorBrowserController.h
//  AutoShow
//
//  Created by Ryan Wang on 13-4-1.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWCarColorBrowserController : UIViewController

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong)NSDictionary *carSeriesInfo;

@property (nonatomic, strong) IBOutlet UIImageView *carImageView;

@end
