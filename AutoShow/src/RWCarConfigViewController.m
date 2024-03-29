//
//  RWCarConfigViewController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-4-1.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWCarConfigViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface RWCarConfigViewController ()

@end

@implementation RWCarConfigViewController

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
    NSString *bundlePath = [NSString stringWithFormat:@"showingCars.bundle/%@/config.jpg",folder];
    UIImage *image = [UIImage imageNamed:bundlePath];

    if (image == nil) return;
    
    
    self.imageView = [[UIImageView alloc] initWithImage:image];
    [self.scrollView addSubview:self.imageView];
    
    CGSize imageSize = image.size;
    
//    BOOL isNewUI = [[self.carSeriesInfo objectForKey:@"NEW_UI"] boolValue];

//    if (isNewUI == NO) {
    if (1) {
    
        CGFloat width =  CGRectGetWidth(self.view.frame);
        
        self.imageView.frame = CGRectMake(0, 0, width, width / imageSize.width *imageSize.height);
        [self.scrollView setContentSize:self.imageView.frame.size];
    } else {
        CGFloat height =  CGRectGetHeight(self.view.frame);

        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.frame = CGRectMake(0, 0, imageSize.height / height * imageSize.width , height);
        [self.scrollView setContentSize:self.imageView.frame.size];
        
    }
   
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RWCarConfigViewControllerCell"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //TODO
    
    //show car config image
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
