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

@interface RWCarColorBrowserController () <UICollectionViewDataSource, UICollectionViewDelegate,SpinWheelDelegate>

@property (nonatomic, strong) NSArray *carImages;
@property (nonatomic, strong) UISpinWheel *spinWheel;

@property (nonatomic, strong) NSArray *carColorInfo;

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
    
    
//    NSString *imagesPath= [[NSBundle mainBundle] resourcePath];

    
    
//    NSFileManager *fmanager=[NSFileManager defaultManager];
//    NSString *searchPath = [NSString stringWithFormat:@"%@/%@",[RWResourceManager resourcePath],[self.carSeriesInfo objectForKey:@"colors"] ];
//	self.carImages = [fmanager contentsOfDirectoryAtPath:searchPath error:nil];

    
    self.carColorInfo = [self.carSeriesInfo objectForKey:@"colorInfo"];
    
    self.spinWheel = [[UISpinWheel alloc] initWithFrame:CGRectMake(0, 0, 379, 379)];
    
    self.spinWheel.center = CGPointMake(CGRectGetWidth(self.view.frame) * 0.5 ,CGRectGetHeight(self.view.frame)- 200 - 100) ;

//    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint
//                                            constraintWithItem:self.spinWheel
//                                            attribute:NSLayoutAttributeWidth
//                                            relatedBy:NSLayoutRelationEqual
//                                            toItem: nil
//                                            attribute:NSLayoutAttributeNotAnAttribute
//                                            multiplier:1.0f
//                                            constant:200.0f
//                                            ];
    
    
//    [self.view addConstraint:bottomConstraint];

    self.spinWheel.delegate = self;
    
    
    [self.view addSubview:self.spinWheel];
    [self.spinWheel reloadData];
    
    
    [self displayImageForIndex:0];

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
    
    piece.titleLabel.text = [NSString stringWithFormat:@"%d",index];
    
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
    NSString *imageName = [colorItem objectForKey:@"imageName"];
    NSString *colorName = [colorItem objectForKey:@"colorName"];
                              

    NSString *imageFull = [NSString stringWithFormat:@"%@/%@/colors/%@",[RWResourceManager bundleName],[self.carSeriesInfo objectForKey:@"colors"],imageName?imageName:colorName];
    
    self.carImageView.image = [UIImage imageNamed:imageFull];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
