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



@end

@implementation SWPiece

@synthesize titleLabel = _titleLabel;

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
    
    
//    _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    
    UIColor *color = self.sectorColor;//[UIColor orangeColor];
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    
    if ([color respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [color getRed:&red green:&green blue:&blue alpha:&alpha];
    } else {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        red = components[0];
        green = components[1];
        blue = components[2];
        alpha = components[3];
    }
    
    const CGFloat *components = CGColorGetComponents(color.CGColor);

//    
//
    CGContextSetFillColor(context,components);
    CGContextSetLineWidth(context, 5.0f);
    CGContextSetRGBStrokeColor(context, 1,1,1,1);

    
//
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
//
//    
//
    CGContextMoveToPoint(context,  CGRectGetWidth(rect) * 0.5,height);
    CGContextAddArc(context,CGRectGetWidth(rect) * 0.5, height, height, M_PI * 1.5- asin(width * 0.5/ height) ,M_PI * 1.5+ asin(width * 0.5/ height) , 0);

    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextStrokePath(context);

    //clearColor
    red = 1, green = 0.0, blue = 0.0, alpha = 0.0;
    color = [UIColor yellowColor];
    
    if ([color respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [color getRed:&red green:&green blue:&blue alpha:&alpha];
    } else {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        red = components[0];
        green = components[1];
        blue = components[2];
        alpha = components[3];
    }
    
    components = CGColorGetComponents(color.CGColor);
    CGContextSetRGBStrokeColor(context, red,green,blue,alpha);
//
    CGContextMoveToPoint(context,  CGRectGetWidth(rect) * 0.5,height);
//
    CGContextAddArc(context,CGRectGetWidth(rect) * 0.5, height, height * 0.5, M_PI * 1.5- asin(width * 0.5/ height) ,M_PI * 1.5+ asin(width * 0.5/ height) , 0);
//
//    CGContextFillPath(context);

    CGContextDrawPath(context, kCGPathFillStroke);

    CGContextStrokePath(context);
//
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, 30);
}



- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
   
}







//- (void)dealloc {
//    [_titleLabel release];
//    [_identifier release];
//    [super dealloc];
//}

@end
