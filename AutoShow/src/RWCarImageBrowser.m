//
//  RWCarImageBrowser.m
//  AutoShow
//
//  Created by Ryan Wang on 13-4-1.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWCarImageBrowser.h"
#import <QuartzCore/QuartzCore.h>
#import "RWResourceManager.h"

@interface RWCarImageBrowser ()

@property (nonatomic, strong)NSArray *colorImagesInfo;
@property (nonatomic, strong)NSArray *bigImages;
@property (nonatomic, strong)NSArray *smallImages;

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
    
//    self.smallImageView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - 50 - 200, CGRectGetWidth(self.view.frame), 100);
//    
//    [self.view setNeedsLayout];

//    NSString *folderName = [self.carSeriesInfo objectForKey:@"colors"];
  
    NSFileManager *fmanager=[NSFileManager defaultManager];
    NSString *searchPath = [NSString stringWithFormat:@"%@/%@",[RWResourceManager resourcePath],[self.carSeriesInfo objectForKey:kJingFolderKey]];
    
    
	self.bigImages = [fmanager contentsOfDirectoryAtPath:[searchPath stringByAppendingPathComponent:kJingBigImagesKey] error:nil];
    self.smallImages = [fmanager contentsOfDirectoryAtPath:[searchPath stringByAppendingPathComponent:kJingSmallImagesKey] error:nil];

    
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.bigImageView == collectionView) {
        return self.bigImages.count;
    } else {
        return self.smallImages.count;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = nil;
    if (collectionView == self.bigImageView) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"big_cell" forIndexPath:indexPath];
    
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
        NSString *imageName = [self.bigImages objectAtIndex:indexPath.row];
        NSString *imageInBundle = [NSString stringWithFormat:@"%@/%@/%@/%@",[RWResourceManager bundleName],[self.carSeriesInfo objectForKey:kJingFolderKey],kJingBigImagesKey,imageName];
        imageView.image = [UIImage imageNamed:imageInBundle];
    
    } else if (collectionView == self.smallImageView) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"small_cell" forIndexPath:indexPath];
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    
        NSString *imageName = [self.bigImages objectAtIndex:indexPath.row];
        NSString *imageInBundle = [NSString stringWithFormat:@"%@/%@/%@/%@",[RWResourceManager bundleName],[self.carSeriesInfo objectForKey:kJingFolderKey],kJingSmallImagesKey,imageName];
        
        imageView.image = [UIImage imageNamed:imageInBundle];    
    }
//    UILabel *label = [cell viewWithTag:1];
//    label.text = indexPath.description;
    
    
    
    
    return cell;
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
