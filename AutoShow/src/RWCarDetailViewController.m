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

@interface RWCarDetailViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong)MPMoviePlayerController *moviePlayer;
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
//    NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
//    
//    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
//    
//    self.moviePlayer.view.frame = CGRectMake(184, 200, 400, 300);
//    [self.contentView addSubview:self.moviePlayer.view];
//    self.moviePlayer.shouldAutoplay = YES;
//    [self.moviePlayer prepareToPlay];
//    [self.moviePlayer play];
    
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
    
    self.highlightedIndex = 0;
    self.tabBarController.selectedIndex = self.highlightedIndex;
    [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.highlightedIndex inSection:0]];


}


- (IBAction)tapOnScreen:(id)sender {
//    UIViewController *v = [[UIViewController alloc] init];
//    [self presentModalViewController:v animated:YES];
}

- (IBAction)imageBrowserTapped:(id)sender {
    if (self.carImageBrowser == nil) {
        self.carImageBrowser = [self.storyboard instantiateViewControllerWithIdentifier:@"RWCarImageBrowser"];
    }
    [self.contentView addSubview:self.carImageBrowser.view];
    self.carImageBrowser.view.frame = self.contentView.bounds;
    
    
}

- (IBAction)colorChooseTapped:(id)sender {
    if (self.carColorBrowserController == nil) {
        self.carColorBrowserController = [[RWCarColorBrowserController alloc] init];
    }
    [self.contentView addSubview:self.carColorBrowserController.view];
    self.carColorBrowserController.view.frame = self.contentView.bounds;
    
    
}

- (IBAction)carConfigTapped:(id)sender {
    if (self.carConfigController == nil) {
        self.carConfigController = [self.storyboard instantiateViewControllerWithIdentifier:@"RWCarConfigViewController"];
        
    }
    
    
    [self.contentView addSubview:self.carConfigController.view];
    self.carConfigController.view.frame = self.contentView.bounds;
}

- (IBAction)activityTapped:(id)sender {
    if(self.activityController == nil) {
        self.activityController = [[RWActivityViewController alloc] init];
    }
    [self.contentView addSubview:self.activityController.view];
    self.activityController.view.frame = self.contentView.bounds;
    
    
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
    if (indexPath.row == self.highlightedIndex) {
        return;
    } else {
        UICollectionViewCell *oldCell = [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.highlightedIndex inSection:0]];
        [self updateCell:oldCell selected:NO];

        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        [self updateCell:cell selected:YES];

        self.highlightedIndex = indexPath.row;
        self.tabBarController.selectedIndex = self.highlightedIndex;

    }
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
