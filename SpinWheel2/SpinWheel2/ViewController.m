//
//  ViewController.m
//  SpinWheel2
//
//  Created by ryan on 13-4-3.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import "ViewController.h"
#import "UISpinWheel.h"
#import "SWPiece.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UISpinWheel *wheel = [[UISpinWheel alloc] initWithFrame:CGRectMake(50, 200, 200, 200)];
    
    wheel.delegate = self;
    [self.view addSubview:wheel];
    
    [wheel reloadData];
    
    
}


- (NSInteger)numberOfPieceInSpinWheel:(UISpinWheel *)SpinWheel {
    return 6;
}


- (SWPiece *)spinWheel:(UISpinWheel *)spinWheel pieceForIndex:(NSInteger)index {
    SWPiece *piece = [[SWPiece alloc] initWithFrame:CGRectMake(0, 0, 50, 100)];
    piece.titleLabel.text = [NSString stringWithFormat:@"%d",index];
    
//    piece.sectorColor = 
    return piece;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
