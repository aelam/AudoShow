//
//  UISpinWheel.h
//  SpinWheel2
//
//  Created by ryan on 13-4-3.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWPiece;
@class UISpinWheel;
@protocol SpinWheelDelegate <NSObject>

- (NSInteger)numberOfPieceInSpinWheel:(UISpinWheel *)SpinWheel;
- (SWPiece *)spinWheel:(UISpinWheel *)spinWheel pieceForIndex:(NSInteger)index;

@optional
- (void)spinWheel:(UISpinWheel *)spinWheel didSpinToIndex:(NSInteger)index;

@end

@interface UISpinWheel : UIView {
    NSMutableSet *_recycledPieces;

}

@property (nonatomic,assign)  id <SpinWheelDelegate> delegate;
@property (nonatomic,assign)  NSInteger     currentIndex;
//@property (nonatomic,assign)  CGFloat     startAngle;
@property (nonatomic,strong)  UIView      *contentView;


@property (nonatomic, assign) UIColor *sectorColor;

- (void)reloadData;

- (SWPiece *)pieceForIndex:(NSInteger)index;


@end
