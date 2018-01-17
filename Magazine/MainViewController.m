//
//  MainViewController.m
//  Magazine
//
//  Created by Melissa Liu on 12/13/17.
//  Copyright © 2017 MBPro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"
#import "News.h"
#import "ViewController.h"
#import "Puzzle.h"
#import "PuzzleNavigation.h"
#import "youtubeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <libpq/libpq-fe.h>
@import WebImage;

@interface MainViewController ()

@end

@implementation MainViewController

 -(void) viewDidLoad {
     [super viewDidLoad];
 }

/*
 **
Used for each button on our main homepage. Passes the correponding string for our incomingSegue variable depending on which button is clicked. 
 **
 */
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showStructures"]) /* structures issue */  {
        // [segue.destinationViewController setIncomingSegue:@"structures"];
    } else if([segue.identifier isEqualToString:@"showEnergy"]) /* energy issue */ {
        [segue.destinationViewController setIncomingSegue:@"energy"];
    }  else if([segue.identifier isEqualToString:@"showComputing"]) /* computing issue */ {
        [segue.destinationViewController setIncomingSegue:@"computing"];
    } else if([segue.identifier isEqualToString:@"showMachines"]) /* machines issue */  {
        // [segue.destinationViewController setIncomingSegue:@"machines"];
    }  else if([segue.identifier isEqualToString:@"showEngineering"]) /* engineering process issue */  {
        // [segue.destinationViewController setIncomingSegue:@"process"];
    }  else if([segue.identifier isEqualToString:@"showMaterials"]) /* materials issue */ {
        // [segue.destinationViewController setIncomingSegue:@"materials"];
    } else if([segue.identifier isEqualToString:@"webStructures"]) {
        // points to web view scene
    }
    
}

@end
