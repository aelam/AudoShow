//
//  RWCarColorBrowserController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-4-1.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWCarColorBrowserController.h"
#import "RWResourceManager.h"

@interface RWCarColorBrowserController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSArray *carImages;

@end

@implementation RWCarColorBrowserController

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
    
//    self.view.backgroundColor = [UIColor yellowColor];
    
    NSString *imagesPath= [[NSBundle mainBundle] resourcePath];

    NSFileManager *fmanager=[NSFileManager defaultManager];
    NSString *searchPath = [NSString stringWithFormat:@"%@/%@",[RWResourceManager resourcePath],[self.carSeriesInfo objectForKey:@"colors"] ];
	self.carImages = [fmanager contentsOfDirectoryAtPath:searchPath error:nil];

    
    //    self.imageResources
    
	// Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.carImages.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"big_cell" forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    
    NSString *imageFolder = [NSString stringWithFormat:@"%@/%@",[RWResourceManager bundleName],[self.carSeriesInfo objectForKey:@"colors"] ];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",imageFolder, [self.carImages objectAtIndex:indexPath.row]]];
    
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
