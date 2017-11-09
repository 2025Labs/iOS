//
//  MainHomepageController.m
//  Magazine
//
//  Created by Melissa Liu on 11/9/17.
//  Copyright © 2017 MBPro. All rights reserved.
//

#import "MainHomepageController.h"
#import "ViewController.h"
#import "Puzzle.h"
#import "News.h"
#import "IGCMenu.h"
#import "youtubeViewController.h"
#import "PuzzleNavigation.h"
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

@interface MainHomepageController ()

@end

@implementation MainHomepageController
    AVAudioPlayer *_audioPlayer;

-(void) viewDidLoad {
    [super viewDidLoad];
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [_audioPlayer play];

}

@end
