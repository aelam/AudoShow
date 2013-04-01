//
//  RWCarImageBrowser.m
//  AutoShow
//
//  Created by Ryan Wang on 13-4-1.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWCarImageBrowser.h"
#import <QuartzCore/QuartzCore.h>

@interface RWCarImageBrowser ()

@end

@implementation RWCarImageBrowser

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
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.view.layer.borderWidth = 3;
    self.view.layer.borderColor = [UIColor redColor].CGColor;
//    UIView *yellowView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 50 - 200, CGRectGetWidth(self.view.frame), 100)];
//    yellowView.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:yellowView];
    
    self.smallImageView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - 50 - 200, CGRectGetWidth(self.view.frame), 100);
    
    [self.view setNeedsLayout];
//
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = nil;
    if (collectionView == self.bigImageView) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"big_cell" forIndexPath:indexPath];
    } else if (collectionView == self.smallImageView) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"small_cell" forIndexPath:indexPath];
    }
    UILabel *label = [cell viewWithTag:1];
    label.text = indexPath.description;
    
    return cell;
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
