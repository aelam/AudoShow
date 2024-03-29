//
//  RWCarModelViewController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-28.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWCarModelViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RWCarDetailViewController.h"

@interface RWCarModelViewController ()

@property (nonatomic, strong) NSArray *carSeries;
@property (nonatomic, strong) NSString *bundlePath;


@end

@implementation RWCarModelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.bundlePath = [[NSBundle mainBundle] pathForResource:@"showingCars" ofType:@"bundle"];
    NSString *plistPath = [self.bundlePath stringByAppendingPathComponent:@"CarSeries.plist"];
    self.carSeries = [NSArray arrayWithContentsOfFile:plistPath];
    
    UIViewController *videoController = [self.storyboard instantiateViewControllerWithIdentifier:@"RWHomeVideoController"];
    
    [self presentViewController:videoController animated:NO completion:^{
        
    }];
    
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.carSeries.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"car_model_cell" forIndexPath:indexPath];

    UILabel *label = (UILabel *)[cell viewWithTag:1];
//    UIImageView *foregroundImageView = (UIImageView *)[cell viewWithTag:101];
    UIImageView *backgroundImageView = (UIImageView *)[cell viewWithTag:100];
    
    backgroundImageView.image = [UIImage imageNamed:@"showingCars.bundle/car_series_bg.png"];

    NSDictionary *info = [self.carSeries objectAtIndex:indexPath.row];
    NSString *imageName = [info objectForKey:@"image"];

    
//    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"showingCars.bundle/%@.png",imageName]];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"showingCars.bundle/%@/cover",imageName]];

    backgroundImageView.image = image;
    
    label.text = [info objectForKey:@"title"];;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UICollectionViewCell *cell = (UICollectionViewCell *)sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    NSDictionary *carSeriesInfo = [self.carSeries objectAtIndex:indexPath.row];

    RWCarDetailViewController *contentViewController = (RWCarDetailViewController *)segue.destinationViewController;
    contentViewController.carSeriesInfo = carSeriesInfo;
    
    [super prepareForSegue:segue sender:sender];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
