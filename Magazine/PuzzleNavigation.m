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
 
 prepareForSegue is where we pass the topic and filename for which we wish to display
 when we transition into a new scene. The new scene will load up by looking at its
 current topic and/or the filename and display content accordingly
 
 **
 */

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showNews"]) {
        News* controller = [segue destinationViewController];
        controller.fileName = @"article";
        controller.currentTopic = _currentTopic;
        controller.pageNumber = 0;
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

/*
    The changeTo___() functions are combined with the notify function to tell
    Puzzle.m to change what puzzle that it is currently displaying
    It is changing the filename and currentTopic property of Puzzle.m
    HOWEVER, usually it would only reload the puzzle it's showing in 
    viewDidLoad() which we cannot access. Instead, we send a notification to
    Puzzle.m that says "Call some code that mimics the code found in viewDidLoad() 
    with the new filename and currentTopic"
 
 */
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

/*This sends a signal to Puzzle.m that says reload with the new filename that we have specified
 in the above functions that say changeTo____()
 */
-(void) notifyWithReason: (NSString*) reason {
    [[NSNotificationCenter defaultCenter]postNotificationName:reason object:nil];
    NSLog(@"Called notification with reason: %@", reason);
}


@end
