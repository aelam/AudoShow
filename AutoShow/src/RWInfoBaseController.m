//
//  RWInfoBaseController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWInfoBaseController.h"

@interface RWInfoBaseController ()



@end

@implementation RWInfoBaseController {
    NSArray *tabTitles;
    
    NSInteger highlightedIndex;
    UITabBarController *tabBarController;
}

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
    
    tabTitles = [NSArray arrayWithObjects:@"车系/车型/颜色",@"客户信息"/*,@"金融信息"*/,@"税费",nil];
    highlightedIndex = 0;
    
    tabBarController = [self.childViewControllers lastObject];
    
    tabBarController.selectedIndex = highlightedIndex;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [tabTitles count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tab_cell" forIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell viewWithTag:1];

    label.text = [tabTitles objectAtIndex:indexPath.row];

    if (indexPath.row == highlightedIndex) {
        cell.backgroundColor = [UIColor redColor];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == highlightedIndex) {
        return;
    } else {
        UICollectionViewCell *oldCell = [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:highlightedIndex inSection:0]];
        oldCell.backgroundColor = [UIColor blackColor];
        
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor redColor];
        
        highlightedIndex = indexPath.row;
        
        tabBarController.selectedIndex = highlightedIndex;

    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
