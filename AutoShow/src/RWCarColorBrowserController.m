//
//  RWCarColorBrowserController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-4-1.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWCarColorBrowserController.h"
#import "RWResourceManager.h"
#import "UISpinWheel.h"
#import "SWPiece.h"
#import "UIColor+Hex.h"
#import <QuartzCore/QuartzCore.h>

@interface RWCarColorBrowserController () <UICollectionViewDataSource, UICollectionViewDelegate,SpinWheelDelegate>

@property (nonatomic, strong) NSArray *carImages;
@property (nonatomic, strong) UISpinWheel *spinWheel;

@property (nonatomic, strong) NSArray *carColorInfo;
@property (nonatomic, assign) BOOL isNewUI;
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
    self.isNewUI = [[self.carSeriesInfo objectForKey:@"NEW_UI"] boolValue];

    
    if (self.isNewUI) {

        self.carImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 900)];
        self.carImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:self.carImageView];
        
    }
        
    self.carColorInfo = [self.carSeriesInfo objectForKey:@"colorInfo"];
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chex014"]];
    bg.center =  CGPointMake(CGRectGetWidth(self.view.frame) * 0.5 ,CGRectGetHeight(self.view.frame)- 200 - 130);
    [self.view addSubview:bg];
    bg.userInteractionEnabled = YES;
    self.spinWheel = [[UISpinWheel alloc] initWithFrame:CGRectMake(0, 0, 354, 354)];

    
    UIImageView *arrow_bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_bg"]];
    arrow_bg.center =  CGPointMake(CGRectGetWidth(bg.frame) * 0.5 ,7);
    [bg addSubview:arrow_bg];
    
    
    self.spinWheel.center = CGPointMake(CGRectGetWidth(bg.bounds) * 0.5, CGRectGetHeight(bg.bounds) * 0.5);
    [bg addSubview:self.spinWheel];
    
    self.spinWheel.delegate = self;
    
    
    [bg addSubview:self.spinWheel];
    [self.spinWheel reloadData];

    
    UIImageView *arrow_fg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_fg"]];
    arrow_fg.center =  CGPointMake(CGRectGetWidth(bg.frame) * 0.5 ,9);
    [bg addSubview:arrow_fg];

    
    UIImageView *fg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chex012"]];
    fg.center = CGPointMake(CGRectGetWidth(bg.bounds) * 0.5 + 19, CGRectGetHeight(bg.bounds) * 0.5 -70);
    [bg addSubview:fg];
    
    [self displayImageForIndex:0];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isNewUI) {
//        self.carImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 1024);
//        self.carImageView.frame = CGRectMake(0, 0, 20,20);
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.carColorInfo.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"big_cell" forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    
    NSDictionary *colorItem = [self.carColorInfo objectAtIndex:indexPath.row];
    NSString *imageName = [colorItem objectForKey:@"imageName"];

    NSString *colorName = [colorItem objectForKey:@"colorName"];
    
    
    NSString *imageFull = [NSString stringWithFormat:@"%@/%@/colors/%@",[RWResourceManager bundleName],[self.carSeriesInfo objectForKey:@"colors"],imageName?imageName:colorName];
    imageView.image = [UIImage imageNamed:imageFull];
    
    
    return cell;
}

- (NSInteger)numberOfPieceInSpinWheel:(UISpinWheel *)SpinWheel {
    return self.carColorInfo.count;
}

- (SWPiece *)spinWheel:(UISpinWheel *)spinWheel pieceForIndex:(NSInteger)index {
    SWPiece *piece = [[SWPiece alloc] initWithFrame:CGRectMake(0, 0, 50, 100)];
    
    NSDictionary *colorItem = [self.carColorInfo objectAtIndex:index];
    NSString *colorString = [colorItem objectForKey:@"colorValue"];
    UIColor *color = [UIColor colorWithHexString:colorString];

    piece.sectorColor = color;
    
    if (self.isNewUI) {
        NSString *colorName = [colorItem objectForKey:@"colorName"];
        piece.titleLabel.text = colorName;
        piece.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    }
    

    
    return piece;
}

- (void)spinWheel:(UISpinWheel *)spinWheel didSpinToIndex:(NSInteger)index {
    NSLog(@"%d", index);
    
//    cell.selected = YES;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = YES;
    [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
    
    [self displayImageForIndex:index];
}


- (void)displayImageForIndex:(NSInteger)index {
    
    if (self.carColorInfo.count <= index) {
        return;
    }
    NSDictionary *colorItem = [self.carColorInfo objectAtIndex:index];
    NSString *colorImage = [colorItem objectForKey:@"colorImage"];
    if (colorImage == nil || colorImage.length == 0) {
        colorImage = [colorItem objectForKey:@"colorName"];
    }
    if (colorImage == nil || colorImage.length == 0) {
        colorImage = [colorItem objectForKey:@"imageName"];
    }

    NSString *imageFull = [NSString stringWithFormat:@"%@/%@/colors/%@",[RWResourceManager bundleName],[self.carSeriesInfo objectForKey:@"colors"],colorImage];
    
    self.carImageView.image = [UIImage imageNamed:imageFull];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
