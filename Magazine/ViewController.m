//
//  ViewController.m
//  Magazine
//
//  Created by MBPro on 6/22/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import "ViewController.h"
#import "Puzzle.h"
#import "ArticleViewing.h"
#import "IGCMenu.h"
#import "youtubeViewController.h"
#import "PuzzleNavigation.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController
    AVAudioPlayer *_audioPlayer;

-(void) setupAudio{
    // Construct URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/drum01.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Create audio player object and initialize with URL to sound
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageNumber = 0;
    _maxPageNumber = 4;
    _currentTopic = @"computing";
    // Do any additional setup after loading the view, typically from a nib.
    [self.playerView loadWithVideoId:@"lZxJgTiKDis"];
    [self prepareNavigationMenu];
    [self prepareMenu];
    [self prepareHomepage];
    [self setupScrollview];
    [self setupAudio];
    
    UIStoryboard *mainStoryboard = self.storyboard;

    Puzzle *puzzleController = [mainStoryboard instantiateViewControllerWithIdentifier:@"PuzzleScene"];
    puzzleController.fileName = @"cipher.png";
    puzzleController.currentTopic = @"computing";
    CGRect frame = puzzleController.view.frame;
    frame.origin.x = 0;
    puzzleController.view.frame = CGRectMake (0,0,self.scrollView.frame.size.width,self.scrollView.frame.size.height);
    

    puzzleController.view.contentMode = UIViewContentModeScaleToFill;
    
    [self addChildViewController:puzzleController];
    [puzzleController didMoveToParentViewController:self];
    puzzleController.view.autoresizesSubviews = YES;
    [self.scrollView addSubview:puzzleController.view];

    

    
    ViewController *mapController = [mainStoryboard instantiateViewControllerWithIdentifier:@"mapScene"];
    
    mapController.view.frame = CGRectMake (self.view.frame.size.width,0,self.scrollView.frame.size.width,self.scrollView.frame.size.height);
    
    [self addChildViewController:mapController];
    [mapController didMoveToParentViewController:self];
    [self.scrollView addSubview:mapController.view];
    
    
    Puzzle *puzzleController2 = [mainStoryboard instantiateViewControllerWithIdentifier:@"PuzzleScene"];
    puzzleController2.fileName = @"howfastistheinternet.png";
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

-(void) setupScrollview {
    self.scrollView.scrollEnabled = NO;
     self.scrollView.pagingEnabled = YES;
    [self.scrollView setAlwaysBounceVertical:NO];
    
}

-(IBAction)nextScreen:(id)sender {
    if(_pageNumber + 1 < _maxPageNumber) {
    _pageNumber += 1;
    CGRect frame = _scrollView.frame;
    frame.origin.x = 768 * _pageNumber;
    NSLog(@"Now: %f", frame.origin.x);
    [_scrollView setContentOffset:CGPointMake(frame.origin.x, 0) animated:YES];
        NSLog(@"sound");

    [_audioPlayer play];

    }
}

-(IBAction)prevScreen:(id)sender {
    if(_pageNumber - 1 >= 0) {
    _pageNumber -= 1;
    CGRect frame = _scrollView.frame;
    frame.origin.x = 768 * _pageNumber;
    NSLog(@"Now: %f", frame.origin.x);

    [_scrollView setContentOffset:CGPointMake(frame.origin.x, 0) animated:YES];
        NSLog(@"sound");
    [_audioPlayer play];

    }

}

-(void) prepareHomepage {
    
    UILabel *label1 = _topArticle.titleLabel;
    label1.adjustsFontSizeToFitWidth = YES;
    UILabel *label2 = _bottomArticle.titleLabel;
    label2.adjustsFontSizeToFitWidth = YES;
    if([_currentTopic isEqualToString:@"computing"]) {
        [_coverPage setTitle:@"Cover Page: Computing" forState:UIControlStateNormal];
        [_bottomArticle setTitle: @"History of the Internet" forState: UIControlStateNormal];
        [_topArticle setTitle: @"Internet of Things" forState: UIControlStateNormal];
        _leftArticlePageToJumpTo = 0;
        _rightArticlePageToJumpTo = 2;
    } else if([_currentTopic isEqualToString:@"energy"]) {
        [_coverPage setTitle: @"Cover Page: Energy" forState:UIControlStateNormal];
        [_bottomArticle setTitle: @"The Grid?" forState: UIControlStateNormal];
        [_topArticle setTitle: @"Solar Power Overload" forState: UIControlStateNormal];
        _leftArticlePageToJumpTo = 0;
        _rightArticlePageToJumpTo = 2;
    }
}

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

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [_audioPlayer play];
    if([segue.identifier isEqualToString:@"showNews"]) {
        ArticleViewing* controller = [segue destinationViewController];
        controller.fileName = @"article";
        controller.currentTopic = _currentTopic;
    } else if([segue.identifier isEqualToString:@"showPuzzle"]) {
        PuzzleNavigation* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
        controller.fileName = @"wordsearch.png";
        NSLog(@"Segue to Puzzle Nav");
    } else if([segue.identifier isEqualToString:@"showWorld"]) {
        ArticleViewing* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
    }  else if([segue.identifier isEqualToString:@"showLeftArticle"]) {
        ArticleViewing* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
        controller.pageToJumpTo = _leftArticlePageToJumpTo;
    }  else if([segue.identifier isEqualToString:@"showRightArticle"]) {
        ArticleViewing* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
        controller.pageToJumpTo = _rightArticlePageToJumpTo;
    }
}

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
            [self prepareHomepage];
            break;
        case 1:
            NSLog(@"Transition to Energy");
            _currentTopic = @"energy";
            [_menu hideCircularMenu];
            _isMenuActive = false;
            [self.menuButton setImage:[UIImage imageNamed:@"circleChevronUp.png"] forState:UIControlStateNormal];
            [self prepareHomepage];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
