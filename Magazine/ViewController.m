//
//  ViewController.m
//  Magazine
//
//  Created by MBPro on 6/22/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import "ViewController.h"
#import "Puzzle.h"
#import "News.h"
#import "IGCMenu.h"
#import "youtubeViewController.h"
#import "PuzzleNavigation.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController
    AVAudioPlayer *_audioPlayer;

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageNumber = 0;
    _maxPageNumber = 4;
    _currentTopic = @"computing";
    // Do any additional setup after loading the view, typically from a nib.
    /*
    [self.playerView loadWithVideoId:@"lZxJgTiKDis"];
    [self prepareNavigationMenu];
    [self prepareMenu];
     */
    NSLog(@"Calling viewDidLoad");
    [self setupScrollview];
    [self setupAudio];
    [self setCurrentActivity];
    _isScrollingEnabled = false;
    UIStoryboard *mainStoryboard = self.storyboard;

    
    ViewController *mapController = [mainStoryboard instantiateViewControllerWithIdentifier:@"mapScene"];
    
    mapController.view.frame = CGRectMake (0,0,self.scrollView.frame.size.width,self.scrollView.frame.size.height);
    
    [self addChildViewController:mapController];
    [mapController didMoveToParentViewController:self];
    [self.scrollView addSubview:mapController.view];
    
    
    Puzzle *puzzleController = [mainStoryboard instantiateViewControllerWithIdentifier:@"PuzzleScene"];
    puzzleController.filename = @"cipher.png";
    puzzleController.currentTopic = @"computing";
    CGRect frame = puzzleController.view.frame;
    frame.origin.x = 0;
    puzzleController.view.frame = CGRectMake (self.view.frame.size.width,0,self.scrollView.frame.size.width,self.scrollView.frame.size.height);
    

    puzzleController.view.contentMode = UIViewContentModeScaleToFill;
    
    [self addChildViewController:puzzleController];
    [puzzleController didMoveToParentViewController:self];
    puzzleController.view.autoresizesSubviews = YES;
    [self.scrollView addSubview:puzzleController.view];
    
    
    Puzzle *puzzleController2 = [mainStoryboard instantiateViewControllerWithIdentifier:@"PuzzleScene"];
    puzzleController2.filename = @"howfastistheinternet.png";
    puzzleController2.currentTopic = @"computing";
    
    puzzleController2.view.frame = CGRectMake (self.view.frame.size.width*2,0,self.scrollView.frame.size.width,self.scrollView.frame.size.height);
    
    [self addChildViewController:puzzleController2];
    [puzzleController2 didMoveToParentViewController:self];
    [self.scrollView addSubview:puzzleController2.view];

    
    youtubeViewController *youtubeController = [mainStoryboard instantiateViewControllerWithIdentifier:@"youtubeScene"];

    youtubeController.view.frame = CGRectMake (self.view.frame.size.width*3, self.view.frame.size.height/10, self.view.frame.size.width, self.view.frame.size.height/2-35);
    
    [self addChildViewController:youtubeController];
    [youtubeController didMoveToParentViewController:self];
    [self.scrollView addSubview:youtubeController.view];
    
    }

-(void) setCurrentActivity {
    switch (_pageNumber) {
        case 0:
            _currentActivity.text = @"Computing Around the World";
            break;
        case 1:
            _currentActivity.text = @"Cipher Puzzle";
            break;
        case 2:
            _currentActivity.text = @"News: How Fast is the Internet?";
            break;
        case 3:
            _currentActivity.text = @"Computing for Kids";
            break;
        default:
            break;
    }
}

-(void) setupScrollview {
    self.scrollView.scrollEnabled = NO;
     self.scrollView.pagingEnabled = YES;
    [self.scrollView setAlwaysBounceVertical:NO];

}

-(IBAction)nextScreen:(id)sender {
    if(_pageNumber + 1 < _maxPageNumber) {
    [_audioPlayer play];
    _pageNumber += 1;
    CGRect frame = _scrollView.frame;
    frame.origin.x = self.view.frame.size.width * _pageNumber;
    NSLog(@"Now: %f", frame.origin.x);
    [_scrollView setContentOffset:CGPointMake(frame.origin.x, 0) animated:YES];
        NSLog(@"sound");

    [self setCurrentActivity];

    }
}

-(IBAction)prevScreen:(id)sender {
    if(_pageNumber - 1 >= 0) {
        [_audioPlayer play];
    _pageNumber -= 1;
    CGRect frame = _scrollView.frame;
    frame.origin.x = self.view.frame.size.width * _pageNumber;
    NSLog(@"Now: %f", frame.origin.x);

    [_scrollView setContentOffset:CGPointMake(frame.origin.x, 0) animated:YES];
        [self setCurrentActivity];

    }

}

/*
-(void) prepareNavigationMenu {
    self.logoImage.contentMode =UIViewContentModeScaleAspectFit;
    self.puzzleButton.layer.cornerRadius = self.puzzleButton.frame.size.width/2;
    self.gameButton.layer.cornerRadius = self.gameButton.frame.size.width/2;
    self.triviaButton.layer.cornerRadius = self.triviaButton.frame.size.width/2;
    
}
-(void) prepareMenu {
    _menuButton.clipsToBounds = YES;
    _menuButton.layer.cornerRadius = self.menuButton.frame.size.width / 2;
    [_menuButton setImage:[UIImage imageNamed:@"circleChevronUp.png"] forState:UIControlStateNormal];
    
    if(_menu == nil) {
        _menu = [[IGCMenu alloc] init];
    }
    _menu.menuButton = self.menuButton;
    _menu.menuSuperView = self.view;
    _menu.disableBackground = YES;
    _menu.numberOfMenuItem = 3;
    _menu.menuRadius = 125; //How far apart the menu displays
    _menu.menuHeight = 90; //Size of the circles
    _menu.menuItemsNameArray = [NSArray arrayWithObjects:@"Computing", @"Energy", @"Materials", nil];
    _isMenuActive = false;
    _menu.delegate = self;

}
 */

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [_audioPlayer play];
    if([segue.identifier isEqualToString:@"showNews"]) {
        News* controller = [segue destinationViewController];
        controller.fileName = @"article";
        controller.currentTopic = _currentTopic;
        controller.pageNumber = 0;
    } else if([segue.identifier isEqualToString:@"showPuzzle"]) {
        PuzzleNavigation* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
        controller.fileName = @"wordsearch.png";
    } else if([segue.identifier isEqualToString:@"showWorld"]) {
        News* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
    }  else if([segue.identifier isEqualToString:@"showFirstArticle"]) {
        News* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
        controller.pageNumber = 0; //figure out how to automate this
    }  else if([segue.identifier isEqualToString:@"showSecondArticle"]) {
        News* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
        controller.pageNumber = 9; //figure out how to automate this
    }   else if([segue.identifier isEqualToString:@"showFillInTheBlank"]) {
        PuzzleNavigation* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
        controller.fileName = @"fillintheblank.png";
    }   else if([segue.identifier isEqualToString:@"showMaterial"]) {
        PuzzleNavigation* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
        controller.fileName = @"material.png";
    }
}

-(IBAction) enableDisableScrolling:(id) sender {
    NSLog(@"Calling enableDisableScrolling. _isScrollingEnabled = %d", _isScrollingEnabled);
    if(_isScrollingEnabled) {
        //Scrolling is enabled -> Make it disabled
        self.scrollView.scrollEnabled = NO;
        [self notifyWithReason:@"enableDrawing"];
        //Disable Scrolling and send signal to embedded view controller that you cannot draw
        _isScrollingEnabled = false;
    } else {
        self.scrollView.scrollEnabled = YES;
        [self notifyWithReason:@"disableDrawing"];
        NSLog(@"Scrolling is enabled? %d", self.scrollView.scrollEnabled);
        _isScrollingEnabled = true;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    _pageNumber = 0;
    CGRect frame = _scrollView.frame;
    frame.origin.x = 0;
    [self setCurrentActivity];
}
/*
- (IBAction)menuPressed:(id)sender {
    NSLog(@"Menu Pressed");
    if(_isMenuActive) {
        [_menu hideCircularMenu];
        _isMenuActive = false;
        [self.menuButton setImage:[UIImage imageNamed:@"circleChevronUp.png"] forState:UIControlStateNormal];
    } else {
        [_menu showCircularMenu];
        _isMenuActive = true;
        [self.menuButton setImage:[UIImage imageNamed:@"circleChevronDown.png"] forState:UIControlStateNormal];

    }
}

 
- (void)igcMenuSelected:(NSString *)selectedMenuName atIndex:(NSInteger)index{

    switch (index) {
        case 0:
            NSLog(@"Transition to Computing");
            _currentTopic = @"computing";
            [_menu hideCircularMenu];
            _isMenuActive = false;
            [self.menuButton setImage:[UIImage imageNamed:@"circleChevronUp.png"] forState:UIControlStateNormal];
            break;
        case 1:
            NSLog(@"Transition to Energy");
            _currentTopic = @"energy";
            [_menu hideCircularMenu];
            _isMenuActive = false;
            [self.menuButton setImage:[UIImage imageNamed:@"circleChevronUp.png"] forState:UIControlStateNormal];
            break;
        case 2:
            NSLog(@"Transition to Materials");
            _currentTopic = @"materials";
            [_menu hideCircularMenu];
            _isMenuActive = false;
            [self.menuButton setImage:[UIImage imageNamed:@"circleChevronUp.png"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

*/


-(void) notifyWithReason: (NSString*) reason {
    [[NSNotificationCenter defaultCenter]postNotificationName:reason object:nil];
    NSLog(@"Called notification with reason: %@", reason);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) setupAudio{
    // Construct URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/drum01.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Create audio player object and initialize with URL to sound
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
}


@end
