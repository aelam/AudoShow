//
//  RWCarDetailViewController.h
//  AutoShow
//
//  Created by Ryan Wang on 13-3-28.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWCarDetailViewController : UIViewController


@property (nonatomic, strong)NSDictionary *carSeriesInfo;
@property (nonatomic,strong) IBOutlet UIView *redBorder;
@property (nonatomic,strong) IBOutlet UIView *topBar;
@property (nonatomic,strong) IBOutlet UIView *videoContentView;
@property (nonatomic,strong) IBOutlet UIView *contentView;
@property (nonatomic,strong) IBOutlet UIButton *touchScreenButton;
@property (nonatomic,strong) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong) IBOutlet UIImageView *jingShadow; //精美图片sharow


@property (nonatomic,strong) IBOutlet UIButton *homeButton;
@property (nonatomic,strong) IBOutlet UIButton *backButton;

@property (nonatomic,strong) IBOutlet UIView *bottomView;
@property (nonatomic,strong) IBOutlet UIView *bottomBackgroundView;


- (IBAction)tapOnScreen:(id)sender;

- (IBAction)backButtonAcion:(id)sender;
- (IBAction)homeButtonAcion:(id)sender;

@end
