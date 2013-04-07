//
//  SWPiece.m
//  SpinWheel
//
//  Created by ryan on 13-2-18.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import "SWPiece.h"
#import <QuartzCore/QuartzCore.h>


@interface SWPiece ()

@property (nonatomic,copy) NSString *identifier;


@end

@implementation SWPiece

@synthesize titleLabel = _titleLabel;
@synthesize identifier = _identifier;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
        
    }
    return self;
}

- (id)initWithImage:(UIImage *)image {
    if (self = [super initWithFrame:CGRectZero]) {
        
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor clearColor];
    
    
    _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0.76,0.76,0.76,1.0);
    CGFloat rgba[] = {1,1,0.76,1.0};
    CGContextSetFillColor(context, rgba);
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    

    CGContextMoveToPoint(context,  CGRectGetWidth(rect) * 0.5,height);

    CGContextAddArc(context,CGRectGetWidth(rect) * 0.5, height, height, M_PI * 1.5- asin(width * 0.5/ height) ,M_PI * 1.5+ asin(width * 0.5/ height) , 0);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextStrokePath(context);

    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, 30);
}



- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
   
}







- (void)dealloc {
    [_titleLabel release];
    [_identifier release];
    [super dealloc];
}

@end
