//
//  PuzzleNavigation.m
//  Magazine
//
//  Created by MBPro on 6/24/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import "PuzzleNavigation.h"
#import "Puzzle.h"
#import "IGCMenu.h"
#import <libpq/libpq-fe.h>
#import "News.h"
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


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showNews"]) {
        News* controller = [segue destinationViewController];
        controller.fileName = @"article";
        controller.currentTopic = _currentTopic;
    } else if([segue.identifier isEqualToString:@"showPuzzle"]) {
        PuzzleNavigation* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
        controller.fileName = @"wordsearch.png";
        NSLog(@"Segue to Puzzle Nav");
    } else if([segue.identifier isEqualToString:@"showWorld"]) {
        News* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
    }
}


-(IBAction)changeToFillInTheBlank:(id)sender {
    NSLog(@"start change to fillintheblank");
    _puzzleController.filename = @"fillintheblank.png";
    _puzzleController.currentTopic = @"computing";
    [self notifyWithReason:@"reload"];
}

-(IBAction)changeToWordsearch:(id)sender {
    _puzzleController.filename = @"wordsearch.png";
    _puzzleController.currentTopic = @"computing";
    [self notifyWithReason:@"reload"];
    
}

-(IBAction)changeToMaterial:(id)sender {
    _puzzleController.filename = @"material.png";
    _puzzleController.currentTopic = @"computing";
    [self notifyWithReason:@"reload"];
}

-(IBAction)changeToCipher:(id)sender {
    _puzzleController.filename = @"cipher.png";
    _puzzleController.currentTopic = @"computing";
    [self notifyWithReason:@"reload"];
}

-(void) notifyWithReason: (NSString*) reason {
    [[NSNotificationCenter defaultCenter]postNotificationName:reason object:nil];
    NSLog(@"Called notification with reason: %@", reason);
}


@end
