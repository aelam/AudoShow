//
//  SWPiece.h
//  SpinWheel
//
//  Created by ryan on 13-2-18.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FXLabel;

@interface SWPiece : UIView {
}

@property (nonatomic,readonly) UILabel *titleLabel;
@property (nonatomic,readonly) NSString *identifier;

@property (nonatomic, strong) UIColor *sectorColor;

- (id)initWithImage:(UIImage *)image;

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;


@end
