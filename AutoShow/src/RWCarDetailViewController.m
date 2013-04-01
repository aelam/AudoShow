//
//  RWCarDetailViewController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-28.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWCarDetailViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "RWCarImageBrowser.h"
#import "RWCarConfigViewController.h"
#import "RWCarColorBrowserController.h"
#import "RWCarImageBrowser.h"
#import "RWActivityViewController.h"

@interface RWCarDetailViewController ()

@property (nonatomic, strong)MPMoviePlayerController *moviePlayer;
@property (nonatomic, strong) RWCarImageBrowser *imageBrowser;
@property (nonatomic, strong) RWCarConfigViewController *carConfigController;
@property (nonatomic, strong) RWCarColorBrowserController *carColorBrowserController;
@property (nonatomic, strong) RWCarImageBrowser *carImageBrowser;
@property (nonatomic, strong) RWActivityViewController *activityController;

@end

@implementation RWCarDetailViewController

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

    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"2" ofType:@"mp4"];
    
    NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
    
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    
    self.moviePlayer.view.frame = CGRectMake(184, 200, 400, 300);
    [self.contentView addSubview:self.moviePlayer.view];
    self.moviePlayer.shouldAutoplay = YES;
    [self.moviePlayer prepareToPlay];
    [self.moviePlayer play];

}


- (IBAction)tapOnScreen:(id)sender {
    UIViewController *v = [[UIViewController alloc] init];
    [self presentModalViewController:v animated:YES];
}

- (IBAction)imageBrowserTapped:(id)sender {
    if (self.carImageBrowser == nil) {
        self.carImageBrowser = [self.storyboard instantiateViewControllerWithIdentifier:@"RWCarImageBrowser"];
    }
    [self.contentView addSubview:self.carImageBrowser.view];
    self.carImageBrowser.view.frame = self.contentView.bounds;
    
    
}

- (IBAction)colorChooseTapped:(id)sender {
    if (self.carColorBrowserController == nil) {
        self.carColorBrowserController = [[RWCarColorBrowserController alloc] init];
    }
    [self.contentView addSubview:self.carColorBrowserController.view];
    self.carColorBrowserController.view.frame = self.contentView.bounds;
    
    
}

- (IBAction)carConfigTapped:(id)sender {
    if (self.carConfigController == nil) {
        self.carConfigController = [self.storyboard instantiateViewControllerWithIdentifier:@"RWCarConfigViewController"];
        
    }
    
    
    [self.contentView addSubview:self.carConfigController.view];
    self.carConfigController.view.frame = self.contentView.bounds;
}

- (IBAction)activityTapped:(id)sender {
    if(self.activityController == nil) {
        self.activityController = [[RWActivityViewController alloc] init];
    }
    [self.contentView addSubview:self.activityController.view];
    self.activityController.view.frame = self.contentView.bounds;
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
