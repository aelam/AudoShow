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

@interface RWCarImageBrowser () <UIScrollViewDelegate>

@property (nonatomic, strong)NSArray *colorImagesInfo;
@property (nonatomic, strong)NSArray *bigImages;
@property (nonatomic, strong)NSArray *smallImages;


@property (nonatomic, strong)NSIndexPath *selectedIndexPath;



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

    NSFileManager *fmanager=[NSFileManager defaultManager];
    NSString *searchPath = [NSString stringWithFormat:@"%@/%@",[RWResourceManager resourcePath],[self.carSeriesInfo objectForKey:kJingFolderKey]];
    
    
	self.bigImages = [fmanager contentsOfDirectoryAtPath:[searchPath stringByAppendingPathComponent:kJingBigImagesKey] error:nil];
    self.smallImages = [fmanager contentsOfDirectoryAtPath:[searchPath stringByAppendingPathComponent:kJingSmallImagesKey] error:nil];

    self.selectedIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    self.prevPageButton.enabled = NO;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.bigImageView == collectionView) {
        return self.bigImages.count;
    } else {
        return self.smallImages.count;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.bigImageView == collectionView) {
        return 1;
    } else {
        return 1;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = nil;
    if (collectionView == self.bigImageView) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"big_cell" forIndexPath:indexPath];

        UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
        NSString *imageName = [self.bigImages objectAtIndex:indexPath.section];
        NSString *imageInBundle = [NSString stringWithFormat:@"%@/%@/%@/%@",[RWResourceManager bundleName],[self.carSeriesInfo objectForKey:kJingFolderKey],kJingBigImagesKey,imageName];
        imageView.image = [UIImage imageNamed:imageInBundle];
                
    
    } else if (collectionView == self.smallImageView) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"small_cell" forIndexPath:indexPath];
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];

        NSString *imageName = [self.bigImages objectAtIndex:indexPath.section];
        NSString *imageInBundle = [NSString stringWithFormat:@"%@/%@/%@/%@",[RWResourceManager bundleName],[self.carSeriesInfo objectForKey:kJingFolderKey],kJingSmallImagesKey,imageName];
        
        imageView.image = [UIImage imageNamed:imageInBundle];    
    }
    
    if(self.selectedIndexPath.section == indexPath.section && self.selectedIndexPath.row == indexPath.row) {
        cell.selected = YES;
    } else {
        cell.selected = NO;
    }
     
    return cell;
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [self.smallImageView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self.bigImageView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    // deselect oldCell
    UICollectionViewCell *bigCell = [self.bigImageView cellForItemAtIndexPath:self.selectedIndexPath];
    UICollectionViewCell *smallCell = [self.smallImageView cellForItemAtIndexPath:self.selectedIndexPath];
    bigCell.selected = NO;
    smallCell.selected = NO;
//
    
    NSLog(@"oldIndexPath = %@", self.selectedIndexPath);
    NSLog(@"bigCell.selected = %d",bigCell.selected);

    self.selectedIndexPath = indexPath;
    bigCell = [self.bigImageView cellForItemAtIndexPath:self.selectedIndexPath];
    smallCell = [self.smallImageView cellForItemAtIndexPath:self.selectedIndexPath];
    bigCell.selected = YES;
    smallCell.selected = YES;

    
    NSLog(@"newIndexPath = %@", self.selectedIndexPath);
    NSLog(@"bigCell.selected = %d",bigCell.selected);
    
    
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
        [self postScrollExplosion:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self postScrollExplosion:scrollView];
}

- (void)postScrollExplosion:(UIScrollView *)scrollView {
    if (self.bigImageView == scrollView) {
        
        NSIndexPath *firstVisibleIndexPath = [[self.bigImageView indexPathsForVisibleItems] objectAtIndex:0];
        if (firstVisibleIndexPath.section == self.selectedIndexPath.section) {
            return;
        }
        [self.smallImageView scrollToItemAtIndexPath:firstVisibleIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        
        
        UICollectionViewCell *bigCell = [self.bigImageView cellForItemAtIndexPath:self.selectedIndexPath];
        UICollectionViewCell *smallCell = [self.smallImageView cellForItemAtIndexPath:self.selectedIndexPath];
        bigCell.selected = NO;
        smallCell.selected = NO;

        self.selectedIndexPath = firstVisibleIndexPath;
        bigCell = [self.bigImageView cellForItemAtIndexPath:self.selectedIndexPath];
        smallCell = [self.smallImageView cellForItemAtIndexPath:self.selectedIndexPath];
        bigCell.selected = YES;
        smallCell.selected = YES;
        
        
        
    } else {
        [self updatePagingButtonState];

    }

}


#if 0
- (IBAction)prevPage:(id)sender {
    NSInteger section = self.selectedIndexPath.section;
    if(section > 0) {
        section --;
        [self deselectIndexPath:self.selectedIndexPath];
        self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        [self selectIndexPath:self.selectedIndexPath centered:YES];
    }
}

- (IBAction)nextPage:(id)sender {
    NSInteger section = self.selectedIndexPath.section;
    if(section < self.bigImages.count-1) {
        section ++;
        [self deselectIndexPath:self.selectedIndexPath];
        self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        [self selectIndexPath:self.selectedIndexPath centered:YES];
    }
}
#else
- (IBAction)prevPage:(id)sender {
    NSLog(@"offset %@",NSStringFromCGPoint(self.smallImageView.contentOffset));
    NSLog(@"size %@",NSStringFromCGSize(self.smallImageView.contentSize));
    
    CGRect frame;
    frame.origin.x = self.smallImageView.contentOffset.x - self.smallImageView.frame.size.width;
    frame.origin.y = 0;
    
    frame.size = self.smallImageView.frame.size;
    
    [self.smallImageView scrollRectToVisible:frame animated:YES];
    

    
}

- (IBAction)nextPage:(id)sender {
    NSLog(@"offset %@",NSStringFromCGPoint(self.smallImageView.contentOffset));
    NSLog(@"size %@",NSStringFromCGSize(self.smallImageView.contentSize));

    CGRect frame;
    frame.origin.x = self.smallImageView.contentOffset.x +self.smallImageView.frame.size.width;
    frame.origin.y = 0;

    frame.size = self.smallImageView.frame.size;

    [self.smallImageView scrollRectToVisible:frame animated:YES];


    
    
    
    
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self updatePagingButtonState];
}


- (void)updatePagingButtonState {
    if (self.smallImages.count == 0) {
        self.prevPageButton.enabled = NO;
        self.nextPageButton.enabled = NO;
        return;
    }
    
    NSArray *visibleIndexPaths = [self.smallImageView indexPathsForVisibleItems];
    if (visibleIndexPaths.count == 0) {
        return;
    }
    
    NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:0 inSection:(self.smallImages.count-1)];
    
    NSArray *sortedvisibleIndexPaths = [visibleIndexPaths sortedArrayUsingComparator:^(id obj1, id obj2) {
        NSIndexPath *indexPath1 = (NSIndexPath *)obj1;
        NSIndexPath *indexPath2 = (NSIndexPath *)obj2;
        
        return indexPath1.section > indexPath2.section;
    }];

    
    NSIndexPath *firstIndexPath0 = [sortedvisibleIndexPaths objectAtIndex:0];
    NSIndexPath *lastIndexPath0 = [sortedvisibleIndexPaths lastObject];
    
    if (firstIndexPath0.section <= firstIndexPath.section) {
        self.prevPageButton.enabled = NO;
    } else {
        self.prevPageButton.enabled = YES;
    }
    
    if (lastIndexPath0.section >= lastIndexPath.section) {
        self.nextPageButton.enabled = NO;
    } else {
        self.nextPageButton.enabled = YES;
    }
}


#endif

- (void)deselectIndexPath:(NSIndexPath *)oldIndexPath {
    
    if (oldIndexPath.section >= self.bigImages.count) {
        return;
    }
    UICollectionViewCell *bigCell = [self.bigImageView cellForItemAtIndexPath:oldIndexPath];
    UICollectionViewCell *smallCell = [self.smallImageView cellForItemAtIndexPath:oldIndexPath];
    bigCell.selected = NO;
    smallCell.selected = NO;

}

- (void)selectIndexPath:(NSIndexPath *)newIndexPath centered:(BOOL)centered{
    if (newIndexPath.section >= self.bigImages.count) {
        return;
    }
    
    UICollectionViewCell *bigCell = [self.bigImageView cellForItemAtIndexPath:newIndexPath];
    UICollectionViewCell *smallCell = [self.smallImageView cellForItemAtIndexPath:newIndexPath];
    bigCell.selected = YES;
    smallCell.selected = YES;
    
    if (centered) {
        [self.smallImageView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        [self.bigImageView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];        
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
