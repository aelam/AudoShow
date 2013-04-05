//
//  RWAdminPageController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-31.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWAdminPageController.h"
#import "RWAdminCarEditController.h"

@interface RWAdminPageController ()

@property (nonatomic, strong)NSArray *menuTitles;

@end

@implementation RWAdminPageController {
    NSInteger highlightedIndex;
}

@synthesize contentView = _contentView;

@synthesize adminCarEditController = _adminCarEditController;


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

    self.menuTitles = @[@"产品车信息",@"销售顾问",@"经销商信息",@"管理员" ];
    
    
    NSEnumerator *objectEnumerator = self.childViewControllers.objectEnumerator;
    UIViewController *v;
    while (v =[objectEnumerator nextObject]) {
        if ([v isKindOfClass:[UITabBarController class]]) {
            self.tabBarController = (UITabBarController *)v;
            break;
        }
    }
    
    
    highlightedIndex = 0;
    self.tabBarController.selectedIndex = highlightedIndex;
    [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:highlightedIndex inSection:0]];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.menuTitles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bottom_cell" forIndexPath:indexPath];
    
    UILabel *label = (UILabel *)[cell viewWithTag:100];
//    //    UIImageView *foregroundImageView = (UIImageView *)[cell viewWithTag:101];
//    UIImageView *backgroundImageView = (UIImageView *)[cell viewWithTag:100];
//    
//    backgroundImageView.image = [UIImage imageNamed:@"showingCars.bundle/car_series_bg.png"];
//    
//    NSDictionary *info = [self.carSeries objectAtIndex:indexPath.row];
//    NSString *imageName = [info objectForKey:@"image"];
//    
//    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"showingCars.bundle/%@.png",imageName]];
//    backgroundImageView.image = image;
//    
//    label.text = [info objectForKey:@"title"];;
    
    if (highlightedIndex == indexPath.row) {
        cell.backgroundColor = [UIColor blackColor];
    } else {
        cell.backgroundColor = [UIColor redColor];

    }
    
    label.text = [self.menuTitles objectAtIndex:indexPath.row];
    label.textColor = [UIColor whiteColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == highlightedIndex) {
        return;
    } else {
        UICollectionViewCell *oldCell = [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:highlightedIndex inSection:0]];
        oldCell.backgroundColor = [UIColor redColor];
        
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor blackColor];
        
        highlightedIndex = indexPath.row;
        
        self.tabBarController.selectedIndex = highlightedIndex;
        
    }
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
