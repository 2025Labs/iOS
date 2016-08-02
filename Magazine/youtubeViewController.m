//
//  Puzzle.m
//  Magazine
//
//  Created by MBPro on 6/23/16.
//  Copyright © 2016 MBPro. All rights reserved.
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
