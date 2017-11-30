//
//  MainHomepageController.m
//  Magazine
//
//  Created by Melissa Liu on 11/9/17.
//  Copyright © 2017 MBPro. All rights reserved.
//

#import "MainHomepageController.h"
#import "News.h"
#import "ViewController.h"
#import "Puzzle.h"
#import "PuzzleNavigation.h"
#import "youtubeViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MainHomepageController ()

@end

@implementation MainHomepageController

-(void) viewDidLoad {
    [super viewDidLoad];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showStructures"]) {
        ViewController* controller = [segue destinationViewController];
        _currentTopic = @"computing";
        controller.note = @"article";
        controller.currentTopic = _currentTopic;
        controller.pageNumber = 0;
    } else if([segue.identifier isEqualToString:@"showEnergy"]) {
        ViewController* controller = [segue destinationViewController];
        _currentTopic = @"energy";
        controller.note = @"puzzle";
        controller.currentTopic = _currentTopic;
        controller.pageNumber = 0;
    }  else if([segue.identifier isEqualToString:@"showComputing"]) {
       // data
    } else if([segue.identifier isEqualToString:@"showMachines"]) {
        ViewController* controller = [segue destinationViewController];
        _currentTopic = @"energy";
        controller.note = @"article";
        controller.currentTopic = _currentTopic;
        controller.pageNumber = 0;
    }  else if([segue.identifier isEqualToString:@"showEngineering"]) {
        ViewController* controller = [segue destinationViewController];
        _currentTopic = @"computing";
        controller.note = @"puzzle";
        controller.currentTopic = _currentTopic;
        controller.pageNumber = 0;
    }  else if([segue.identifier isEqualToString:@"showMaterials"]) {
        ViewController* controller = [segue destinationViewController];
        // data
    }

}

@end

