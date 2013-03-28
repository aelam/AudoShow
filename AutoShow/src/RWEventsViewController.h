//
//  RWEventsViewController.h
//  AutoShow
//
//  Created by Ryan Wang on 13-3-28.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWEventsViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

@end
