//
//  RWHomeVideoController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-4-16.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWHomeVideoController.h"
#import "RWResourceManager.h"
#import <MediaPlayer/MediaPlayer.h>

@interface RWHomeVideoController ()
@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;

@end

@implementation RWHomeVideoController

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

    [self playVideo];
    
    
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopVideo];
}

- (void)stopVideo {
    [self.moviePlayer stop];

}

- (void)playVideo {
    
    NSString *videoPath = [NSString stringWithFormat:@"%@/video/home.mp4",[RWResourceManager resourcePath]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:videoPath] == NO) {
        return;
    }
    
    NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
    
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    
    [self.moviePlayer setRepeatMode:MPMovieRepeatModeOne];
    
    self.moviePlayer.view.frame = CGRectMake(-80,0, 768+160, 585+150);
    [self.contentView addSubview:self.moviePlayer.view];
    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
    self.moviePlayer.shouldAutoplay = YES;
    [self.moviePlayer prepareToPlay];
    [self.moviePlayer play];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
