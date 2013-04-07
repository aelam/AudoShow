//
//  UISpinWheel.m
//  SpinWheel2
//
//  Created by ryan on 13-4-3.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import "UISpinWheel.h"
#import "SWPiece.h"
#import <QuartzCore/QuartzCore.h>

static NSInteger const kPieceTagOffset = 2000;

@interface UISpinWheel ()

@property (nonatomic,assign)  NSInteger pieceCount;

@end

@implementation UISpinWheel {
    NSInteger _fakeIndex;

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor yellowColor].CGColor;
        
        self.contentView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.contentView];
        
        _recycledPieces = [[NSMutableSet alloc] initWithCapacity:0];

        
        UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rotateGestureAction:)];
//        recognizer.delegate = self;
        [recognizer setMinimumNumberOfTouches:1];
        [recognizer setMaximumNumberOfTouches:1];
        [self addGestureRecognizer:recognizer];

    }
    return self;
}


- (void)reloadData {
    if (self.delegate == nil) {
        return;
    }
    self.pieceCount = [self.delegate numberOfPieceInSpinWheel:self];
    
    if(self.pieceCount <= 0) {
        return;
    }
    
    [self recyleAllPieces];
    
    
    _contentView.transform = CGAffineTransformIdentity;
    CGFloat diameter = MIN(CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds));
    CGFloat angleSize = 2 * M_PI / self.pieceCount;
    
    
    for(int i = 0; i < self.pieceCount; i++){
        SWPiece *piece = [self.delegate spinWheel:self pieceForIndex:i];
        
        piece.bounds = CGRectMake(0, 0, diameter * sin(angleSize * 0.5) , diameter * 0.5);
        
        piece.tag = kPieceTagOffset + i;
        
        piece.layer.anchorPoint = CGPointMake(0.5,1);
        piece.layer.position = CGPointMake(diameter* 0.5,
                                           diameter* 0.5);
        piece.transform = CGAffineTransformMakeRotation(angleSize*i);
        
        [piece setNeedsDisplay];
        [_contentView addSubview:piece];
        
        [piece setSelected:!!(_currentIndex == i) animated:YES];
        
    }

    
    
}

- (void)recyleAllPieces {
    for(SWPiece *piece in _contentView.subviews) {
        if ([piece isKindOfClass:[SWPiece class]]) {
            [_recycledPieces addObject:piece];
            [piece removeFromSuperview];
        }
    }
    
}


- (void)rotateGestureAction:(UIPanGestureRecognizer*)recognizer {
    
    CGPoint currentPoint = [recognizer locationInView:[_contentView superview]];
    CGPoint translate = [recognizer translationInView:[_contentView superview]];
    
    CGFloat x = currentPoint.x;
    CGFloat y = currentPoint.y;
    CGFloat x0 = currentPoint.x - translate.x;
    CGFloat y0 = currentPoint.y - translate.y;
    
    
    
    
    CGFloat rotateRadian = 0;
    CGFloat rotateRadian0 = 0;
//    CGFloat radians = atan2f(_contentView.transform.b, _contentView.transform.a);
    rotateRadian  =  atan((y - _contentView.center.y)/(x - _contentView.center.x));  // new radians
    rotateRadian0 =  atan((y0 - _contentView.center.y)/(x0 - _contentView.center.x)); // old radians
    
    CGFloat offset = 0;
    

    offset = rotateRadian - rotateRadian0;
    
    if (offset <= - 2.8) {
        offset = offset + M_PI;
    } else if (offset >= 2.8) {
        offset = offset - M_PI;
    }
    
    CGFloat angleSize = 2 * M_PI / self.pieceCount;
    
    if(recognizer.state == UIGestureRecognizerStateChanged || recognizer.state == UIGestureRecognizerStateBegan) {
        _contentView.transform = CGAffineTransformRotate(_contentView.transform, offset);
        
        
    } else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded) {
        
        if (0) {
            
        } else {
            CGFloat radians = atan2f(_contentView.transform.b, _contentView.transform.a);
            NSInteger index = nearbyint(radians / angleSize);
            [self _adjustWheelToFakeIndex:index  animated:YES];
            NSInteger newIndex = nearbyint(radians / angleSize);
            NSInteger newLogicalIndex = [self logicalIndexWithCycleIndex:newIndex];
            
        }
    }
    [recognizer setTranslation:CGPointZero inView:[_contentView superview]];

}

- (NSInteger)logicalIndexWithCycleIndex:(NSInteger)cycleIndex {
    
    NSInteger realIndex = cycleIndex % _pieceCount;
    
    if (realIndex < 0) {
        realIndex = fabs(realIndex);
    } else {
        realIndex = _pieceCount - realIndex;
    }
    
    if (realIndex == _pieceCount) {
        realIndex = 0;
    }
    return realIndex;
}

- (void)setFakeIndex:(NSInteger)fakeIndex animated:(BOOL)animated {
    CGFloat angleSize = 2 * M_PI / _pieceCount;
    
    _fakeIndex = fakeIndex;
    
    // update currentIndex
    _currentIndex = [self logicalIndexWithCycleIndex:fakeIndex];
    
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            _contentView.transform = CGAffineTransformMakeRotation(angleSize * fakeIndex);
        } completion:^(BOOL finished) {
            if ([self.delegate respondsToSelector:@selector(spinWheel:didSpinToIndex:)]) {
                [self.delegate spinWheel:self didSpinToIndex:_currentIndex];
            }
        }];
        [UIView animateWithDuration:0.2 animations:^{
            _contentView.transform = CGAffineTransformMakeRotation(angleSize * fakeIndex);
        }];
    } else {
        _contentView.transform = CGAffineTransformMakeRotation(angleSize * fakeIndex);
        if ([self.delegate respondsToSelector:@selector(spinWheel:didSpinToIndex:)]) {
            [self.delegate spinWheel:self didSpinToIndex:_currentIndex];
        }
    }
}

- (void)_adjustWheelToFakeIndex:(NSInteger)fakeIndex animated:(BOOL)animated{
    CGFloat angleSize = 2 * M_PI / _pieceCount;
    
    _fakeIndex = fakeIndex;
    
    // update currentIndex
    _currentIndex = [self logicalIndexWithCycleIndex:fakeIndex];
    
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            _contentView.transform = CGAffineTransformMakeRotation(angleSize * fakeIndex);
        } completion:^(BOOL finished) {
            if ([self.delegate respondsToSelector:@selector(spinWheel:didSpinToIndex:)]) {
                [self.delegate spinWheel:self didSpinToIndex:_currentIndex];
            }
        }];
        [UIView animateWithDuration:0.2 animations:^{
            _contentView.transform = CGAffineTransformMakeRotation(angleSize * fakeIndex);
        }];
    } else {
        _contentView.transform = CGAffineTransformMakeRotation(angleSize * fakeIndex);
        if ([self.delegate respondsToSelector:@selector(spinWheel:didSpinToIndex:)]) {
            [self.delegate spinWheel:self didSpinToIndex:_currentIndex];
        }
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    
}


- (SWPiece *)pieceForIndex:(NSInteger)index {
    NSInteger tag = index + kPieceTagOffset;
    for(SWPiece *piece in _contentView.subviews) {
        if ([piece isKindOfClass:[SWPiece class]] && piece.tag == tag) {
            return piece;
        }
    }
    return nil;
}


@end
