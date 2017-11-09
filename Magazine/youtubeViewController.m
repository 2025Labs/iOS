//
//  Puzzle.m
//  Magazine
//
//  Created by 2025 Labs on 6/23/16.
//  Copyright @ 2017 2025 Labs LLC. All rights reserved.
//

#import "youtubeViewController.h"
#import "YTPlayerView.h"

@implementation youtubeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.playerView loadWithVideoId:@"lZxJgTiKDis"];
    NSLog(@"youtube loaded");
}




@end
