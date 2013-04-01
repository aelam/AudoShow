//
//  RWEventsViewController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-28.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWEventsViewController.h"
#import "RWCarModelViewController.h"

@interface RWEventsViewController ()


@end

@implementation RWEventsViewController

@synthesize collectionView = _collectionView;


- (void)viewDidLoad
{
    [super viewDidLoad];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"event_cell" forIndexPath:indexPath];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",indexPath);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
//    NSIndexPath *indexPath = (NSIndexPath *)[[self.collectionView indexPathsForSelectedItems] lastObject];

//    RWCarModelViewController *carModelViewController = (RWCarModelViewController *)segue.destinationViewController;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
