//
//  RWCarDetailContentController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-30.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWCarDetailContentController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface RWCarDetailContentController ()

@end

@implementation RWCarDetailContentController

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
    
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"2" ofType:@"mov"];
    
    NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
    
    __strong MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];

    player.view.frame = CGRectMake(184, 200, 400, 300);
    [self.view addSubview:player.view];
    player.shouldAutoplay = YES;
    [player prepareToPlay];
    [player play];
	// Do any additional setup after loading the view.
}

- (IBAction)tapOnScreen:(id)sender {
    UIViewController *v = [[UIViewController alloc] init];
    [self presentModalViewController:v animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
