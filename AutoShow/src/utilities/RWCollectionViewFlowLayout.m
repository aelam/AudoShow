//
//  RWCollectionViewFlowLayout.m
//  AutoShow
//
//  Created by Ryan Wang on 13-4-8.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWCollectionViewFlowLayout.h"

@implementation RWCollectionViewFlowLayout

- (id)init {
    if (self = [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    
    return self;
}


-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
