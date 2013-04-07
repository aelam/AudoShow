//
//  RWCarDetailContentController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-3-30.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWCarDetailContentController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "RWCarImageBrowser.h"
#import "RWCarConfigViewController.h"

@interface RWCarDetailContentController ()

@property (nonatomic, strong)MPMoviePlayerController *moviePlayer;
@property (nonatomic, strong) RWCarImageBrowser *imageBrowser;
@property (nonatomic, strong) RWCarConfigViewController *carConfigController;

@end

@implementation RWCarDetailContentController

@synthesize moviePlayer;


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
    [self.view addSubview:self.moviePlayer.view];
    self.moviePlayer.shouldAutoplay = YES;
    [self.moviePlayer prepareToPlay];
    [self.moviePlayer play];
	// Do any additional setup after loading the view.
}

- (IBAction)tapOnScreen:(id)sender {
//    UIViewController *v = [[UIViewController alloc] init];
//    [self presentModalViewController:v animated:YES];
}

- (IBAction)imageBrowserTapped:(id)sender {
    
}

- (IBAction)colorChooseTapped:(id)sender {
    
}

- (IBAction)carConfigTapped:(id)sender {
    if (self.carConfigController == nil) {
        self.carConfigController = [[RWCarConfigViewController alloc] init];
        
    }
    
    [self.view addSubview:self.carConfigController.view];
}

- (IBAction)activityTapped:(id)sender {
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
