//
//  RWCarDetailViewController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-28.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWCarDetailViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "RWCarImageBrowser.h"
#import "RWCarConfigViewController.h"
#import "RWCarColorBrowserController.h"
#import "RWCarImageBrowser.h"
#import "RWActivityViewController.h"
#import "RWResourceManager.h"
#import "UIViewController+Navigation.h"

@interface RWCarDetailViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;
@property (nonatomic, strong) RWCarColorBrowserController *carColorBrowserController;
@property (nonatomic, strong) RWCarImageBrowser *carImageBrowser;
@property (nonatomic, strong) RWCarConfigViewController *carConfigController;
@property (nonatomic, strong) RWActivityViewController *activityController;

@property (nonatomic, assign) NSInteger highlightedIndex;
@property (nonatomic, strong) NSArray *menuTitles;
@property (nonatomic, strong) UITabBarController *tabBarController;

//@property (nonatomic, strong) RWBrowserContainer *tabBarController;


@end

@implementation RWCarDetailViewController

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

//    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"2" ofType:@"mp4"];
//    
    
    
    self.menuTitles = @[@"车型颜色",@"车型配置",@"精美照片",@"活动信息"];
    
    NSEnumerator *objectEnumerator = self.childViewControllers.objectEnumerator;
    UIViewController *v;
    while (v =[objectEnumerator nextObject]) {
        if ([v isKindOfClass:[UITabBarController class]]) {
            self.tabBarController = (UITabBarController *)v;
            break;
        }
    }
    
    self.carColorBrowserController = [self.tabBarController.viewControllers objectAtIndex:0];
    self.carConfigController = [self.tabBarController.viewControllers objectAtIndex:1];
    self.carImageBrowser = [self.tabBarController.viewControllers objectAtIndex:2];
    self.activityController = [self.tabBarController.viewControllers objectAtIndex:3];
    
    self.carColorBrowserController.carSeriesInfo = self.carSeriesInfo;
    self.carConfigController.carSeriesInfo = self.carSeriesInfo;
    self.carImageBrowser.carSeriesInfo = self.carSeriesInfo;
    self.activityController.carSeriesInfo = self.carSeriesInfo;
    

    
    
    self.contentView.hidden = YES;
    [self playVideo];
    
    [self selectIndex:-1];
    
}

- (void)selectIndex:(NSInteger)index {
    

    // deselect old index
    if (self.highlightedIndex >= 0) {
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.highlightedIndex inSection:0]];
        [self updateCell:cell selected:NO];
    }

    
    self.highlightedIndex = index;
    if (index < 0) {
        self.redBorder.hidden = YES;
        self.contentView.hidden = YES;
    } else {
        self.redBorder.hidden = NO;
        self.contentView.hidden = NO;
        self.tabBarController.selectedIndex = self.highlightedIndex;
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.highlightedIndex inSection:0]];
        
        [self updateCell:cell selected:YES];
    }
}

- (void)playVideo {
    NSLog(@"%@",self.carSeriesInfo);
    
    NSString *videoPath = [NSString stringWithFormat:@"%@/video/%@.mp4",[RWResourceManager resourcePath],[self.carSeriesInfo objectForKey:@"video"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:videoPath] == NO) {
        return;
    }
    
    NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
    
   self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
  
    
   self.moviePlayer.view.frame = CGRectMake(-80,0, 768+160, 585+150);
   [self.view addSubview:self.moviePlayer.view];
    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
   self.moviePlayer.shouldAutoplay = YES;
   [self.moviePlayer prepareToPlay];
   [self.moviePlayer play];

//        [self.videoContentView addSubview:self.moviePlayer.view];
    [self.view insertSubview:self.moviePlayer.view belowSubview:self.touchScreenButton];
    
    [self.view bringSubviewToFront:self.homeButton];
    [self.view bringSubviewToFront:self.backButton];
}


- (IBAction)tapOnScreen:(id)sender {
    self.contentView.hidden = NO;
    [self.view sendSubviewToBack: self.moviePlayer.view];
}

- (IBAction)backButtonAcion:(id)sender {
    if (self.highlightedIndex < 0) {
        self.contentView.hidden = NO;
        [self selectIndex:self.tabBarController.selectedIndex];
        
    } else  {
        self.contentView.hidden = YES;
        [self selectIndex:-1];
//        self.highlightedIndex = -1;

    }
    
    
}

- (IBAction)homeButtonAcion:(id)sender {
    [self popToCarSeriesController:sender];
    
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.menuTitles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"menu_cell" forIndexPath:indexPath];
    
    UILabel *label = (UILabel *)[cell viewWithTag:100];

    label.text = [self.menuTitles objectAtIndex:indexPath.row];

    [self updateCell:cell selected:self.highlightedIndex == indexPath.row];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == self.highlightedIndex) {
//        return;
//    } else {
//        UICollectionViewCell *oldCell = [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.highlightedIndex inSection:0]];
//        [self updateCell:oldCell selected:NO];
//
//        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//        [self updateCell:cell selected:YES];
//
//        self.highlightedIndex = indexPath.row;
    
        [self selectIndex:indexPath.row];
        self.tabBarController.selectedIndex = self.highlightedIndex;

//    }
}

- (void)updateCell:(UICollectionViewCell *)cell selected:(BOOL)selected{
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:101];
    if (selected) {
        imageView.image = [UIImage imageNamed:@"show_menu_on"];
    } else {
        imageView.image = [UIImage imageNamed:@"show_menu_off"];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
