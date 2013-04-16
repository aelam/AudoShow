//
//  RWActivityViewController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-4-1.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWActivityViewController.h"

@interface RWActivityViewController ()

@end

@implementation RWActivityViewController

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

    NSString *folder = [self.carSeriesInfo objectForKey:@"colors"];
    NSString *bundlePath = [NSString stringWithFormat:@"showingCars.bundle/%@/activity.jpg",folder];
    UIImage *image = [UIImage imageNamed:bundlePath];
    
    if (image == nil) return;
    
    self.imageView = [[UIImageView alloc] initWithImage:image];
    [self.scrollView addSubview:self.imageView];
    
    CGSize imageSize = image.size;
    
    CGFloat width =  CGRectGetWidth(self.view.frame);
    
    self.imageView.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.frame = CGRectMake(0, 0, width, width / imageSize.width *imageSize.height);
    [self.scrollView setContentSize:self.imageView.frame.size];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
