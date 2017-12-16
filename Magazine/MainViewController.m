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
 
 prepareForSegue is where we pass the topic and filename for which we wish to display
 when we transition into a new scene. The new scene will load up by looking at its
 current topic and/or the filename/note and display content accordingly
 Note: the data displayed here is loaded into the view controller by
 clicking a button which represents a different issue in the
 magazine.
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
