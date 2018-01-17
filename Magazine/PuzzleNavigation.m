//
//  PuzzleNavigation.m
//  Magazine
//
//  Created by 2025 Labs on 6/24/16.
//  Copyright @ 2017 2025 Labs LLC. All rights reserved.
//

#import "PuzzleNavigation.h"
#import "Puzzle.h"
#import "IGCMenu.h"
#import <libpq/libpq-fe.h>
#import "News.h"
#import "ViewController.h"
//#import "MainViewContoller.h"

@import WebImage;

@implementation PuzzleNavigation

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    UIStoryboard *mainStoryboard = self.storyboard;
    
    _puzzleController = [mainStoryboard instantiateViewControllerWithIdentifier:@"PuzzleScene"];
    _puzzleController.currentTopic = _currentTopic;
    _puzzleController.filename = _fileName;
    
    _puzzleController.view.frame = CGRectMake (0,0,self.scrollView.frame.size.width,self.scrollView.frame.size.height);
    NSLog(@"width: %f height: %f", self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    _puzzleController.view.contentMode = UIViewContentModeScaleToFill;
    

    [self addChildViewController:_puzzleController];
    [_puzzleController didMoveToParentViewController:self];
    _puzzleController.view.autoresizesSubviews = YES;
    [self.scrollView addSubview:_puzzleController.view];
    

}

/*
 **
 
 prepareForSegue is where we pass the  and filename for which we wish to display
 when we transition into a new scene. The new scene will load up by looking at its
 current topic and/or the filename and display content accordingly
 UPDATE (12/14/17): Added functionality that checks for incoming segue
                    to base images by topic.
 **
 */

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showNews"]) {
        if([_incomingSegue isEqual:@"computing"]){
            [segue.destinationViewController setIncomingSegue:@"computing"];
            News* controller = [segue destinationViewController];
            _currentTopic = @"computing";
            controller.note = @"article";
            controller.currentTopic = _currentTopic;
            controller.pageNumber = 0;
        }  else if([_incomingSegue isEqual:@"energy"]){
            [segue.destinationViewController setIncomingSegue:@"energy"];
            News* controller = [segue destinationViewController];
            _currentTopic = @"energy";
            controller.note = @"article";
            controller.currentTopic = _currentTopic;
            controller.pageNumber = 0;
        }
    } else if([segue.identifier isEqualToString:@"showPuzzle"]) {
        if([_incomingSegue isEqual:@"computing"]) {
            [segue.destinationViewController setIncomingSegue:@"computing"];
            PuzzleNavigation* controller = [segue destinationViewController];
            controller.currentTopic = _currentTopic;
            controller.fileName = @"wordsearch.png";
            NSLog(@"Segue to Puzzle Nav");
        } else if ([_incomingSegue isEqual:@"energy"]) {
            [segue.destinationViewController setIncomingSegue:@"energy"];
            PuzzleNavigation* controller = [segue destinationViewController];
            controller.currentTopic = _currentTopic;
            controller.fileName = @"wordsearchenergy.png";
            NSLog(@"Segue to Puzzle Nav");
        }
    } else if([segue.identifier isEqualToString:@"showWorld"]) {
        News* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
    }
}

/*
    The changeTo___() functions are combined with the notify function to tell
    Puzzle.m to change what puzzle that it is currently displaying
    It is changing the filename and currentTopic property of Puzzle.m
    HOWEVER, usually it would only reload the puzzle it's showing in 
    viewDidLoad() which we cannot access. Instead, we send a notification to
    Puzzle.m that says "Call some code that mimics the code found in viewDidLoad() 
    with the new filename and currentTopic"
    UPDATE (12/14/17): Added functionality that checks for incoming segue
                       to base images by topic. 
 
 */
-(IBAction)changeToFillInTheBlank:(id)sender {
    if([_incomingSegue isEqual:@"computing"]) {
        NSLog(@"start change to fillintheblank");
        _puzzleController.filename = @"fillintheblank.png";
        _puzzleController.currentTopic = @"computing";
        [self notifyWithReason:@"reload"];
    } else if([_incomingSegue isEqual:@"energy"]){
        NSLog(@"start change to fillintheblank");
        _puzzleController.filename = @"fillintheblank_energy.png";
        _puzzleController.currentTopic = @"energy";
        [self notifyWithReason:@"reload"];
    }
}

-(IBAction)changeToWordsearch:(id)sender {
    if([_incomingSegue isEqual:@"computing"]) {
        _puzzleController.filename = @"wordsearch.png";
        _puzzleController.currentTopic = @"computing";
        [self notifyWithReason:@"reload"];
    } else if([_incomingSegue isEqual:@"energy"]){
        NSLog(@"start change to fillintheblank");
        _puzzleController.filename = @"wordsearchenergy.png";
        _puzzleController.currentTopic = @"energy";
        [self notifyWithReason:@"reload"];
    }
}

-(IBAction)changeToMaterial:(id)sender {
    if([_incomingSegue isEqual:@"computing"]) {
        _puzzleController.filename = @"material.png";
        _puzzleController.currentTopic = @"computing";
        [self notifyWithReason:@"reload"];
    } else if([_incomingSegue isEqual:@"energy"]){
        _puzzleController.filename = @"materials_energyissue.png";
        _puzzleController.currentTopic = @"energy";
        [self notifyWithReason:@"reload"];
    }
}

-(IBAction)changeToCipher:(id)sender {
     if([_incomingSegue isEqual:@"computing"]) {
         _puzzleController.filename = @"cipher.png";
         _puzzleController.currentTopic = @"computing";
         [self notifyWithReason:@"reload"];
     } else if([_incomingSegue isEqual:@"energy"]){
         _puzzleController.filename = @"cipher_energy.png";
         _puzzleController.currentTopic = @"energy";
         [self notifyWithReason:@"reload"];
     }
}

/*This sends a signal to Puzzle.m that says reload with the new filename that we have specified
 in the above functions that say changeTo____()
 */
-(void) notifyWithReason: (NSString*) reason {
    [[NSNotificationCenter defaultCenter]postNotificationName:reason object:nil];
    NSLog(@"Called notification with reason: %@", reason);
}


@end
